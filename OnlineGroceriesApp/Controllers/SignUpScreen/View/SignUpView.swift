//
//  SignUpView.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 17/07/24.
//
import SwiftUI

struct SignUpView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @StateObject var signVM = SignUpViewModel.shared
    @State private var showAlert: Bool = false
    @State var isShowPassword: Bool = false
    @State private var isLoading: Bool = false
    @State private var navigateToHome: Bool = false
    @StateObject private var homeVM = HomeViewModel()
    
    var body: some View {
        //        NavigationView{
        ZStack {
            Image("Rectangle 17")
                .resizable()
                .scaledToFill()
                .frame(width: .screenWidth, height: .screenHeight)
            
            //                ScrollView {
            VStack {
                Image("Group-2")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
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
                
                LineTextField(title: "Username", placeholder: "Enter your username", txt: $signVM.txtUsername)
                    .padding(.bottom, .screenWidth * 0.07)
                
                LineTextField(title: "Email", placeholder: "Enter your email address", txt: $signVM.txtEmail, keyboardType: .emailAddress)
                    .padding(.bottom, .screenWidth * 0.07)
                
                LineSecureField(title: "Password", placeholder: "Enter your password", txt: $signVM.txtPassword, isShowPassword: $signVM.isShowPassword)
                    .padding(.bottom, .screenWidth * 0.04)
                
//                VStack {
//                    Text("By continuing you agree to our")
//                        .font(.customfont(.medium, fontSize: 14))
//                        .foregroundColor(.secondaryText)
//                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
//                    
//                    HStack {
//                        Text("Terms of Service")
//                            .font(.customfont(.medium, fontSize: 14))
//                            .foregroundColor(.primaryApp)
//                        
//                        Text("  and  ")
//                            .font(.customfont(.medium, fontSize: 14))
//                            .foregroundColor(.secondaryText)
//                        
//                        Text("Privacy Policy")
//                            .font(.customfont(.medium, fontSize: 14))
//                            .foregroundColor(.primaryApp)
//                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
//                    }
//                    .padding(.bottom, .screenWidth * 0.02)
//                }
                
                if signVM.showingError {
                    Text(signVM.errorMessage)
                        .foregroundColor(.red)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.bottom, .screenWidth * 0.05)
                }
                
                RoundButton(title: "Sign Up", didTap: {
                                    isLoading = true
                                    signVM.signUp { success in
                                        if success {
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                                isLoading = false
                                                navigateToHome = true
                                            }
                                        } else {
                                            isLoading = false
                                            showAlert = true
                                        }
                                    }
                                })
                                .padding(.bottom, .screenWidth * 0.05)
                
                NavigationLink(destination: MainTabView().environmentObject(homeVM), isActive: $navigateToHome) {
                    EmptyView()
                }
                
                HStack {
                    Text("Already have an account?")
                        .font(.customfont(.semibold, fontSize: 14))
                        .foregroundColor(.primaryText)
                    
                    
                    NavigationLink(destination: LoginView()) {
                        Text("Sign In")
                            .font(.customfont(.semibold, fontSize: 14))
                            .foregroundColor(.primaryApp)
                    }
                    
                    //                        NavigationLink {
                    //                            LoginView()
                    //                        } label: {
                    //                            Text("Sign In")
                    //                                .font(.customfont(.semibold, fontSize: 14))
                    //                                .foregroundColor(.primaryApp)
                    //                        }
                }
                
                Spacer()
            }
            .padding(.top, .topInsets + 40)
            .padding(.horizontal, 20)
            .padding(.bottom, .bottomInsets)
            
            if isLoading {
                           LoaderView()
                       }
           
            VStack {
                HStack {
                    Button {
                        mode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
//                            .resizable()
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
        .navigationTitle("SIGNUP")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
//        .alert(isPresented: $showAlert) {
//            Alert(title: Text("Notification"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
//        }
    }
}
//}
#Preview {
    SignUpView()
}
