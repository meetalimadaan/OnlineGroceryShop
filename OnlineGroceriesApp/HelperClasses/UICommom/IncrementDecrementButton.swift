//
//  IncrementDecrementButton.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 14/08/24.
//

import SwiftUI
import FirebaseFirestore
import Firebase

struct IncrementDecrementButton: View {
    @Binding var quantity: Int
    var product: Product
    var removeProductFromCart: () -> Void
    
    var body: some View {
        HStack {
            Button {
                if quantity > 1 {
                    quantity -= 1
                    updateQuantityInCart()
                } else if quantity == 1 {
                    removeProductFromCart()
                }
            } label: {
                Image("Vector-5")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .padding(10)
            }
            .padding(4)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.secondaryText.opacity(0.5), lineWidth: 1)
            )
            
            Text("\(quantity)")
                .font(.customfont(.semibold, fontSize: 24))
                .foregroundColor(.primaryText)
                .multilineTextAlignment(.center)
                .frame(width: 45, height: 45, alignment: .center)
            
            Button {
                quantity += 1
                updateQuantityInCart()
            } label: {
                Image("Vector-6")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .padding(10)
            }
            .padding(4)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.secondaryText.opacity(0.5), lineWidth: 1)
            )
        }
    }
    
    private func updateQuantityInCart() {
        guard let userID = getCurrentUserID() else { return }
        let userCartRef = Firestore.firestore().collection("userCart").document(userID)
        
        userCartRef.getDocument { (document, error) in
            if let document = document, document.exists {
                var cartItems = document.data()?["cartItems"] as? [[String: Any]] ?? []
                
                if let index = cartItems.firstIndex(where: { $0["productID"] as? String == product.id }) {
                    cartItems[index]["quantity"] = quantity
                    userCartRef.updateData(["cartItems": cartItems]) { error in
                        if let error = error {
                            print("Error updating quantity: \(error.localizedDescription)")
                        }
                    }
                }
            }
        }
    }

    private func getCurrentUserID() -> String? {
        return Auth.auth().currentUser?.uid
    }
}
