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
    
    private var db = Firestore.firestore()
    
    init() {
        fetchCategories()
    }
    
    func fetchCategories() {
        db.collection("categories").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching categories: \(error.localizedDescription)")
                return
            }
            
            if let documents = snapshot?.documents {
                self.categories = documents.compactMap { doc in
                    do {
                        // Try to decode with optional fields
                        let category = try doc.data(as: Category.self)
                        // Ensure that all required fields are present
                        if let name = category.name, let imgURL = category.imgURL {
                            return Category(id: doc.documentID, name: name, imgURL: imgURL)
                        } else {
                            print("Category data is incomplete: \(doc.data())")
                            return nil
                        }
                    } catch {
                        print("Error decoding category: \(error.localizedDescription)")
                        return nil
                    }
                }
            }
        }
    }


}
struct Category: Identifiable, Codable {
    @DocumentID var id: String?
    var name: String?
    var imgURL: String?
}
