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
        NavigationView {
            ZStack {
                if viewModel.isLoading {
                    // Show loader while fetching data
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .primary))
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                } else {
                    if viewModel.favouriteProducts.isEmpty {
                        Text("No Favourite Product")
                            .font(.customfont(.bold, fontSize: 18))
                            .foregroundColor(.secondaryText)
                            .padding(.top, .topInsets + 46)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    } else {
                        ScrollView {
                            LazyVStack {
                                ForEach(viewModel.favouriteProducts) { product in
                                    NavigationLink(destination: ProductDetailsView(viewModel: ProductCellViewModel(product: product))) {
                                        FavouriteRow(product: product)
                                    }
                                }
                            }
                            .padding(20)
                            .padding(.top, .topInsets + 46)
                            .padding(.bottom, .bottomInsets + 60)
                        }
                        
                        VStack {
                            HStack {
                                Spacer()
                                
                                Text("Favourites")
                                    .font(.customfont(.bold, fontSize: 20))
                                    .frame(height: 46)
                                
                                Spacer()
                            }
                            .padding(.top, .topInsets)
                            .background(Color.white)
                            .shadow(color: Color.black.opacity(0.2), radius: 2)
                            
                            Spacer()
                            
                            // Uncomment if you want to add "Add All To Cart" button
                            // RoundButton(title: "Add All To Cart")
                            //     .padding(.horizontal, 20)
                            //     .padding(.bottom, .bottomInsets + 80)
                        }
                    }
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
}

#Preview {
    FavouriteView()
}
