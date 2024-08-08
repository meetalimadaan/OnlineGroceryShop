//
//  LoginView.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 17/07/24.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @State var isShowPassword: Bool = false
    @State private var navigateToHome: Bool = false
    @State private var navigateToAdminHome: Bool = false
    
    var body: some View {
        ZStack {
            Image("Rectangle 17")
                .resizable()
                .scaledToFill()
                .frame(width: .screenWidth, height: .screenHeight)
            
            ScrollView {
                VStack {
                    Image("Group-2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40)
                        .padding(.bottom, .screenWidth * 0.1)
                    
                    Text("Login")
                        .font(.customfont(.semibold, fontSize: 26))
                        .foregroundColor(.primaryText)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 4)
                    
                    Text("Enter your credentials to continue")
                        .font(.customfont(.semibold, fontSize: 16))
                        .foregroundColor(.secondaryText)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, .screenWidth * 0.1)
                    
                    LineTextField(title: "Email", placeholder: "Enter your email address", txt: $viewModel.txtEmail, keyboardType: .emailAddress)
                        .padding(.bottom, .screenWidth * 0.07)
                    
                    LineSecureField(title: "Password", placeholder: "Enter your password", txt: $viewModel.txtPassword, isShowPassword: $viewModel.isShowPassword)
                        .padding(.bottom, .screenWidth * 0.04)
                    
                    NavigationLink {
                        ForgotPasswordView()
                    } label: {
                        Text("Forgot Password?")
                            .font(.customfont(.semibold, fontSize: 14))
                            .foregroundColor(.secondaryText)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                            .padding(.bottom, 20)
                    }
                    
                    
                    
                    if viewModel.showingError {
                        Text(viewModel.errorMessage)
                            .foregroundColor(.red)
                            .padding(.bottom, .screenWidth * 0.05)
                    }
                    
                    RoundButton(title: "Login", didTap: {
                        viewModel.login { success in
                            if success {
                                alertMessage = "Login successful!"
                                showAlert = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                    if viewModel.isAdmin {
                                        navigateToAdminHome = true
                                    } else {
                                        navigateToHome = true
                                    }
                                }
                            } else {
                                alertMessage = "Login failed. Please try again."
                                showAlert = true
                            }
                        }
                    })
                    .padding(.bottom, .screenWidth * 0.05)
                    
                    NavigationLink(destination: MainTabView(), isActive: $navigateToHome) {
                        EmptyView()
                    }
                    
                    NavigationLink(destination: MyCartView(), isActive: $navigateToAdminHome) {
                        EmptyView()
                    }
                    
                    HStack {
                        Text("Don't have an account?")
                            .font(.customfont(.semibold, fontSize: 14))
                            .foregroundColor(.primaryText)
                        
                        NavigationLink {
                            SignUpView()
                        } label: {
                            Text("Sign Up")
                                .font(.customfont(.semibold, fontSize: 14))
                                .foregroundColor(.primaryApp)
                        }
                    }
                    
                    Spacer()
                }
                .padding(.top, .topInsets + 64)
                .padding(.horizontal, 20)
                .padding(.bottom, .bottomInsets)
            }
            
            VStack {
                HStack {
                    Button {
                        // Handle back action if needed
                    } label: {
                        Image("back arrow")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                    }
                    Spacer()
                }
                Spacer()
            }
            .padding(.top, .topInsets)
            .padding(.horizontal, 20)
        }
        .navigationTitle("Login")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Notification"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        .onAppear {
            // Optionally print retrieved values for debugging
            if let username = viewModel.username {
                print("Username: \(username)")
            }
            if let email = viewModel.email {
                print("Email: \(email)")
            }
            if let uid = viewModel.uid {
                print("UID: \(uid)")
            }
            if let adminId = viewModel.adminId {
                print("Admin ID: \(adminId)")
            }
        }
    }
}

#Preview {
    LoginView()
}




