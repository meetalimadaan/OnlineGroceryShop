//
//  HomeView.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 17/07/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject var homeVM = HomeViewModel()
    @StateObject var exploreVM = ExploreVireModel()
    
    @State var isLoadingExclusiveOffers = false
    @State var isLoadingBestSelling = false
    @State var isLoadingGroceries = false
    
    var body: some View {
        NavigationView{
            ZStack {
                ScrollView {
                    VStack {
                        Image("Group-2")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25)
                        
                        NavigationLink {
                            SelectLocationView()
                        } label: {
                            HStack {
                                Image("Exclude")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 16, height: 16)
                                
                                Text("dhaka, Banassre")
                                    .font(.customfont(.semibold, fontSize: 18))
                                    .foregroundColor(.darkGray)
                            }
                        }
                        
                        SearchTextField(placeholder: "Search Store", txt: $homeVM.txtSearch)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                    }
                    .padding(.top, .topInsets)
                    
                    Image("banner")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 115)
                        .padding(.horizontal, 20)
                    
                    SectionTitleAll(title: "Exclusive offer", titleAll: "See All") {}
                        .padding(.horizontal, 20)
                    
                    
                    
                    if isLoadingExclusiveOffers {
                        ShimmerView()
                            .frame(height: 120)
                            .padding(.horizontal, 20)
                    } else {
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 15) {
                                ForEach(homeVM.products) { product in
                                    ProductCell(product: product) {
                                        // Handle add to cart action here
                                    }
                                }
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 4)
                        }
                    }
                    
                    SectionTitleAll(title: "Best Selling", titleAll: "See All") {}
                        .padding(.horizontal, 20)
                    
                    if isLoadingBestSelling {
                        ShimmerView()
                            .frame(height: 120)
                            .padding(.horizontal, 20)
                    } else {
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 15) {
                                ForEach(homeVM.products) { product in
                                    ProductCell(product: product) {
                                        // Handle add to cart action here
                                    }
                                }
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 4)
                        }
                    }
                    
                    SectionTitleAll(title: "Groceries", titleAll: "See All") {}
                        .padding(.horizontal, 20)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 15) {
                            ForEach(exploreVM.categories) { category in
                                CategoryCell(category: category){
                                    
                                }
                            }
                            //
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 4)
                    }
                    .padding(.bottom, 8)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 15) {
                            ForEach(homeVM.products) { product in
                                ProductCell(product: product) {
                                    
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 4)
                    }
                    .padding(.bottom, .bottomInsets + 60)
                }
            }
            .ignoresSafeArea()
            
            .onAppear {
                isLoadingExclusiveOffers = true
                isLoadingBestSelling = true
                isLoadingGroceries = true
                homeVM.fetchProducts { isSuccess in
                    isLoadingExclusiveOffers = false
                    isLoadingBestSelling = false
                    isLoadingGroceries = false
                }
            }
        }
    }
}

#Preview {
    HomeView(homeVM: HomeViewModel(), exploreVM: ExploreVireModel())
}
