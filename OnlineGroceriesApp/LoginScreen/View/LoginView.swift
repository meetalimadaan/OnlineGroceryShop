//
//  LoginView.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 17/07/24.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.presentationMode)  var mode: Binding<PresentationMode>
    @StateObject var loginVM = LoginViewModel.shared
    @State private var navigateToMainTabView = false
    
    var body: some View {
        ZStack{
            Image("Rectangle 17")
                .resizable()
                .scaledToFill()
                .frame(width: .screenWidth, height: .screenHeight)
            
            
            VStack{
                
                Image("Group-2")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40)
                    .padding(.bottom, .screenWidth * 0.1)
                
                Text("Loging")
                    .font(.customfont(.semibold, fontSize: 26))
                    .foregroundColor(.primaryText)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 4)
                
                Text("Enter your emails and password")
                    .font(.customfont(.semibold, fontSize: 16))
                    .foregroundColor(.secondaryText)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, .screenWidth * 0.1)
                
                LineTextField(  title: "Email", placeholder: "Enter your email address",txt: $loginVM.txtEmail, keyboardType: .emailAddress)
                    .padding(.bottom, .screenWidth * 0.07)
                
                LineSecureField( title: "Password", placeholder: "Enter your password",txt: $loginVM.txtPassword, isShowPassword: $loginVM.isShowPassword)
                    .padding(.bottom, .screenWidth * 0.02)
                
                Button{
                    
                } label: {
                    Text("Forgot Password?")
                        .font(.customfont(.medium, fontSize: 14))
                        .foregroundColor(.primaryText)
                }
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                .padding(.bottom, .screenWidth * 0.03)
                
                
                NavigationLink(destination: MainTabView(), isActive: $navigateToMainTabView) {
                    RoundButton(title: "Log In") {
                        navigateToMainTabView = true
                    }
                }
                .padding(.bottom, .screenWidth * 0.05)
                
                NavigationLink {
                    SignUpView()
                } label: {
                    HStack{
                        Text("Don't have an account?")
                            .font(.customfont(.semibold, fontSize: 14))
                            .foregroundColor(.primaryText)
                        
                        Text("Signup")
                            .font(.customfont(.semibold, fontSize: 14))
                            .foregroundColor(.primaryApp)
                    }
                }
                
                Spacer()
            }
            
            .padding(.top, .topInsets + 64)
            .padding(.horizontal,20)
            .padding(.bottom, .bottomInsets)
            
            
        }
        
        .background(Color.white)
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea()
        
    }
    
}

#Preview {
    NavigationView {
        LoginView()
    }
    //    LoginView()
}

