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
        // Step 1: Validate inputs
        if !validateInputs() {
            showingError = true
            completion(false)
            return
        }

        // Step 2: Proceed with Firebase Authentication if validation passes
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

    private func validateInputs() -> Bool {
        // Check if any field is empty
        if txtUsername.isEmpty || txtEmail.isEmpty || txtPassword.isEmpty {
            errorMessage = "All fields are required"
            return false
        }

        // Validate email format
        if !isValidEmail(txtEmail) {
            errorMessage = "Please enter a valid email address"
            return false
        }

        // Validate password length
        if txtPassword.count < 6 {
            errorMessage = "Password must be at least 6 characters."
            return false
        }

        return true
    }

    // Email validation using regular expression
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
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
                UserDefaultsManager.shared.setUsername(username)
                UserDefaultsManager.shared.setEmail(email)
                UserDefaultsManager.shared.setUID(uid)
                completion(true)
            }
        }
    }
}


