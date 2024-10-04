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
                // Display product image
                AsyncImage(url: URL(string: product.img)) { image in
                    image.resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80) // Adjust the size as needed
                        .cornerRadius(10)
                } placeholder: {
                    ProgressView()
                        .frame(width: 80, height: 80)
                }
                
                // Display product name
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
            .background(Color.white) // Background for each cell
            .cornerRadius(10)
           /* .shadow(radius: 5)*/ // Optional: Add shadow for better appearance
        }
    }
