//
//  AllProducts.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 28/08/24.
//

import SwiftUI

struct AllProducts: View {
    @StateObject var exploreVM = ExploreVireModel()
    @State private var showModal = false
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State private var selectedCategory: String = "All"
    
    var column = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15)
    ]
    
    var body: some View {
//        NavigationView {
            ZStack {
                VStack {
                    HStack {
                        Button {
                            mode.wrappedValue.dismiss()
                        } label: {
                            Image("back arrow")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                        }
                        
                        Text("All Products")
                            .font(.customfont(.bold, fontSize: 20))
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                        
                        Button {
                            showModal.toggle()
                        } label: {
                            Image("Group 6839")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                        }
                        .sheet(isPresented: $showModal) {
                            FilterProductsWithCategory(selectedCategory: $selectedCategory)
                                .environmentObject(exploreVM)
                                .presentationDetents([.height(300)])
                        }
                    }
//                    HStack {
//                        Spacer()
//                        
//                        Text("All Products")
//                            .font(.customfont(.bold, fontSize: 20))
//                            .frame(height: 46)
//                        
//                        Spacer()
//                    }
//                    .padding(.top, .topInsets)
                    
                    SearchTextField(placeholder: "Search Products", txt: $exploreVM.searchText)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 4)
                    
                    ScrollView {
                        LazyVGrid(columns: column, spacing: 15) {
                            ForEach(exploreVM.products.filter { exploreVM.searchText.isEmpty ? true : $0.name.contains(exploreVM.searchText) }) { product in
                                ProductCell(viewModel: ProductCellViewModel(product: product))
                            }
                        }
                        .padding(.horizontal, 10)
                        .padding(.bottom, .bottomInsets)
                    }
                    Spacer()
                }
            }
//            .ignoresSafeArea()
            .navigationBarBackButtonHidden(true)
            .onAppear {
                exploreVM.fetchAllProducts { success, error in
                    if success {
                        print("All products fetched successfully")
                    } else {
                        print("Failed to fetch products: \(error ?? "Unknown error")")
                    }
                }
            }
        }
    }
    //#Preview {
    //    AllProducts()
    //}

