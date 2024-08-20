//
//  ProductCell.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 18/07/24.
//

import SwiftUI

struct ProductCell: View {
    @ObservedObject var viewModel: ProductCellViewModel
    
    var body: some View {
        NavigationLink(destination: ProductDetailsView(product: viewModel.product)) {
            VStack {
                AsyncImage(url: URL(string: viewModel.product.img)) { image in
                    image.resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 80)
                } placeholder: {
                    ShimmerView()
                }
                
                Spacer()
                
                Text(viewModel.product.name)
                    .font(.customfont(.bold, fontSize: 16))
                    .foregroundColor(.primaryText)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                
                Text("\(viewModel.product.stock) pcs")
                    .font(.customfont(.medium, fontSize: 14))
                    .foregroundColor(.secondaryText)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                Spacer()
                
                Text("Rs\(viewModel.product.price, specifier: "%.2f")")
                    .font(.customfont(.semibold, fontSize: 18))
                    .foregroundColor(.primaryText)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                HStack {
                    if viewModel.showQuantity {
                        IncrementDecrementButton(viewModel: viewModel)
                            .frame(width: 80, height: 45)
                    } else {
                        Button {
                            viewModel.addProductToCart()
                        } label: {
                            HStack {
                                Image("Vector-3")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 15, height: 15)
                                
                                Text("Add to Basket")
                                    .font(.customfont(.semibold, fontSize: 14))
                                    .foregroundColor(.white)
                            }
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                        }
                        .frame(width: 150, height: 45)
                        .background(Color.primaryApp)
                        .cornerRadius(15)
                    }
                }
            }
            .padding(15)
            .frame(width: 180, height: 230)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.primaryText.opacity(0.5), lineWidth: 1)
            )
        }
    }
}
