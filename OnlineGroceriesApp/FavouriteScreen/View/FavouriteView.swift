//
//  FavouriteView.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 23/07/24.
//

import SwiftUI

struct FavouriteView: View {
    var body: some View {
        
        ZStack {
            
            ScrollView{
                LazyVStack{
                    
                    FavouriteRow()
//
                }
                .padding(20)
                .padding(.top, .topInsets + 46)
                .padding(.bottom, .bottomInsets + 60)
                
               
            }
//            .padding(.top, .topInsets + 60)
            
            VStack{
                HStack{
                    Spacer()
                    
                   Text("Favourites")
                        .font(.customfont(.bold, fontSize: 20))
                        .frame(height: 46)
                    
                    Spacer()
                    
                }
                .padding(.top, .topInsets)
                .background(Color.white)
                .shadow(color: Color.black.opacity(0.2), radius: 2 )
               
                Spacer()
                
                 
                RoundButton(title: "Add All To Cart")
                    .padding(.horizontal, 20)
                    .padding(.bottom, .bottomInsets + 80)
            }
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

#Preview {
    FavouriteView()
}
