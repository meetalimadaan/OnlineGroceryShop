//
//  WelcomeView.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 17/07/24.
//

import SwiftUI

struct WelcomeView: View {
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
                
                NavigationLink {
                    LoginView()
                } label: {
                    RoundButton(title: "Get Started") {
                    }
                }
                
                
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
