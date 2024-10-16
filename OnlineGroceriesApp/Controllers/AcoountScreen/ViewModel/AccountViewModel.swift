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
    @Published var profileImageURL: String?
    @Published var isLoading: Bool = false
    @Published var currentUser: User?
  
    static let shared = AccountViewModel()
    
    private let db = Firestore.firestore()
    
    func fetchUserData() {
          
           guard let userID = Auth.auth().currentUser?.uid else { return }
           
           Firestore.firestore().collection("users").document(userID).getDocument { (document, error) in
               if let document = document, document.exists {
                   do {
                       let data = try document.data(as: UserProfile.self)
                       self.username = data.username ?? ""
                       self.email = data.email ?? ""
                       self.profileImageURL = data.profileImageURL
                   } catch {
                       print("Error decoding user profile: \(error)")
                   }
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
    
    func updateUserProfile(currentPassword: String, newPassword: String, completion: @escaping (Bool) -> Void) {
           let user = Auth.auth().currentUser
           
           if !currentPassword.isEmpty && !newPassword.isEmpty {
               let credential = EmailAuthProvider.credential(withEmail: user?.email ?? "", password: currentPassword)
               
               user?.reauthenticate(with: credential) { result, error in
                   if let error = error {
                       print("Reauthentication failed: \(error.localizedDescription)")
                       completion(false)
                       return
                   }
                   
                   user?.updatePassword(to: newPassword) { error in
                       if let error = error {
                           print("Password update failed: \(error.localizedDescription)")
                           completion(false)
                           return
                       }
                       
                       self.updateUserProfileDetails(completion: completion)
                   }
               }
           } else {
               updateUserProfileDetails(completion: completion)
           }
       }
       
       private func updateUserProfileDetails(completion: @escaping (Bool) -> Void) {
           let user = Auth.auth().currentUser
           let changeRequest = user?.createProfileChangeRequest()
           changeRequest?.displayName = username
           changeRequest?.commitChanges { error in
               if let error = error {
                   print("Profile update failed: \(error.localizedDescription)")
                   completion(false)
                   return
               }
               
               completion(true)
           }
       }
    
}
