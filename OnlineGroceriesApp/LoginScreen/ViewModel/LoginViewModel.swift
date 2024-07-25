//
//  LoginViewModel.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 17/07/24.
//

import SwiftUI

class LoginViewModel:
ObservableObject{
    
    static var shared: LoginViewModel = LoginViewModel()
    @Published var txtUsername: String = ""
    @Published var txtEmail: String = ""
    @Published var txtPassword: String = ""
    @Published var isShowPassword: Bool = false
}
