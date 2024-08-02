//
//  WelcomeView.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 17/07/24.
//

import SwiftUI

struct WelcomeView: View {
    @StateObject private var viewModel = WelcomeViewModel()
    @State private var navigateToLogin = false
    
    var body: some View {
        ZStack {
            Image("8140 1")
                .resizable()
                .scaledToFill()
                .frame(width: .screenWidth, height: .screenHeight)
            
            VStack {
                Spacer()
                
                Image("Group")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .padding(.bottom, 8)
                
                Text("Welcome to our store")
                    .font(.customfont(.semibold, fontSize: 48))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                
                Text("Get your groceries in as fast as one hour")
                    .font(.customfont(.medium, fontSize: 16))
                    .foregroundColor(.white.opacity(0.7))
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 30)
                
                NavigationLink(
                    destination: LoginView()
                        .environmentObject(viewModel),
                    isActive: $navigateToLogin
                ) {
                    RoundButton(title: "Get Started", didTap: {
                        viewModel.fetchAdminId()
                        navigateToLogin = true
                    })
                }
                .padding(.bottom, .screenWidth * 0.05)
                
                Spacer()
                    .frame(height: 80)
            }
            .padding(.horizontal, 20)
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}


