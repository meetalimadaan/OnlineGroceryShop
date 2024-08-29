//
//  AccountViewModel.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 31/07/24.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class AccountViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var email: String = ""
    @Published var isLoading: Bool = false
    @Published var currentUser: User?
    static let shared = AccountViewModel()
    
    private let db = Firestore.firestore()
    
    func fetchUserData() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        isLoading = true
        db.collection("users").document(userID).getDocument { document, error in
            self.isLoading = false
            if let document = document, document.exists {
                let data = document.data()
                self.username = data?["username"] as? String ?? "Unknown"
                self.email = data?["email"] as? String ?? "Unknown"
            } else {
                print("Document does not exist")
            }
        }
    }
    
    func logout(completion : @escaping(_ success : Bool)->()) {
        do {
            try Auth.auth().signOut()
            //                completion(true)
            completion(true)
            print("LOGOUT SUCEEFFFULYYY")
        } catch {
            print("Error signing out: \(error.localizedDescription)")
            completion(false)
            //                completion(false)
        }
    }
    
    func updateUserProfile(completion: @escaping (Bool) -> Void) {
        guard let userID = Auth.auth().currentUser?.uid else {
            completion(false)
            return
        }
        
        let userRef = db.collection("users").document(userID)
        
        userRef.updateData([
            "username": self.username,
//            "email": self.email
        ]) { error in
            if let error = error {
                print("Error updating profile: \(error.localizedDescription)")
                completion(false)
            } else {
                print("Profile updated successfully")
                completion(true)
            }
        }
    }
    
}
