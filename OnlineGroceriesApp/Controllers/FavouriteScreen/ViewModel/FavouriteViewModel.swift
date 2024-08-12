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

    private let db = Firestore.firestore()

    func fetchFavourites() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let userFavRef = db.collection("userFav").document(userId)

        userFavRef.getDocument { [weak self] document, error in
            if let document = document, document.exists {
                let data = document.data()
                let productIds = data?["IDs"] as? [String] ?? []
                self?.fetchProducts(productIds: productIds)
            } else {
                print("Document does not exist")
            }
        }
    }

    private func fetchProducts(productIds: [String]) {
        let productsRef = db.collection("products")

        let dispatchGroup = DispatchGroup()
        var products: [Product] = []

        for productId in productIds {
            dispatchGroup.enter()
            productsRef.document(productId).getDocument { document, error in
                if let document = document, document.exists {
                    let product = try? document.data(as: Product.self)
                    if let product = product {
                        products.append(product)
                    }
                }
                dispatchGroup.leave()
            }
        }

        dispatchGroup.notify(queue: .main) {
            self.favouriteProducts = products
        }
    }
}

