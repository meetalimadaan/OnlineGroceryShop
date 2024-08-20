//
//  ProductDetailViewModel.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 18/07/24.
//

//import SwiftUI
//import FirebaseFirestore
//import Firebase
//
//class ProductDetailViewModel: ObservableObject {
//    @Published var isFavorite: Bool = false
//        var product: Product
//         let db = Firestore.firestore()
//         var userId: String? {
//            Auth.auth().currentUser?.uid
//        }
//        
//        init(product: Product) {
//            self.product = product
//            checkIfFavorite()
//        }
        
//    func toggleFavorite() {
//        // Toggle the UI state immediately
//        isFavorite.toggle()
//        
//        let db = Firestore.firestore()
//        guard let userId = Auth.auth().currentUser?.uid else {
//            print("User is not logged in")
//            return
//        }
//        
//        let favDocRef = db.collection("userFavProducts").document(userId)
//        let productId = product.id // Ensure product.id is correctly assigned
//        
//        // First check if the document exists
//        favDocRef.getDocument { document, error in
//            if let error = error {
//                print("Error fetching document: \(error.localizedDescription)")
//                return
//            }
//            
//            if let document = document, document.exists {
//                // Document exists, proceed to update
//                if self.isFavorite {
//                    // Add to favorites
//                    favDocRef.updateData([
//                        "IDs": FieldValue.arrayUnion([productId])
//                    ]) { error in
//                        if let error = error {
//                            print("Error adding favorite: \(error.localizedDescription)")
//                            // Revert the UI change if there's an error
//                            self.isFavorite.toggle()
//                        }
//                    }
//                } else {
//                    // Remove from favorites
//                    favDocRef.updateData([
//                        "IDs": FieldValue.arrayRemove([productId])
//                    ]) { error in
//                        if let error = error {
//                            print("Error removing favorite: \(error.localizedDescription)")
//                            // Revert the UI change if there's an error
//                            self.isFavorite.toggle()
//                        }
//                    }
//                }
//            } else {
//                // Document does not exist, create it with initial data
//                favDocRef.setData([
//                    "IDs": [productId]
//                ]) { error in
//                    if let error = error {
//                        print("Error creating document: \(error.localizedDescription)")
//                        // Revert the UI change if there's an error
//                        self.isFavorite.toggle()
//                    }
//                }
//            }
//        }
//    }
//
//        
//        private func checkIfFavorite() {
//            guard let userId = userId else {
//                print("User is not logged in")
//                return
//            }
//            
//            let favDocRef = db.collection("userFavProducts").document(userId)
//            let productId = product.id
//            
//            favDocRef.getDocument { document, error in
//                if let error = error {
//                    print("Error fetching favorite products: \(error.localizedDescription)")
//                    return
//                }
//                
//                if let document = document, document.exists {
//                    if let ids = document.data()?["IDs"] as? [String] {
//                        self.isFavorite = ids.contains(productId!)
//                    } else {
//                        self.isFavorite = false
//                    }
//                } else {
//                    self.isFavorite = false
//                }
//            }
//        }
//    }
