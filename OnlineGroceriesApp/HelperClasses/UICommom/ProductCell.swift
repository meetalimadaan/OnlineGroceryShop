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
        NavigationLink(destination: ProductDetailsView(viewModel: viewModel)) {
            
            VStack {
                AsyncImage(url: URL(string: viewModel.product.img)) { image in
                    image.resizable()
                        .scaledToFit()
                        .frame(width: 70, height: 70)
//                        .transition(.opacity)
                } placeholder: {
                    ShimmerView()
//                        .resizable()
                            .scaledToFit()
                        .frame(width: 70, height: 70)
                    .cornerRadius(8)
                }
                
                Spacer()
                
                Text(viewModel.product.name)
                    .font(.customfont(.bold, fontSize: 16))
                    .foregroundColor(.primaryText)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(height: 40)

                
                    
                Text("\(viewModel.product.stock ?? "")")
                    .font(.customfont(.medium, fontSize: 14))
                    .foregroundColor(.secondaryText)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                
//                Spacer()
//                Spacer()
//                
                Text("Rs \(viewModel.product.price, specifier: "%.2f")")
                    .font(.customfont(.semibold, fontSize: 18))
                    .foregroundColor(.primaryText)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                HStack {
                    if viewModel.showQuantity {
                        IncrementDecrementButton(viewModel: viewModel)
//                            .frame(width: 80, height: 45)
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
                            .padding(.vertical, 12)
                        }
                        .frame(width: 130, height: 45)
//                        .frame(maxWidth: .infinity, minHeight: 45)
                        .background(Color.primaryApp)
                        .cornerRadius(15)
                    }
                }
            }
            .padding(15)
            .frame(width: 160, height: 250)
//            .frame(maxWidth: .infinity)

            .background(Color.white)
                        .cornerRadius(16)
                        .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 1)
        }
    }
}

#Preview {
    ProductCell(viewModel: ProductCellViewModel(product: Product(name: "Hiiiiiiiiiiiiiiiiiiiiiiiiiiiiii", price: 200, img: "https://firebasestorage.googleapis.com/v0/b/grocery-shop-dabda.appspot.com/o/category_images%2FGroup%206837.png?alt=media&token=d8ad01f0-d4e5-422f-adb2-f77ea7c5fe68")))
}
