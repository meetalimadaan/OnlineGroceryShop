//
//  HomeViewModel.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 17/07/24.
//

import SwiftUI
import FirebaseFirestore

class HomeViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var txtSearch = ""
    @Published var selectTab: Int = 0
    
    init() {
            fetchProducts { isSuccess in
                if isSuccess {
                    print("Products fetched successfully")
                } else {
                    print("Failed to fetch products")
                }
            }
        }

    func fetchProducts(completion: @escaping (_ isSuccess: Bool) -> Void) {
            let db = Firestore.firestore()
            db.collection("products").getDocuments { (snapshot, error) in
                if let error = error {
                    print("Error fetching products: \(error.localizedDescription)")
                    completion(false)
                    return
                }

                guard let documents = snapshot?.documents else {
                    print("No products found")
                    completion(false)
                    return
                }

                self.products = documents.compactMap { doc in
                    do {
                        var product = try doc.data(as: Product.self)
                        product.id = doc.documentID
                        return product
                    } catch {
                        print("Error decoding product: \(error.localizedDescription)")
                        return nil
                    }
                }
                
                completion(true)
//                print("Fetched products: \(self.products)")
            }
        }
    
    
    


}

struct Product: Identifiable, Codable {
    @DocumentID var id: String?
    var name: String
    var categoryID: String?
    var price: Double
    var description: String
    var img: String
    var stock: String
}


