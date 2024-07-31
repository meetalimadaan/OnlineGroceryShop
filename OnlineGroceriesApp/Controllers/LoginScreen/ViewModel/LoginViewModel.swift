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
    @Published var isShowPassword: Bool = false
    @Published var errorMessage: String = ""
    @Published var showingError: Bool = false
    
    static let shared = LoginViewModel()
    
    func login(completion: @escaping (Bool) -> Void) {
        Auth.auth().signIn(withEmail: txtEmail, password: txtPassword) { authResult, error in
            if let error = error {
                self.errorMessage = error.localizedDescription
                self.showingError = true
                completion(false)
                return
            }
            completion(true)
        }
    }
}
