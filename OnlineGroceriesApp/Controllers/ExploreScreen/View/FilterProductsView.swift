//
//  FilterProductsView.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 02/09/24.
//

import SwiftUI

struct FilterProductsView: View {
    @StateObject var exploreVM = ExploreVireModel()
    @State private var selectedSortOption: SortOption = .lowToHigh
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    VStack {
                        HStack {
                            Spacer()
                            
                            Text("Filtered Products")
                                .font(.customfont(.bold, fontSize: 20))
                                .frame(height: 46)
                            
                            Spacer()
                        }
                        .padding(.top, .topInsets)
                        
                        Picker("Sort by", selection: $selectedSortOption) {
                            Text("Price: Low to High").tag(SortOption.lowToHigh)
                            Text("Price: High to Low").tag(SortOption.highToLow)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding()
                        .onChange(of: selectedSortOption) { newOption in
                            exploreVM.sortOption = newOption
                            exploreVM.fetchAllProducts { success, error in
                                if success {
                                    print("All products fetched and sorted successfully")
                                } else {
                                    print("Failed to fetch products: \(error ?? "Unknown error")")
                                }
                            }
                        }
                        
                        ScrollView {
                            LazyVGrid(columns: [GridItem(.flexible(), spacing: 15), GridItem(.flexible(), spacing: 15)], spacing: 15) {
                                ForEach(exploreVM.products) { product in
                                    ProductCell(viewModel: ProductCellViewModel(product: product))
                                }
                            }
                            .padding(.horizontal, 20)
                            .padding(.bottom, .bottomInsets + 60)
                        }
                        Spacer()
                    }
                }
                .ignoresSafeArea()
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
    }
}
#Preview {
    FilterProductsView()
}
