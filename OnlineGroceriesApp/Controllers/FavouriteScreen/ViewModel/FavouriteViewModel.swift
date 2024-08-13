//
//  FavouriteViewModel.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 09/08/24.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

class FavouriteViewModel: ObservableObject {
    @Published var favouriteProducts: [Product] = []
    
    func fetchFavourites() {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("User is not logged in")
            return
        }
        
        let db = Firestore.firestore()
        let favDocRef = db.collection("userFavProducts").document(userId)
        
        favDocRef.getDocument { document, error in
            if let error = error {
                print("Error fetching favorites: \(error.localizedDescription)")
                return
            }
            
            if let document = document, document.exists {
                if let ids = document.data()?["IDs"] as? [String] {
                    self.fetchProductsByIds(ids)
                }
            }
        }
    }
    
    private func fetchProductsByIds(_ ids: [String]) {
        let db = Firestore.firestore()
        let productsRef = db.collection("products")
        
        productsRef.whereField(FieldPath.documentID(), in: ids).getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching products: \(error.localizedDescription)")
                return
            }
            
            guard let documents = snapshot?.documents else { return }
            
            self.favouriteProducts = documents.compactMap { document -> Product? in
                try? document.data(as: Product.self)
            }
        }
    }
}

