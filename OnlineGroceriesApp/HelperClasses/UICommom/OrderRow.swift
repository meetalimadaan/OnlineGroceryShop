//
//  OrderRow.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 06/09/24.
//

import SwiftUI

struct OrderRow: View {
    let order: Order
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
           
            HStack {
                Text("Rs\(order.totalPrice, specifier: "%.2f")")
                Text(order.orderDate, formatter: DateFormatter.shortDate)
                Spacer()
                Image("back arrow 1")
                                   .resizable()
                                   .scaledToFit()
                                   .frame(width: 15, height: 15)
            }
            .font(.subheadline)
            .foregroundColor(.gray)
            
          
         
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(order.cartItems) { item in
                                    if let url = URL(string: item.img) {
                                        AsyncImage(url: url) { image in
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 50, height: 50)
                                                .clipShape(Circle())
                                        } placeholder: {
                                            Circle()
                                                .fill(Color.gray.opacity(0.3))
                                                .frame(width: 50, height: 50)
                                        }
                                    }
                                }
                            }
                            .padding(.vertical, 5)
                        }
                        .frame(height: 60)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                }
            }
