//
//  WelcomeViewModel.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 01/08/24.
//

import SwiftUI
import FirebaseFirestore

class WelcomeViewModel: ObservableObject {
    @Published var adminId: String? {
        didSet {
            if let adminId = adminId {
                UserDefaultsManager.shared.setAdminId(adminId)
            }
        }
    }
    
    private var db = Firestore.firestore()
    
    init() {
        fetchAdminIdFromUserDefaults()
    }
    
    func fetchAdminId() {
        db.collection("config").document("appConfig").getDocument { [weak self] (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                self?.adminId = data?["adminId"] as? String
                if let adminId = self?.adminId {
                    print("Admin ID: \(adminId)")
                } else {
                    print("Admin ID not available")
                }
            } else {
                print("Document does not exist")
            }
        }
    }
    
    private func fetchAdminIdFromUserDefaults() {
        if let savedAdminId = UserDefaultsManager.shared.getAdminId() {
            self.adminId = savedAdminId
        } else {
            fetchAdminId()
        }
    }
}

