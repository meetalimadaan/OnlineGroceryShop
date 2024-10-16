//
//  ProductCellAll.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 25/09/24.
//

import SwiftUI

struct ProductCellAll: View {
    var product: Product
        
        var body: some View {
            VStack {
             
                AsyncImage(url: URL(string: product.img)) { image in
                    image.resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .cornerRadius(10)
                } placeholder: {
                    ProgressView()
                        .frame(width: 80, height: 80)
                }
                
                
                Text(product.name)
                    .font(.customfont(.medium, fontSize: 14))
                    .foregroundColor(.primaryText)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
//                    .padding(.top, 5)
                    .frame(maxWidth: 100)
            }
            .padding(10)
            .frame(width: 150, height: 120)
            .background(Color.white)
            .cornerRadius(10)
           /* .shadow(radius: 5)*/
        }
    }
