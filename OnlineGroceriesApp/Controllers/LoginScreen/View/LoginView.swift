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
        @State private var isLoading: Bool = false
        @State var isShowPassword: Bool = false
        @State private var navigateToHome: Bool = false
        @State private var navigateToAdminHome: Bool = false
        @StateObject private var homeVM = HomeViewModel()
        
        var body: some View {
            ZStack {
                Image("Rectangle 17")
                    .resizable()
                    .scaledToFill()
                    .frame(width: .screenWidth, height: .screenHeight)
                
                VStack {
                    Image("Group-2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40)
                        .padding(.bottom, .screenWidth * 0.1)
                    
                    Text("Sign In")
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
                        
                        
                        isLoading = true
                        viewModel.login { success in
                            if success {
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                    isLoading = false
                                    if viewModel.isAdmin {
                                        navigateToAdminHome = true
                                    } else {
                                        navigateToHome = true
                                    }
                                }
                            } else {
                                isLoading = false
                                
                            }
                        }
                    })
                    .padding(.bottom, .screenWidth * 0.05)
                    
                    NavigationLink(destination: MainTabView().environmentObject(homeVM), isActive: $navigateToHome) {
                        EmptyView()
                    }
                    
                    NavigationLink(destination: MyCartView(), isActive: $navigateToAdminHome) {
                        EmptyView()
                    }
                    
                    HStack {
                        Text("Don't have an account?")
                            .font(.customfont(.semibold, fontSize: 14))
                            .foregroundColor(.primaryText)
                        
                        
                        NavigationLink(destination: SignUpView()) {
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
                if isLoading {
                    LoaderView()
                }
                
            }
            .navigationTitle("Login")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .ignoresSafeArea()
            
            .onAppear {
                
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
    //}
    #Preview {
        LoginView()
    }




