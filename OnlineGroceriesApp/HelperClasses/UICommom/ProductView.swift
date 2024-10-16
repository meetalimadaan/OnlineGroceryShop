//
//  ProductView.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 09/10/24.
//

import SwiftUI

struct ProductView: View {
    let product: Product
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 8) {
            Image("png-clipart-chatbot-logo-robotics-robot-electronics-leaf-thumbnail")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .clipShape(Circle())
        NavigationLink(destination: ProductDetailsView(viewModel: ProductCellViewModel(product: product))) {
            
            VStack(alignment: .center) {
                
                AsyncImage(url: URL(string: product.img)) { image in
                    image.resizable()
                        .scaledToFit()
                        .cornerRadius(10)
                        .frame(height: 100)
                } placeholder: {
                    ProgressView()
                }
                
                
                HStack(alignment: .center) {
                    VStack(alignment: .center) {
                        Text(product.name)
                            .font(.customfont(.bold, fontSize: 16))
                            .foregroundColor(.primaryText)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                        
                        
                        
                        Text("Rs \(product.price, specifier: "%.2f")")
                            .font(.customfont(.semibold, fontSize: 18))
                            .foregroundColor(.primaryText)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                    }
                    Spacer()
                }
                .padding(.bottom, 5)
                
                
                Text(product.description!)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.bottom, 10)
                
                Spacer()
            }
            }
            .padding()
            .background(Color(UIColor.systemGray6))
            .cornerRadius(15)
            .frame(maxWidth: 250)
            .shadow(radius: 1)
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
        }
            
    }
}

