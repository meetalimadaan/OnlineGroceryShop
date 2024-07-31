//
//  WelcomeView.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 17/07/24.
//

import SwiftUI

struct WelcomeView: View {
    @State private var navigateToLogin = false
    
    var body: some View {
        ZStack{
            Image("8140 1")
                .resizable()
                .scaledToFill()
                .frame(width: .screenWidth, height: .screenHeight)
            
            VStack{
                Spacer()
                
                Image("Group")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .padding(.bottom, 8)
                
                
                Text("Welcome to out store")
                    .font(.customfont(.semibold, fontSize: 48))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                
                
                Text("Get your groceries in as fast as one hour")
                    .font(.customfont(.medium, fontSize: 16))
                    .foregroundColor(.white.opacity(0.7))
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 30)
                
                
                RoundButton(title: "Get Started", destination: AnyView(LoginView()))
                    .padding(.bottom, .screenWidth * 0.05)
//                NavigationLink(destination: LoginView(), isActive: $navigateToLogin) {
//                                        RoundButton(title: "Get Started"){
//                                            navigateToLogin = true
//                                        }
//                                    }
//                
                
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

#Preview {
    
    NavigationView{
        WelcomeView()
    }
  
    
}
