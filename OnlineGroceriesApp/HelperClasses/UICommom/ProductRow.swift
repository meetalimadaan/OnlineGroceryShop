//
//  ProductRow.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 05/09/24.
//

import SwiftUI

struct ProductRow: View {
    var item: CartItem
    
    var body: some View {
        HStack(spacing: 20) {
            // Product Image
            if let url = URL(string: item.img) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                } placeholder: {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 50, height: 50)
                }
            }

        
            VStack(alignment: .leading, spacing: 5) {
                Text(item.name)
                    .font(.headline)

                Text("Quantity: \(item.quantity)")
                    .font(.subheadline)
                    .foregroundColor(.gray)

                Text("Price: Rs\(item.price, specifier: "%.2f")")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}
