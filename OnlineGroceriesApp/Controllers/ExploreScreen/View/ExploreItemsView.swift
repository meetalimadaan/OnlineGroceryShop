//
//  ExploreItemsView.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 22/07/24.
//

import SwiftUI

struct ExploreItemsView: View {
    @StateObject var exploreVM = ExploreVireModel()
    @State private var showModal = false
    @State private var selectedStatus: String = "Price: Low to High"
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    var category: Category
    
    var column = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]
    
    var body: some View {
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
                    
                    Text(category.name ?? "")
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
                        FilterProductsView(selectedStatus: $selectedStatus)
                            .presentationDetents([.height(300)])
                    }
                }
                
                ScrollView {
                    LazyVGrid(columns: column, spacing: 20) {
                        ForEach(filteredProducts) { product in
                            ProductCell(viewModel: ProductCellViewModel(product: product))
                                .padding()
                        }
                    }
//                    .padding(.vertical, 10)
                    .padding(.horizontal, 10)
                    .padding(.bottom, .bottomInsets + 60)
                }
            }
            .padding(.top, .topInsets)
//            .padding(.horizontal, 5)
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea()
        .onAppear {
            exploreVM.fetchProducts(byCategoryID: category.id ?? "") { success, error in
                if success {
                    print("Products fetched successfully.......")
                } else {
                    print("Failed to fetch products: \(error ?? "Unknown error")")
                }
            }
        }
    }
    
    // Filtered and sorted products based on selected status
    var filteredProducts: [Product] {
        switch selectedStatus {
        case "Price: Low to High":
            return exploreVM.products.sorted { $0.price < $1.price }
        case "Price: High to Low":
            return exploreVM.products.sorted { $0.price > $1.price }
        default:
            return exploreVM.products
        }
    }
}


//#Preview {
//    ExploreItemsView()
//}
