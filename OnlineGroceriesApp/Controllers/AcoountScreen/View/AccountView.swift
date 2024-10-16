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
    @State private var showingLogoutAlert = false
    
    var body: some View {
        NavigationStack{
            ZStack {
                VStack {
                    VStack(alignment: .leading) {
                        HStack(spacing: 15) {
                            
                            if let profileImageURL = accountVM.profileImageURL, !profileImageURL.isEmpty {
                                AsyncImage(url: URL(string: profileImageURL)) { image in
                                    image
                                        .resizable()
                                        .frame(width: 60, height: 60)
                                        .clipShape(Circle())
                                } placeholder: {
                                    Circle()
                                        .fill(Color.gray.opacity(0.3))
                                        .frame(width: 60, height: 60)
                                }
                            } else {
                                
                                Image("original 1")
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .clipShape(Circle())
                            }
                            
                            VStack(alignment: .leading) {
                                
                                Text(accountVM.username)
                                    .font(.customfont(.bold, fontSize: 20))
                                    .foregroundColor(.primaryText)
                                
                                Text(accountVM.email)
                                    .font(.customfont(.regular, fontSize: 16))
                                    .accentColor(.secondaryText)
                                
                            }
                            //                                                              .cornerRadius(30)
                            //                            Text(accountVM.username)
                            //                                .font(.customfont(.bold, fontSize: 20))
                            //                                .foregroundColor(.primaryText)
                            //                            Text(accountVM.email)
                            //                                                                  .font(.customfont(.regular, fontSize: 16))
                            //                                                                  .accentColor(.secondaryText)
                            
                            //                            NavigationLink(destination: EditProfileView()) {
                            //                                Image(systemName: "pencil")
                            //                                    .foregroundColor(.primaryApp)
                            //                            }
                            
                            //                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, .topInsets)
                        
                        Spacer()
                        
                        Divider()
                        
                        ScrollView {
                            LazyVStack {
                                VStack {
                                    AccountRow(title: "Orders", icon: "Orders icon", destination: AnyView(OrderView()))
                                    AccountRow(title: "My Details", icon: "My Details icon", destination: AnyView(MyDetailsView()))
                                    AccountRow(title: "Delivery Address", icon: "Delicery address", destination: AnyView(DeliveryAddresss()))
                                    // AccountRow(title: "About", icon: "about icon", destination: AnyView(OrderView()))
                                }
                                
                                NavigationLink(destination: WelcomeView(), isActive: $needToShowLoginView) {
                                    EmptyView()
                                }
                                
                                //                                Button(action: {
                                //                                    viewModel.logout()
                                //                                    needToShowLoginView = true
                                //                                }) {
                                //                                    ZStack {
                                //                                        Text("Log Out")
                                //                                            .font(.customfont(.semibold, fontSize: 18))
                                //                                            .foregroundColor(.primaryApp)
                                //                                            .multilineTextAlignment(.center)
                                //
                                //                                        HStack {
                                //                                            Spacer()
                                //                                            Image("Group 6892")
                                //                                                .resizable()
                                //                                                .scaledToFit()
                                //                                                .frame(width: 20, height: 20)
                                //                                                .padding(.trailing, 20)
                                //                                        }
                                //                                    }
                                //                                }
                                //                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60)
                                //                                .background(Color(hex: "F2F3F2"))
                                //                                .cornerRadius(20)
                                //                                .padding(.horizontal, 15)
                                //                                .padding(.vertical, 15)
                            }
                        }
                        Button(action: {
                            showingLogoutAlert = true
                            
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
                    .padding(.bottom, .bottomInsets + 60)
                }
                .ignoresSafeArea()
                .alert(isPresented: $showingLogoutAlert) {
                    Alert(
                        title: Text("Log Out"),
                        message: Text("Are you sure you want to log out?"),
                        primaryButton: .destructive(Text("Log Out")) {
                            viewModel.logout()
//                            needToShowLoginView = true
                        },
                        secondaryButton: .cancel()
                    )
                }
            }
            .onAppear {
                accountVM.fetchUserData()
            }
        }
    }
}


