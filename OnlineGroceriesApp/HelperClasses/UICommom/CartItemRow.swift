//
//  CartItemRow.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 25/07/24.
//

import SwiftUI
struct CartItem: Identifiable {
    var id: String
    var name: String
    var price: Double
    var quantity: Int
    var img: String
}
struct CartItemRow: View {
    var cartItem: CartItem
    
    var body: some View {
        VStack{
            HStack(spacing: 15){
                
//                Image("92f1ea7dcce3b5d06cd1b1418f9b9413 3")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 60, height: 60)
                
                AsyncImage(url: URL(string: cartItem.img)) { image in
                                    image.resizable()
                                        .scaledToFit()
                                        .frame(width: 60, height: 60)
                                } placeholder: {
                                    ShimmerView()
                                }
               
                
                VStack(spacing:4){
                    
                    HStack{
                        Text(cartItem.name)
                            .font(.customfont(.bold, fontSize: 16))
                            .foregroundColor(.primaryText)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        
                        Button{
//                            removeProductFromCart()
                        } label: {
                            Image("Group 6862")
                                .resizable()
                                .frame(width: 18, height: 18)
                        }
                    }
                    
                    
                    Text("\(cartItem.quantity) pcs. price")
                        .font(.customfont(.medium, fontSize: 14))
                        .foregroundColor(.secondaryText)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 8)
                    
                    
                    HStack{
                        
                        Button{
                            
                        } label: {
                            Image("Vector-5")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .padding(10)
                        }
                        .padding(4)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.secondaryText.opacity(0.5), lineWidth: 1)
                        )
                        
                        Text("\(cartItem.quantity)")
                            .font(.customfont(.semibold, fontSize: 24))
                            .foregroundColor(.primaryText)
                            .multilineTextAlignment(.center)
                            .frame(width: 45, height: 45, alignment: .center)
                        //                            .overlay(
                        //                                RoundedRectangle(cornerRadius: 16)
                        //                                    .stroke(Color.secondaryText.opacity(0.5), lineWidth: 1)
                        //                            )
                        
                        Button{
                            
                        } label: {
                            Image("Vector-6")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .padding(10)
                        }
                        .padding(4)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.secondaryText.opacity(0.5), lineWidth: 1)
                        )
//                    how to get api from h
                        Spacer()
                        
                        Text("Rs\(cartItem.price * Double(cartItem.quantity), specifier: "%.2f")")
                            .font(.customfont(.semibold, fontSize: 18))
                            .foregroundColor(.primaryText)
                    }
                }
                
                
            }
            Divider()
        }
    }
    
}
//#Preview {
//    CartItemRow()
//        .padding(.horizontal, 20)
//}
