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
    //    @StateObject var homeVM = HomeViewModel()
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
                        Image("back arrow")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                    }
                    
                    Text(category.name!)
                        .font(.customfont(.bold, fontSize: 20))
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                    //
                    //                    Button {
                    //                        mode.wrappedValue.dismiss()
                    //                    } label: {
                    //                        Image("Group 6839")
                    //                            .resizable()
                    //                            .scaledToFit()
                    //                            .frame(width: 20, height: 20)
                    //                    }
                    NavigationLink(destination: FilterProductsView()) {
                        Image("Group 6839")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                    }
                }
                
                ScrollView {
                    LazyVGrid(columns: column, spacing: 15) {
                        ForEach(exploreVM.products) { product in
                            ProductCell(viewModel: ProductCellViewModel(product: product))
                        }
                    }
                    .padding(.vertical, 10)
                    //                    ./*padding(.horizontal, 20)*/
                    .padding(.bottom, .bottomInsets + 60)
                }
            }
            .padding(.top, .topInsets)
            .padding(.horizontal, 20)
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
}

//#Preview {
//    ExploreItemsView()
//}
