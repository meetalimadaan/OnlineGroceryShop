//
//  SelectLocatonView.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 19/07/24.
//

import SwiftUI

struct SelectLocatonView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @StateObject var signVM = LoginViewModel.shared
    
    var body: some View {
        ZStack{
            Image("Rectangle 17")
                .resizable()
                .scaledToFill()
                .frame(width: .screenWidth, height: .screenHeight)
            
            VStack{
                
                Image("illustration")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 220, height: 170)
//                    .padding(.bottom, 350)
                
                Text("Select Your Location")
                    .font(.customfont(.semibold, fontSize: 26))
                    .foregroundColor(.primaryText)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                    .padding(.bottom, 4)
                
                Text("Switch on your location to stay in tune with what's happening in your area")
                    .font(.customfont(.medium, fontSize: 16))
                    .foregroundColor(.secondaryText)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
//                    .padding(.bottom, .screenWidth * 0.1)
                
                LineTextField(  title: "Your Zone", placeholder: "Enter your username",txt: $signVM.txtUsername)
                    .padding(.bottom, .screenWidth * 0.07)
                
                LineTextField(  title: "Your Area", placeholder: "Enter your email address",txt: $signVM.txtEmail, keyboardType: .emailAddress)
                    .padding(.bottom, .screenWidth * 0.07)
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
    SelectLocatonView()
}
