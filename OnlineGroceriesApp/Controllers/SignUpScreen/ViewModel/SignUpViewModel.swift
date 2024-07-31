//
//  SignUpViewModel.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 31/07/24.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class SignUpViewModel: ObservableObject {
    @Published var txtUsername: String = ""
    @Published var txtEmail: String = ""
    @Published var txtPassword: String = ""
    @Published var isShowPassword: Bool = false
    @Published var errorMessage: String = ""
    @Published var showingError: Bool = false

    static let shared = SignUpViewModel()

    func signUp(completion: @escaping (Bool) -> Void) {
        Auth.auth().createUser(withEmail: txtEmail, password: txtPassword) { authResult, error in
            if let error = error {
                self.errorMessage = error.localizedDescription
                self.showingError = true
                completion(false)
                return
            }
            guard let user = authResult?.user else {
                completion(false)
                return
            }
            self.saveUserInfo(uid: user.uid, email: self.txtEmail, username: self.txtUsername, completion: completion)
        }
    }

    private func saveUserInfo(uid: String, email: String, username: String, completion: @escaping (Bool) -> Void) {
        let db = Firestore.firestore()
        db.collection("users").document(uid).setData([
            "email": email,
            "username": username
        ]) { error in
            if let error = error {
                self.errorMessage = error.localizedDescription
                self.showingError = true
                completion(false)
            } else {
                print("Data saved successfully for user: \(uid)")
                completion(true)
            }
        }
    }
}
