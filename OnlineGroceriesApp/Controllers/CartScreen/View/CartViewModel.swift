//
//  CartViewModel.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 13/08/24.
//

import SwiftUI
import FirebaseFirestore
import Firebase

class MyCartViewModel: ObservableObject {
    @Published var cartItems: [CartItem] = []
    private var userCartRef: DocumentReference?
    
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
    

    private func getCurrentUserID() -> String? {
        return Auth.auth().currentUser?.uid
    }
    
    
    
}
