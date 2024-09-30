//
//  CartViewModel.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 13/08/24.
//

import SwiftUI
import FirebaseFirestore
import Firebase
import FirebaseAuth
class MyCartViewModel: ObservableObject {
    static let shared = MyCartViewModel()


    @Published var cartItems: [CartItem] = [] {
            didSet {
                calculateTotalAmount()
            }
        }
    @Published var totalAmount: Double = 0.0
    
     init() {
        fetchCartItems()
    }

    func fetchCartItems() {
        guard let userID = getCurrentUserID() else { return }

        let userCartRef = Firestore.firestore().collection("userCart").document(userID)

        userCartRef.getDocument { [weak self] (document, error) in
            if let document = document, document.exists {
                let cartItemsData = document.data()?["cartItems"] as? [[String: Any]] ?? []

                self?.cartItems = cartItemsData.compactMap { data in
                    return CartItem(
                        id: data["productID"] as? String ?? "",
                        name: data["name"] as? String ?? "",
                        price: data["price"] as? Double ?? 0.0,
                        quantity: data["quantity"] as? Int ?? 0,
                        img: data["img"] as? String ?? ""
                    )
                }
            }
        }
    }
    func calculateTotalAmount() {
           totalAmount = cartItems.reduce(0) { $0 + ($1.price * Double($1.quantity)) }
       }
    func didUpdateCartQuantity(for product: Product, newQuantity: Int) {
            if let index = cartItems.firstIndex(where: { $0.id == product.id }) {
                cartItems[index].quantity = newQuantity
                calculateTotalAmount()
            }
        }
//    var totalAmount: Double {
//            cartItems.reduce(0) { total, item in
//                total + (Double(item.quantity) * item.price)
//            }
//        }
    
    private func getCurrentUserID() -> String? {
        return Auth.auth().currentUser?.uid
    }
}
