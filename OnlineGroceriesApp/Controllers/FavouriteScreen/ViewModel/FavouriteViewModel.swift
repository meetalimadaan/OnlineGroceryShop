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
    @Published var isLoading: Bool = false
    
    func fetchFavourites() {
            guard let userId = Auth.auth().currentUser?.uid else {
                print("User is not logged in")
                return
            }
            
            isLoading = true // Start loading
            
            let db = Firestore.firestore()
            let favDocRef = db.collection("userFavProducts").document(userId)
            
            favDocRef.getDocument { [weak self] document, error in
                guard let self = self else { return }
                
                if let error = error {
                    print("Error fetching favorites: \(error.localizedDescription)")
                    self.isLoading = false // Stop loading
                    return
                }
                
                if let document = document, document.exists {
                    if let ids = document.data()?["IDs"] as? [String], !ids.isEmpty {
                        self.fetchProductsByIds(ids)
                    } else {
                        self.favouriteProducts = []
                        self.isLoading = false // Stop loading if no favorite IDs
                    }
                } else {
                    self.isLoading = false // Stop loading if no document exists
                }
            }
        }
        
        private func fetchProductsByIds(_ ids: [String]) {
            let db = Firestore.firestore()
            let productsRef = db.collection("products")
            
            productsRef.whereField(FieldPath.documentID(), in: ids).getDocuments { [weak self] snapshot, error in
                guard let self = self else { return }
                
                if let error = error {
                    print("Error fetching products: \(error.localizedDescription)")
                    self.isLoading = false // Stop loading on error
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    self.isLoading = false // Stop loading if no documents
                    return
                }
                
                self.favouriteProducts = documents.compactMap { document -> Product? in
                    try? document.data(as: Product.self)
                }
                
                self.isLoading = false // Stop loading after products are fetched
            }
        }
    }

