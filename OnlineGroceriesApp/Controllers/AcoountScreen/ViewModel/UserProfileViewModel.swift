//
//  UserProfileViewModel.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 06/09/24.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseStorage
import UIKit

class UserProfileViewModel: ObservableObject {
    @Published var user: User?
    @Published var userProfile: UserProfile?
    @Published var selectedImage: UIImage?
    private var db = Firestore.firestore()
    
    init() {
        fetchUserProfile()
    }
    func uploadProfileImage() {
          guard let userID = Auth.auth().currentUser?.uid,
                let imageData = selectedImage?.jpegData(compressionQuality: 0.8) else { return }
          
          let storageRef = Storage.storage().reference().child("profile_images/\(userID).jpg")
          
          storageRef.putData(imageData, metadata: nil) { metadata, error in
              if let error = error {
                  print("Failed to upload image: \(error)")
                  return
              }
              
              storageRef.downloadURL { [weak self] url, error in
                  if let error = error {
                      print("Failed to get download URL: \(error)")
                      return
                  }
                  
                  if let profileImageURL = url?.absoluteString {
                      self?.updateUserProfileImageURL(profileImageURL: profileImageURL)
                  }
              }
          }
      }
      
      private func updateUserProfileImageURL(profileImageURL: String) {
          guard let userID = Auth.auth().currentUser?.uid else { return }
          
          db.collection("users").document(userID).updateData([
              "profileImageURL": profileImageURL
          ]) { error in
              if let error = error {
                  print("Failed to update Firestore: \(error)")
              } else {
                  self.fetchUserProfile()
              }
          }
      }
    
    private func fetchUserProfile() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        db.collection("users").document(userID).getDocument { [weak self] (document, error) in
            if let document = document, document.exists {
                do {
                    let data = try document.data(as: UserProfile.self)
                    self?.userProfile = data
                } catch {
                    print("Error decoding user profile: \(error)")
                }
            } else {
                print("Document does not exist")
            }
        }
    }
}

struct UserProfile: Identifiable, Codable {
    @DocumentID var id: String?
    var username: String
    var email: String
    var profileImageURL: String?
    
}