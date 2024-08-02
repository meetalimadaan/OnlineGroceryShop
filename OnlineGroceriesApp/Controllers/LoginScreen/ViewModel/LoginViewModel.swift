//
//  LoginViewModel.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 17/07/24.
//

import SwiftUI
import FirebaseAuth

class LoginViewModel: ObservableObject {
    @Published var txtEmail: String = ""
    @Published var txtPassword: String = ""
    @Published var errorMessage: String = ""
    @Published var showingError: Bool = false

    @Published var adminId: String?
    @Published var username: String?
    @Published var email: String?
    @Published var uid: String?
    @Published var isAdmin: Bool = false

    init() {
        loadUserInfo()
    }

    func login(completion: @escaping (Bool) -> Void) {
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
            self.checkAdminStatus(uid: user.uid)
            completion(true)
        }
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
}


