//
//  LoginViewModel.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 17/07/24.
//

import SwiftUI
import FirebaseAuth

class LoginViewModel: ObservableObject {
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    @AppStorage("currentUserUID") var currentUserUID: String?
    @Published var txtEmail: String = ""
    @Published var txtPassword: String = ""
    @Published var isShowPassword: Bool = false
    @Published var errorMessage: String = ""
    @Published var showingError: Bool = false

    @Published var adminId: String?
    @Published var username: String?
    @Published var email: String?
    @Published var uid: String?
    @Published var isAdmin: Bool = false

    init() {
        loadUserInfo()
        if let savedUID = currentUserUID {
            self.uid = savedUID
            self.checkAdminStatus(uid: savedUID)
        }
    }

    func login(completion: @escaping (Bool) -> Void) {
        // Step 1: Validate inputs
        if !validateInputs() {
            completion(false)
            return
        }
        
        // Step 2: Proceed with Firebase Authentication if validation passes
        Auth.auth().signIn(withEmail: txtEmail, password: txtPassword) { authResult, error in
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
            self.uid = user.uid
            self.email = user.email
            self.saveLoginState(uid: user.uid)
            self.checkAdminStatus(uid: user.uid)
            completion(true)
        }
    }

    private func validateInputs() -> Bool {
            if txtEmail.isEmpty {
                errorMessage = "Email cannot be empty."
                showingError = true
                return false
            }
            if !isValidEmail(txtEmail) {
                errorMessage = "Please enter a valid email address."
                showingError = true
                return false
            }
            if txtPassword.isEmpty {
                errorMessage = "Password cannot be empty."
                showingError = true
                return false
            }
            return true
        }

        private func isValidEmail(_ email: String) -> Bool {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
            return emailTest.evaluate(with: email)
        }
    private func checkAdminStatus(uid: String) {
        if let savedAdminId = UserDefaultsManager.shared.getAdminId() {
            self.isAdmin = (uid == savedAdminId)
            if self.isAdmin {
                self.adminId = savedAdminId
                print("User is an admin.")
            } else {
                self.adminId = nil
                print("User is not an admin.")
            }
        } else {
            self.isAdmin = false
            print("Admin ID not found in UserDefaults.")
        }
    }

    private func loadUserInfo() {
        self.username = UserDefaultsManager.shared.getUsername()
        self.email = UserDefaultsManager.shared.getEmail()
        self.uid = UserDefaultsManager.shared.getUID()
        self.adminId = UserDefaultsManager.shared.getAdminId()
        self.isAdmin = (self.uid == self.adminId)
    }

    private func saveLoginState(uid: String) {
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
        UserDefaults.standard.set(uid, forKey: "currentUserUID")
    }

    func logout() {
        do {
         
            try Auth.auth().signOut()
            print("Successfully signed out.")
            
           
            UserDefaults.standard.set(false, forKey: "isLoggedIn")
                   UserDefaults.standard.removeObject(forKey: "currentUserUID")
                   UserDefaults.standard.removeObject(forKey: "adminId")
                   UserDefaults.standard.removeObject(forKey: "username")
                   UserDefaults.standard.removeObject(forKey: "email")
                   UserDefaults.standard.removeObject(forKey: "uid")
            
           
            print("isLoggedIn status after logout: \(UserDefaults.standard.bool(forKey: "isLoggedIn"))")
            
            
            self.uid = nil
            self.email = nil
            self.isAdmin = false
            print("Local state cleared: uid, email set to nil, and isAdmin set to false.")
            
            
            DispatchQueue.main.async {
                UIApplication.shared.windows.first?.rootViewController = UIHostingController(rootView: WelcomeView())
            }
            
        } catch let signOutError as NSError {
          
            print("Error signing out: \(signOutError)")
        }
    }


}

