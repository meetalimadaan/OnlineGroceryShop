//
//  AccountView.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 22/07/24.
//

import SwiftUI

struct AccountView: View {
    var body: some View {
        ZStack{
            
            VStack{
                
                HStack(spacing: 15){
                    Image("Rectangle 82")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .cornerRadius(30)
                    
                    VStack{
                        HStack{
                            Text("Username")
                                .font(.customfont(.bold, fontSize: 20))
                                .foregroundColor(.primaryText)
                            
                            Image(systemName: "pencil")
                                .foregroundColor(.primaryApp)
                            
                            Spacer()
                        }
                        //                        .padding(.bottom, 4)
                        
                        Text("Email")
                            .font(.customfont(.regular, fontSize: 16))
                        //                            .foregroundColor(.secondaryText)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .accentColor(.secondaryText)
                    }
                    
                }
                .padding(.horizontal, 20)
                .padding(.top, .topInsets)
                
                
                //               Divider()
                Divider()
                
                ScrollView{
                    
                    LazyVStack{
                        
                        VStack {
                            AccountRow(title: "Orders", icon: "Orders icon")
                            AccountRow(title: "My Details", icon: "My Details icon")
                            AccountRow(title: "Delivery Adress", icon: "Delicery address")
                            AccountRow(title: "About", icon: "about icon")
                        }
                        
                        VStack{
                            AccountRow(title: "Notifications", icon: "Bell icon")
                            AccountRow(title: "Help", icon: "help icon")
                        }
                        
                        Button{
                            
                        } label: {
                            
                            ZStack{
                                
                                
                                
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
        .ignoresSafeArea()
    }
}

#Preview {
    AccountView()
}
