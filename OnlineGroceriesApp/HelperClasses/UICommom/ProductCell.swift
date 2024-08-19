//
//  ProductCell.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 18/07/24.
//

import SwiftUI
import Firebase

struct ProductCell: View {
    var product: Product
    var didAddCart: (() -> Void)?
    @State private var cartQuantity: Int = 0
    @State private var showQuantity: Bool = false

    var body: some View {
        NavigationLink(destination: ProductDetailsView(product: product)) {
            VStack {
                AsyncImage(url: URL(string: product.img)) { image in
                    image.resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 80)
                } placeholder: {
                    ShimmerView()
                }
                
                Spacer()
                
                Text(product.name)
                    .font(.customfont(.bold, fontSize: 16))
                    .foregroundColor(.primaryText)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                
                Text("\(product.stock) pcs")
                    .font(.customfont(.medium, fontSize: 14))
                    .foregroundColor(.secondaryText)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                Spacer()
                
                Text("Rs\(product.price, specifier: "%.2f")")
                    .font(.customfont(.semibold, fontSize: 18))
                    .foregroundColor(.primaryText)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                HStack {
                    if showQuantity {
                        IncrementDecrementButton(
                            quantity: $cartQuantity,
                            product: product,
                            removeProductFromCart: removeProductFromCart
                        )
                        .frame(width: 80, height: 45)
                    } else {
                        Button {
                            addProductToCart()
                        } label: {
                            HStack {
                                Image("Vector-3")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 15, height: 15)
                                
                                Text("Add to Basket")
                                    .font(.customfont(.semibold, fontSize: 14))
                                    .foregroundColor(.white)
                            }
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                        }
                        .frame(width: 150, height: 45)
                        .background(Color.primaryApp)
                        .cornerRadius(15)
                    }
                }
            }
            .padding(15)
            .frame(width: 180, height: 230)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.primaryText.opacity(0.5), lineWidth: 1)
            )
            .onAppear {
                fetchCartQuantity()
            }
        }
    }

    func fetchCartQuantity() {
        guard let userID = getCurrentUserID() else { return }

        let userCartRef = Firestore.firestore().collection("userCart").document(userID)
        
        userCartRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let cartItems = document.data()?["cartItems"] as? [[String: Any]] ?? []
                
                if let item = cartItems.first(where: { $0["productID"] as? String == product.id }) {
                    cartQuantity = item["quantity"] as? Int ?? 0
                    showQuantity = true
                } else {
                    showQuantity = false
                }
            }
        }
    }
    
    func addProductToCart() {
        let db = Firestore.firestore()
        guard let userID = getCurrentUserID() else {
            print("Error: User not logged in")
            return
        }

        let userCartRef = db.collection("userCart").document(userID)
        
        userCartRef.getDocument { (document, error) in
            if let document = document, document.exists {
                var cartItems = document.data()?["cartItems"] as? [[String: Any]] ?? []
                
                if let index = cartItems.firstIndex(where: { $0["productID"] as? String == product.id }) {
                    // Product exists, increment quantity
                    cartItems[index]["quantity"] = (cartItems[index]["quantity"] as? Int ?? 0) + 1
                } else {
                    // Product doesn't exist, add new item
                    let newItem = [
                        "productID": product.id ?? "",
                        "name": product.name,
                        "price": product.price,
                        "quantity": 1,
                        "img": product.img
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
                        fetchCartQuantity()
                    }
                }

            } else {
                let cartItem = [
                    "productID": product.id ?? "",
                    "name": product.name,
                    "price": product.price,
                    "quantity": 1,
                    "img": product.img
                ] as [String : Any]
                
                userCartRef.setData([
                    "cartItems": [cartItem]
                ]) { error in
                    if let error = error {
                        print("Error creating user cart: \(error.localizedDescription)")
                    } else {
                        print("User cart created and product added successfully.")
                        fetchCartQuantity()
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

        let db = Firestore.firestore()
        let userCartRef = db.collection("userCart").document(userID)
        
        userCartRef.getDocument { (document, error) in
            if let document = document, document.exists {
                var cartItems = document.data()?["cartItems"] as? [[String: Any]] ?? []

                if let index = cartItems.firstIndex(where: { $0["productID"] as? String == product.id }) {
                    cartItems.remove(at: index)
                    
                    if cartItems.isEmpty {
                        // Optionally delete the cart if empty
                        userCartRef.delete { error in
                            if let error = error {
                                print("Error deleting cart: \(error.localizedDescription)")
                            } else {
                                print("Cart deleted successfully.")
                                showQuantity = false
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
                                showQuantity = false
                            }
                        }
                    }
                }
            }
        }
    }
    
    func getCurrentUserID() -> String? {
        return Auth.auth().currentUser?.uid
    }
}
