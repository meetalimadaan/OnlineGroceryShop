//
//  FilterProductsWithCategory.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 20/09/24.
//

import SwiftUI

struct FilterProductsWithCategory: View {
    @Environment(\.dismiss) var dismiss
    @Binding var selectedCategory: String
    @EnvironmentObject var exploreVM: ExploreVireModel
    
    var body: some View {
        VStack {
            Text("Select Category")
                .font(.headline)
                .padding(.top, 20)
                .padding(.bottom, 10)
            
            ScrollView {
                LazyVStack {
                
                    ForEach(exploreVM.categories, id: \.id) { category in
                        FilterRow(
                            status: category.name ?? "Unknown",
                            isSelected: category.id == selectedCategory,
                            action: {
                                selectedCategory = category.id ?? ""
                            }
                        )
                        Divider()
                    }
                }
            }
            .frame(maxHeight: 200)
            
            Button(action: {
               
                if selectedCategory.isEmpty {
                    selectedCategory = "All"
                }
                exploreVM.fetchProducts(byCategoryID: selectedCategory) { success, error in
                    if success {
                        print("Products fetched successfully for category: \(selectedCategory)")
                    } else {
                        print("Failed to fetch products: \(error ?? "Unknown error")")
                    }
                }
                dismiss()
            }) {
                Text("Apply Filter")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            Spacer()
//
        }
        .onAppear {
           
            selectedCategory = selectedCategory.isEmpty ? "All" : selectedCategory
        }
    }
}


//#Preview {
//    FilterProductsWithCategory()
//}
