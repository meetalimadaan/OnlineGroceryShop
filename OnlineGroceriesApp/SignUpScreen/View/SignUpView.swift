//
//  SignUpView.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 17/07/24.
//

import SwiftUI

struct SignUpView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @StateObject var signVM = LoginViewModel.shared
    
    var body: some View {
        ZStack{
            
            Image("Rectangle 17")
                .resizable()
                .scaledToFill()
                .frame(width: .screenWidth, height: .screenHeight)
            
            ScrollView{
                
                VStack{
                    
                    Image("Group-2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40)
                        .padding(.bottom, .screenWidth * 0.1)
           
                    
                    Text("Sign Up")
                        .font(.customfont(.semibold, fontSize: 26))
                        .foregroundColor(.primaryText)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 4)
                    
                    Text("Enter your credentials to continue")
                        .font(.customfont(.semibold, fontSize: 16))
                        .foregroundColor(.secondaryText)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, .screenWidth * 0.1)
                    
                    LineTextField(  title: "Username", placeholder: "Enter your username",txt: $signVM.txtUsername)
                        .padding(.bottom, .screenWidth * 0.07)
                    
                    LineTextField(  title: "Email", placeholder: "Enter your email address",txt: $signVM.txtEmail, keyboardType: .emailAddress)
                        .padding(.bottom, .screenWidth * 0.07)
                    
                    LineSecureField( title: "Password", placeholder: "Enter your password",txt: $signVM.txtPassword, isShowPassword: $signVM.isShowPassword)
                    //                    .modifier( showButton( isShow: $loginVM.isShowPassword))
                        .padding(.bottom, .screenWidth * 0.04)
                    
                    VStack{
                        Text("By continuing you agree to our")
                            .font(.customfont(.medium, fontSize: 14))
                            .foregroundColor(.secondaryText)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        
                        HStack{
                            Text("Terms of Service")
                                .font(.customfont(.medium, fontSize: 14))
                                .foregroundColor(.primaryApp)
                            //                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            
                            Text("  and  ")
                                .font(.customfont(.medium, fontSize: 14))
                                .foregroundColor(.secondaryText)
                            //                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            
                            Text("Privacy Policy")
                                .font(.customfont(.medium, fontSize: 14))
                                .foregroundColor(.primaryApp)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            
                        }
                        .padding(.bottom, .screenWidth * 0.02)
                    }
                    
                    
                    
                    
                    RoundButton(title: "Sign Up") {
                        
                    }
                    .padding(.bottom, .screenWidth * 0.05)
                    
                    NavigationLink {
                        LoginView()
                    } label: {
                        HStack{
                            Text("Already have an account?")
                                .font(.customfont(.semibold, fontSize: 14))
                                .foregroundColor(.primaryText)
                            
                            Text("Sign In")
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
            
            VStack{
                HStack{
                    Button{
                        mode.wrappedValue.dismiss()
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
            . padding(.top, .topInsets)
            .padding(.horizontal, 20)
        }
        
        .navigationTitle("wehhdef")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
    }
}

#Preview {
    SignUpView()
}
