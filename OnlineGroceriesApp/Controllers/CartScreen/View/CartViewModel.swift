//
//  CartViewModel.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 13/08/24.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

class CartViewModel: ObservableObject {
//    @Published var cartItems: [CartItem] = []
//      
//      private var db = Firestore.firestore()
//      
//      func addProductToCart(_ product: Product) {
//          guard let userID = getCurrentUserID() else {
//              print("Error: User not logged in")
//              return
//          }
//
//          let userCartRef = db.collection("userCart").document(userID)
//          
//          userCartRef.getDocument { (document, error) in
//              if let document = document, document.exists {
//                  var cartItems = document.data()?["cartItems"] as? [[String: Any]] ?? []
//                  
//                  if let index = cartItems.firstIndex(where: { $0["productID"] as? String == product.id }) {
//                      cartItems[index]["quantity"] = (cartItems[index]["quantity"] as? Int ?? 0) + 1
//                  } else {
//                      let newItem = [
//                          "productID": product.id ?? "",
//                          "name": product.name,
//                          "price": product.price,
//                          "quantity": 1,
//                          "img": product.img
//                      ] as [String : Any]
//                      cartItems.append(newItem)
//                  }
//
//                  userCartRef.updateData([
//                      "cartItems": cartItems
//                  ]) { error in
//                      if let error = error {
//                          print("Error updating cart: \(error.localizedDescription)")
//                      } else {
//                          print("Product quantity updated/added successfully.")
//                      }
//                  }
//
//              } else {
//                  let cartItem = [
//                      "productID": product.id ?? "",
//                      "name": product.name,
//                      "price": product.price,
//                      "quantity": 1,
//                      "img": product.img
//                  ] as [String : Any]
//                  
//                  userCartRef.setData([
//                      "cartItems": [cartItem]
//                  ]) { error in
//                      if let error = error {
//                          print("Error creating user cart: \(error.localizedDescription)")
//                      } else {
//                          print("User cart created and product added successfully.")
//                      }
//                  }
//              }
//          }
//      }
//
//      private func getCurrentUserID() -> String? {
//          return Auth.auth().currentUser?.uid
//      }
  }
//    @Published var cartItems: [CartItem] = []
//    
//    private var db = Firestore.firestore()
//    
//    init() {
//        fetchCartItems()
//        print("Fetched data: ")
//    }
//    
//    func fetchCartItems() {
//        guard let userID = Auth.auth().currentUser?.uid else {
//            print("Error: User not logged in")
//            return
//        }
//        
//        db.collection("carts").document(userID).addSnapshotListener { documentSnapshot, error in
//            if let error = error {
//                print("Error fetching cart items: \(error.localizedDescription)")
//                return
//            }
//
//            guard let document = documentSnapshot, document.exists else {
//                print("No cart document found for user ID: \(userID)")
//                return
//            }
//
//            guard let cartData = document.data(),
//                  let items = cartData["cartItems"] as? [[String: Any]] else {
//                print("No cart items found in document or the structure is incorrect")
//                return
//            }
//
//            print("Raw cart items: \(items)")  // Print the raw data fetched from Firestore
//
//            self.cartItems = items.compactMap { item in
//                do {
//                    print("Processing item: \(item)")  // Print each item before attempting to decode
//
//                    // Directly decode the dictionary into CartItem
//                    let jsonData = try JSONSerialization.data(withJSONObject: item, options: [])
//                    let decodedItem = try JSONDecoder().decode(CartItem.self, from: jsonData)
//                    
//                    print("Successfully decoded item: \(decodedItem)")  // Print the successfully decoded item
//                    return decodedItem
//                    
//                } catch {
//                    print("Error decoding cart item: \(error.localizedDescription)")
//                    print("Failed item data: \(item)")  // Print the item that caused the decoding to fail
//                    return nil
//                }
//            }
//
//            print("Final cartItems array: \(self.cartItems)")  // Print the final array of CartItems after decoding
//        }
//    }
//
//}
//
//struct CartItem: Identifiable, Codable {
//    @DocumentID var id: String?
//    var productID: String
//    var name: String
//    var price: Double
//    var quantity: Int
//    var img: String
//    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        
//        self.id = try container.decodeIfPresent(String.self, forKey: .id)
//        self.productID = try container.decode(String.self, forKey: .productID)
//        self.name = try container.decode(String.self, forKey: .name)
//        
//        // Decode price as Double, even if stored as an integer in Firestore
//        if let priceAsDouble = try? container.decode(Double.self, forKey: .price) {
//            self.price = priceAsDouble
//        } else if let priceAsInt = try? container.decode(Int.self, forKey: .price) {
//            self.price = Double(priceAsInt)
//        } else {
//            throw DecodingError.dataCorruptedError(forKey: .price, in: container, debugDescription: "Price cannot be decoded")
//        }
//        
//        // Decode quantity as Int
//        self.quantity = try container.decode(Int.self, forKey: .quantity)
//        self.img = try container.decode(String.self, forKey: .img)
//    }

//struct CartItem: Identifiable, Codable {
//    @DocumentID var id: String?
//    var productID: String
//    var name: String
//    var price: Double
//    var quantity: Int
//    var img: String
//}
