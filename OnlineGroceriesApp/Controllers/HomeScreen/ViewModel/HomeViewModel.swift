//
//  HomeViewModel.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 17/07/24.
//

import SwiftUI
import FirebaseFirestore
import Firebase

class HomeViewModel: ObservableObject {
    
    @Published var products: [Product] = []
    @Published var selectedTab: Int = 0
    @Published var searchText: String = ""
    @Published var savedAddress: Address?
    private var db = Firestore.firestore()
    
    var filteredProducts: [Product] {
            if searchText.isEmpty {
                return products
            } else {
                return products.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
            }
        }
    
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
    
    func fetchSavedAddress() {
           guard let userID = Auth.auth().currentUser?.uid else {
               print("User not logged in")
               return
           }
           
           db.collection("userAddress").document(userID).getDocument { [weak self] (document, error) in
               if let error = error {
                   print("Error fetching address: \(error)")
                   return
               }
               
               if let document = document, document.exists {
                   let data = document.data()
                   if let addresses = data?["addresses"] as? [[String: Any]],
                      let firstAddress = addresses.first {
                       self?.savedAddress = Address(
                           city: firstAddress["city"] as? String ?? "Unknown",
                           state: firstAddress["state"] as? String ?? "Unknown",
                           country: firstAddress["country"] as? String ?? "Unknown",
                           zipCode: firstAddress["zipCode"] as? String ?? "Unknown", 
                           isDefault: true
                       )
                   }
               } else {
                   print("No saved address found")
               }
           }
       }
    


}

struct Product: Identifiable, Codable {
    @DocumentID var id: String?
    var name: String
    var categoryID: String?
    var price: Double
    var description: String? = nil
    var img: String
    var stock: String? = nil
}


