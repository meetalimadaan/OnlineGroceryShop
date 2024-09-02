//
//  AccountView.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 22/07/24.
//

import SwiftUI

struct AccountView: View {
    @StateObject private var accountVM = AccountViewModel.shared
    @StateObject private var viewModel = LoginViewModel()
    @State private var needToShowLoginView = false
  
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    if accountVM.isLoading {
                        ProgressView()
                    } else {
                        VStack {
//                            HStack(spacing: 15) {
//                                Image("Rectangle 82")
//                                    .resizable()
//                                    .frame(width: 60, height: 60)
//                                    .cornerRadius(30)
                                
//                                VStack(alignment: .leading) {
                                    HStack {
                                        Text("My Profile")
                                            .font(.customfont(.bold, fontSize: 20))
                                            .foregroundColor(.primaryText)
                                        
                                        NavigationLink(destination: EditProfileView()) {
                                            Image(systemName: "pencil")
                                                .foregroundColor(.primaryApp)
                                        }
                                        
                                        Spacer()
                                    }
//                                    Spacer()
//                                    Text(accountVM.email)
//                                        .font(.customfont(.regular, fontSize: 16))
//                                        .accentColor(.secondaryText)
//                                }
                            
                            .padding(.horizontal, 20)
                            .padding(.top, .topInsets)
                            
                            Spacer()
                            
                            Divider()
                            
                            ScrollView {
                                LazyVStack {
                                    VStack {
                                        AccountRow(title: "Orders", icon: "Orders icon", destination: AnyView(OrderView()))
                                        AccountRow(title: "My Details", icon: "My Details icon", destination: AnyView(MyDetailsView()))
                                        AccountRow(title: "Delivery Address", icon: "Delicery address", destination: AnyView(CheckOut()))
//                                        AccountRow(title: "About", icon: "about icon", destination: AnyView(OrderView()))
                                    }
                                    
//                                    VStack {
//                                        AccountRow(title: "Notifications", icon: "Bell icon", destination: AnyView(OrderView()))
//                                        AccountRow(title: "Help", icon: "help icon", destination: AnyView(OrderView()))
//                                    }
                                    
                                    NavigationLink(destination: WelcomeView(), isActive: $needToShowLoginView) {
                                        EmptyView()
                                    }
                                    
                                    Button(action: {
                                        viewModel.logout()
                                        needToShowLoginView = true
                                    }) {
                                        ZStack {
                                            Text("Log Out")
                                                .font(.customfont(.semibold, fontSize: 18))
                                                .foregroundColor(.primaryApp)
                                                .multilineTextAlignment(.center)
                                            
                                            HStack {
                                                Spacer()
                                                Image("Group 6892")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 20, height: 20)
                                                    .padding(.trailing, 20)
                                            }
                                            
                                        }
                                    }
                                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60)
                                    .background(Color(hex: "F2F3F2"))
                                    .cornerRadius(20)
                                    .padding(.horizontal, 15)
                                    .padding(.vertical, 15)
                                }
                            }
                        }
                        .padding(.bottom, .bottomInsets + 20)
                    }
                }
                .ignoresSafeArea()
            }
            .onAppear {
                accountVM.fetchUserData()
            }
        }
    }
}

