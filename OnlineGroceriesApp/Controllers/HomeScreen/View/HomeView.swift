//
//  HomeView.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 17/07/24.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var exploreVM = ExploreVireModel()
    @StateObject var orderVM = OrderViewModel()
    @EnvironmentObject var homeVM: HomeViewModel
    
    @State var isLoadingExclusiveOffers = false
    @State var isLoadingBestSelling = false
    @State var isLoadingGroceries = false
    
    @State private var searchText1: String = ""
    @State private var selectedImageIndex: Int = 0
    @State private var showLocationModal: Bool = false
    
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
                        
                        
                        Button(action: {
                            showLocationModal.toggle()
                        }) {
                            Image("Exclude")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 16, height: 16)
                            
                            if let savedAddress = homeVM.savedAddress {
                                Text("\(savedAddress.city), \(savedAddress.country)")
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
                    
                    
                    .onReceive(timer) { _ in
                        
                        withAnimation {
                            selectedImageIndex = (selectedImageIndex + 1) % images.count
                        }
                    }
                    
                    
                    SectionTitleAll(title: "Exclusive offer")
                        .padding(.horizontal, 20)
                    
                    if isLoadingExclusiveOffers {
                        ShimmerView()
                            .frame(height: 120)
                            .padding(.horizontal, 20)
                    } else {
                        
                        let exclusiveOfferProducts = homeVM.filteredProducts.filter { $0.price < 20 }
                        
                        if exclusiveOfferProducts.isEmpty {
                            Text("No exclusive offers available")
                                .padding(.horizontal, 20)
                                .padding(.vertical, 4)
                        } else {
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack(spacing: 15) {
                                    ForEach(exclusiveOfferProducts) { product in
                                        ProductCell(viewModel: ProductCellViewModel(product: product))
                                    }
                                }
                                .padding(.horizontal, 20)
                                .padding(.vertical, 4)
                            }
                        }
                    }
                    
                    
                    // Filter delivered orders
                    let deliveredOrders = orderVM.orders.filter { $0.status == "Delivered" }
                    
                    
                    let deliveredProductIDs = Set(deliveredOrders.flatMap { order in
                        order.cartItems.map { $0.id }
                    })
                    
                    
                    let previouslyBoughtProducts = homeVM.filteredProducts.filter { product in
                        deliveredProductIDs.contains(product.id ?? "")
                    }
                    
                    
                    if !previouslyBoughtProducts.isEmpty {
                        SectionTitleAll(title: "Previously Bought")
                            .padding(.horizontal, 20)
                        
                        if isLoadingBestSelling {
                            ShimmerView()
                                .frame(height: 120)
                                .padding(.horizontal, 20)
                        } else {
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack(spacing: 15) {
                                    ForEach(previouslyBoughtProducts) { product in
                                        ProductCell(viewModel: ProductCellViewModel(product: product))
                                    }
                                }
                                .padding(.horizontal, 20)
                                .padding(.vertical, 4)
                            }
                        }
                    }
                    
                    
                    
                    
                    
                    SectionTitleAll(title: "Groceries")
                        .padding(.horizontal, 20)
                    
                    if isLoadingGroceries {
                        ShimmerView()
                            .frame(height: 120)
                            .padding(.horizontal, 20)
                    } else {
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 15) {
                                ForEach(exploreVM.categories) { category in
                                    CategoryCell(category: category) {
                                        
                                    }
                                }
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 4)
                        }
                        .padding(.bottom, 8)
                        
                        SectionViewAllProducts(titleAll: "See all Products") {
                            
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 8)
                        .frame(maxWidth: .infinity)
                        
                        
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
                    homeVM.fetchSavedAddress()
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
            .sheet(isPresented: $showLocationModal) {
                            SelectLocationView()
                    .presentationDetents([.height(400)])
                        }
        }
        
    }
}

//#Preview {
//    HomeView(homeVM: HomeViewModel(), exploreVM: ExploreVireModel())
//}
