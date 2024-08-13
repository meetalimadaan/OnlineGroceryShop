//
//  FavouriteView.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 23/07/24.
//

import SwiftUI

struct FavouriteView: View {
    @StateObject private var viewModel = FavouriteViewModel()
    
    var body: some View {
        
        ZStack {
            
            ScrollView{
                LazyVStack{
                    
                    ForEach(viewModel.favouriteProducts) { product in
                        FavouriteRow(product: product)
                    }
                    
                }
                .padding(20)
                .padding(.top, .topInsets + 46)
                .padding(.bottom, .bottomInsets + 60)
                
                
            }
          
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
                
                
                //                RoundButton(title: "Add All To Cart")
                //                    .padding(.horizontal, 20)
                //                    .padding(.bottom, .bottomInsets + 80)
            }
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea()
        .onAppear {
            viewModel.fetchFavourites()
        }
    }
}

#Preview {
    FavouriteView()
}
