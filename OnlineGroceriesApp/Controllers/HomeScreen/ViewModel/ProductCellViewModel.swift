//
//  ProductCellViewModel.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 19/08/24.
//
import SwiftUI
import Firebase
import FirebaseFirestore

class ProductCellViewModel: ObservableObject {
    @Published var cartQuantity: Int = 0
    @Published var showQuantity: Bool = false
    @Published var isFavorite: Bool = false
    @Published var product: Product
    let db = Firestore.firestore()
    var userId: String? {
       Auth.auth().currentUser?.uid
   }
    init(product: Product) {
        self.product = product
        fetchCartQuantity()
        checkIfFavorite()
    }
//    init(product: Product) {
//        self.product = product
//        checkIfFavorite()
//    }
    
    init(cartItem: CartItem) {
            self.product = Product(id: cartItem.id, name: cartItem.name, price: cartItem.price, img: cartItem.img)
            self.cartQuantity = cartItem.quantity
            self.showQuantity = true
        }
    func fetchCartQuantity() {
        guard let userID = getCurrentUserID() else { return }

        let userCartRef = Firestore.firestore().collection("userCart").document(userID)
        
        userCartRef.getDocument { [weak self] (document, error) in
            if let document = document, document.exists {
                let cartItems = document.data()?["cartItems"] as? [[String: Any]] ?? []
                
                if let item = cartItems.first(where: { $0["productID"] as? String == self?.product.id }) {
                    self?.cartQuantity = item["quantity"] as? Int ?? 0
                    self?.showQuantity = true
                } else {
                    self?.showQuantity = false
                }
            }
        }
    }
    
    func addProductToCart() {
        guard let userID = getCurrentUserID() else {
            print("Error: User not logged in")
            return
        }

        // Immediately update UI state
        cartQuantity += 1
        showQuantity = true
        
        let userCartRef = db.collection("userCart").document(userID)
        
        userCartRef.getDocument { [weak self] (document, error) in
            guard let self = self else { return }
            if let document = document, document.exists {
                var cartItems = document.data()?["cartItems"] as? [[String: Any]] ?? []
                
                if let index = cartItems.firstIndex(where: { $0["productID"] as? String == self.product.id }) {
                    cartItems[index]["quantity"] = (cartItems[index]["quantity"] as? Int ?? 0) + 1
                } else {
                    let newItem = [
                        "productID": self.product.id ?? "",
                        "name": self.product.name,
                        "price": self.product.price,
                        "quantity": 1,
                        "img": self.product.img
                    ] as [String : Any]
                    cartItems.append(newItem)
                }

                userCartRef.updateData([
                    "cartItems": cartItems
                ]) { error in
                    if let error = error {
                        print("Error updating cart: \(error.localizedDescription)")
                    } else {
                        print("Product quantity updated/added successfully.")
                        // The UI is already updated above
                    }
                }

            } else {
                let cartItem = [
                    "productID": self.product.id ?? "",
                    "name": self.product.name,
                    "price": self.product.price,
                    "quantity": 1,
                    "img": self.product.img
                ] as [String : Any]
                
                userCartRef.setData([
                    "cartItems": [cartItem]
                ]) { error in
                    if let error = error {
                        print("Error creating user cart: \(error.localizedDescription)")
                    } else {
                        print("User cart created and product added successfully.")
                        // The UI is already updated above
                    }
                }
            }
        }
    }

    
    
    func incrementQuantity() {
            cartQuantity += 1
            updateQuantityInCart()
        }

    func decrementQuantity() {
        if cartQuantity > 1 {
            cartQuantity -= 1
            updateQuantityInCart()
        } else if cartQuantity == 1 {
            cartQuantity = 0
            showQuantity = false
            removeProductFromCart()
        }
    }

    
     func updateQuantityInCart() {
            guard let userID = getCurrentUserID() else { return }
            let userCartRef = Firestore.firestore().collection("userCart").document(userID)
            
            userCartRef.getDocument { [weak self] (document, error) in
                if let document = document, document.exists {
                    var cartItems = document.data()?["cartItems"] as? [[String: Any]] ?? []
                    
                    if let index = cartItems.firstIndex(where: { $0["productID"] as? String == self?.product.id }) {
                        cartItems[index]["quantity"] = self?.cartQuantity
                        userCartRef.updateData(["cartItems": cartItems]) { error in
                            if let error = error {
                                print("Error updating quantity: \(error.localizedDescription)")
                            }
                        }
                    }
                }
            }
        }

    
    func removeProductFromCart() {
           guard let userID = getCurrentUserID() else {
               print("Error: User not logged in")
               return
           }

           // Immediately update UI state
           showQuantity = false
           
           let userCartRef = db.collection("userCart").document(userID)
           
           userCartRef.getDocument { [weak self] (document, error) in
               guard let self = self else { return }
               if let document = document, document.exists {
                   var cartItems = document.data()?["cartItems"] as? [[String: Any]] ?? []

                   if let index = cartItems.firstIndex(where: { $0["productID"] as? String == self.product.id }) {
                       cartItems.remove(at: index)
                       
                       // Update the cartItems array in MyCartViewModel
                       if let cartItemIndex = MyCartViewModel.shared.cartItems.firstIndex(where: { $0.id == self.product.id }) {
                           MyCartViewModel.shared.cartItems.remove(at: cartItemIndex)
                       }
                       
                       if cartItems.isEmpty {
                           userCartRef.delete { error in
                               if let error = error {
                                   print("Error deleting cart: \(error.localizedDescription)")
                               } else {
                                   print("Cart deleted successfully.")
                               }
                           }
                       } else {
                           userCartRef.updateData([
                               "cartItems": cartItems
                           ]) { error in
                               if let error = error {
                                   print("Error updating cart: \(error.localizedDescription)")
                               } else {
                                   print("Product removed successfully.")
                               }
                           }
                       }
                   }
               }
           }
       }

    
    private func getCurrentUserID() -> String? {
        return Auth.auth().currentUser?.uid
    }
    
    func toggleFavorite() {
        // Toggle the UI state immediately
        isFavorite.toggle()
        
        let db = Firestore.firestore()
        guard let userId = Auth.auth().currentUser?.uid else {
            print("User is not logged in")
            return
        }
        
        let favDocRef = db.collection("userFavProducts").document(userId)
        let productId = product.id // Ensure product.id is correctly assigned
        
        // First check if the document exists
        favDocRef.getDocument { document, error in
            if let error = error {
                print("Error fetching document: \(error.localizedDescription)")
                return
            }
            
            if let document = document, document.exists {
                // Document exists, proceed to update
                if self.isFavorite {
                    // Add to favorites
                    favDocRef.updateData([
                        "IDs": FieldValue.arrayUnion([productId])
                    ]) { error in
                        if let error = error {
                            print("Error adding favorite: \(error.localizedDescription)")
                            // Revert the UI change if there's an error
                            self.isFavorite.toggle()
                        }
                    }
                } else {
                    // Remove from favorites
                    favDocRef.updateData([
                        "IDs": FieldValue.arrayRemove([productId])
                    ]) { error in
                        if let error = error {
                            print("Error removing favorite: \(error.localizedDescription)")
                            // Revert the UI change if there's an error
                            self.isFavorite.toggle()
                        }
                    }
                }
            } else {
                // Document does not exist, create it with initial data
                favDocRef.setData([
                    "IDs": [productId]
                ]) { error in
                    if let error = error {
                        print("Error creating document: \(error.localizedDescription)")
                        // Revert the UI change if there's an error
                        self.isFavorite.toggle()
                    }
                }
            }
        }
    }

        
        private func checkIfFavorite() {
            guard let userId = userId else {
                print("User is not logged in")
                return
            }
            
            let favDocRef = db.collection("userFavProducts").document(userId)
            let productId = product.id
            
            favDocRef.getDocument { document, error in
                if let error = error {
                    print("Error fetching favorite products: \(error.localizedDescription)")
                    return
                }
                
                if let document = document, document.exists {
                    if let ids = document.data()?["IDs"] as? [String] {
                        self.isFavorite = ids.contains(productId!)
                    } else {
                        self.isFavorite = false
                    }
                } else {
                    self.isFavorite = false
                }
            }
        }
}
