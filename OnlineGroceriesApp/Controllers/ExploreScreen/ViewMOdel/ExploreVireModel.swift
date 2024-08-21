//
//  ExploreVireModel.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 19/07/24.
//

import SwiftUI
import FirebaseFirestore

class ExploreVireModel: ObservableObject {
    @Published var categories: [Category] = []
    @Published var products: [Product] = []
    @Published var searchText: String = ""
    private var db = Firestore.firestore()
    
    var filteredCategories: [Category] {
            if searchText.isEmpty {
                return categories
            } else {
                return categories.filter { category in
                    category.name?.lowercased().contains(searchText.lowercased()) ?? false
                }
            }
        }
    
    init() {
            fetchCategories { success, error in
                if success {
                    print("Categories fetched successfully.")
                } else {
                    print("Failed to fetch categories: \(error ?? "Unknown error")")
                }
            }
        }
    
    func fetchCategories(completion: @escaping (Bool, String?) -> Void) {
        db.collection("categories").getDocuments { snapshot, error in
            if let error = error {
                completion(false, "Error fetching categories: \(error.localizedDescription)")
                return
            }
            
            if let documents = snapshot?.documents {
                self.categories = documents.compactMap { doc in
                    do {
                        var category = try doc.data(as: Category.self)
                        category.id = doc.documentID
                        return category
                    } catch {
                        print("Error decoding category: \(error.localizedDescription)")
                        return nil
                    }
                }
                completion(true, nil)
            } else {
                completion(false, "No categories found.")
            }
        }
    }

    
    func fetchProducts(byCategoryID categoryID: String, completion: @escaping (Bool, String?) -> Void) {
            db.collection("products")
                .whereField("categoryID", isEqualTo: categoryID)
                .getDocuments { snapshot, error in
                    if let error = error {
                        completion(false, "Error fetching products: \(error.localizedDescription)")
                        return
                    }
                    
                    if let documents = snapshot?.documents {
                        self.products = documents.compactMap { doc in
                            do {
                                return try doc.data(as: Product.self)
                            } catch {
                                print("Error decoding product: \(error.localizedDescription)")
                                return nil
                            }
                        }
                        completion(true, nil)
                    } else {
                        completion(false, "No products found.")
                    }
                }
        }
    
    
}
struct Category: Identifiable, Codable {
    @DocumentID var id: String?
    var name: String?
    var imgURL: String?
}


//struct Product: Identifiable, Codable {
//    @DocumentID var id: String?
//    var name: String
//    var categoryID: String
//    var price: Double
//    var description: String?
//    var img: String?
//    var stock: Int
//}
