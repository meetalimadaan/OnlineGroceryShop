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
    
    @State private var searchText1: String = ""
    @State private var selectedImageIndex: Int = 0
    
    let images = ["grocery-ordering-and-delivery-word-vector", "istockphoto-1198965879-612x612", "1000_F_147219646_hVUhKxNhgX6A1nR5l7UUwYamVKGJULJ1"]
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationView{
            ZStack {
                ScrollView {
                    VStack {
                        Image("Group-2")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25)
                        
                        
                        NavigationLink(destination: SelectLocationView()) {
                            //
                            
                            Image("Exclude")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 16, height: 16)
                            
                            if let savedAddress = homeVM.savedAddress {
                                Text("\(savedAddress.city)")
                                    .font(.customfont(.semibold, fontSize: 18))
                                    .foregroundColor(.darkGray)
                            } else {
                                Text("Select Country")
                                    .font(.customfont(.semibold, fontSize: 18))
                                    .foregroundColor(.darkGray)
                            }
                        }
                        //                        SearchTextField(placeholder: "Search Store", txt: $homeVM.searchText)
                        //                            .padding(.horizontal, 20)
                        //                            .padding(.vertical, 10)
                    }
                    .padding(.top, .topInsets)
                    
                    //                    Image("banner")
                    //                        .resizable()
                    //                        .scaledToFit()
                    //                        .frame(height: 115)
                    //                        .padding(.horizontal, 20)
                    
                    TabView(selection: $selectedImageIndex) {
                        ForEach(0..<images.count, id: \.self) { index in
                            Image(images[index])
                                .resizable()
                                .scaledToFit()
                                .frame(width: 370, height: 150)
                                .padding(.horizontal, 20)
                                .tag(index)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                    .frame(width: 370, height: 150)
                    .padding(2)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                    )
                    .onReceive(timer) { _ in
                        
                        withAnimation {
                            selectedImageIndex = (selectedImageIndex + 1) % images.count
                        }
                    }
                    
                    
                    SectionTitleAll(title: "Exclusive offer", titleAll: "See All") {}
                        .padding(.horizontal, 20)
                    
                    
                    
                    if isLoadingExclusiveOffers {
                        ShimmerView(width: 100, height: 120)
                        //                            .frame(height: 120)
                            .padding(.horizontal, 20)
                    } else {
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 15) {
                                ForEach(homeVM.filteredProducts) { product in
                                    ProductCell(viewModel: ProductCellViewModel(product: product))
                                    
                                }
                            }
                            
                            .padding(.horizontal, 20)
                            .padding(.vertical, 4)
                        }
                    }
                    
                    SectionTitleAll(title: "Best Selling", titleAll: "See All") {}
                        .padding(.horizontal, 20)
                    
                    if isLoadingBestSelling {
                        ShimmerView(width: 100, height: 120)
                        //                            .frame(height: 120)
                            .padding(.horizontal, 20)
                    } else {
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 15) {
                                ForEach(homeVM.filteredProducts) { product in
                                    ProductCell(viewModel: ProductCellViewModel(product: product))
                                    
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
                            ForEach(homeVM.filteredProducts) { product in
                                ProductCell(viewModel: ProductCellViewModel(product: product))
                                
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
            .onAppear {
                homeVM.fetchSavedAddress()
            }
        }
    }
    
}

#Preview {
    HomeView(homeVM: HomeViewModel(), exploreVM: ExploreVireModel())
}
