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
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15)
    ]
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button {
                        mode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .scaledToFit()
                            .frame(width: 32, height: 32)
                            .foregroundColor(.primaryApp)
                    }
                    
                    Text(category.name ?? "category")
                        .font(.customfont(.bold, fontSize: 20))
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                    
                    Button {
                        showModal.toggle()
                    } label: {
                        Image(systemName: "slider.horizontal.3")
//                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.primaryApp)
                    }
                    .sheet(isPresented: $showModal) {
                        FilterProductsView(selectedStatus: $selectedStatus)
                            .presentationDetents([.height(300)])
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 24))
        
                ScrollView {
                    LazyVGrid(columns: column, spacing: 0) {
                        ForEach(filteredProducts) { product in
                         
                            ProductCell(viewModel: ProductCellViewModel(product: product))
//                                .frame(width: 200, height: 230)
                                .padding()
                        }
                    }
                    .padding(.horizontal, 15)
                    .padding(.bottom, .bottomInsets + 60)
                }
            }
            .padding(.top, .topInsets)
            
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea()
        .onAppear {
            exploreVM.fetchProducts(byCategoryID: category.id ?? "") { success, error in
                if success {
                    print("Products fetched  successfully.......",filteredProducts)
                    
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


#Preview {
    ExploreItemsView(category: Category(id: "G05A8sxjBMZ2qMGzne2V", name: "Dairy & Eggs", imgURL: ""))
}
