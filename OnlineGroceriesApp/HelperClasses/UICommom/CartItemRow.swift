//
//  CartItemRow.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 25/07/24.
//

import SwiftUI

struct CartItemRow: View {
    @ObservedObject var viewModel: ProductCellViewModel
    var cartItem: CartItem
    
    var body: some View {
        VStack{
            HStack(spacing: 15){
                
                AsyncImage(url: URL(string: cartItem.img)) { image in
                    image.resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                } placeholder: {
                    ProgressView()
                }
                
                
                VStack(spacing:4){
                    Spacer()
                    HStack{
                        
                        Text(cartItem.name)
                            .font(.customfont(.bold, fontSize: 16))
                            .foregroundColor(.primaryText)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        
                        Button{
                            viewModel.removeProductFromCart()
                        } label: {
                            Image("Group 6862")
                                .resizable()
                                .frame(width: 18, height: 18)
                        }
                    }
                    
                    
                    Text("\(cartItem.quantity)")
                        .font(.customfont(.medium, fontSize: 14))
                        .foregroundColor(.secondaryText)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 8)
                    
                    
                    HStack{
                        
                        Button{
                            viewModel.decrementQuantity()
                        } label: {
                            Image("Vector-5")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 10, height: 10)
                                .padding(10)
                        }
                        .padding(4)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.secondaryText.opacity(0.5), lineWidth: 1)
                        )
                        
                        Text("\(viewModel.cartQuantity)")
                            .font(.customfont(.semibold, fontSize: 16))
                            .foregroundColor(.primaryText)
                            .multilineTextAlignment(.center)
                            .frame(width: 45, height: 45, alignment: .center)
                        //                            .overlay(
                        //                                RoundedRectangle(cornerRadius: 16)
                        //                                    .stroke(Color.secondaryText.opacity(0.5), lineWidth: 1)
                        //                            )
                        
                        Button{
                            viewModel.incrementQuantity()
                        } label: {
                            Image("Vector-6")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 10, height: 10)
                                .padding(10)
                        }
                        .padding(4)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.secondaryText.opacity(0.5), lineWidth: 1)
                        )
                        
                        Spacer()
                        
                        Text("Rs \(Double(viewModel.cartQuantity) * cartItem.price, specifier: "%.2f")")
                            .font(.customfont(.semibold, fontSize: 18))
                            .foregroundColor(.primaryText)
                    }
                }
                
                
            }
            Divider()
        }
        //        .padding(.horizontal, 20)
    }
    
}
//#Preview {
//    CartItemRow()
//        .padding(.horizontal, 20)
//}
struct CartItem: Identifiable {
    var id: String
    var name: String
    var price: Double
    var quantity: Int
    var img: String
    
    
    init(id: String, name: String, price: Double, quantity: Int, img: String) {
        self.id = id
        self.name = name
        self.price = price
        self.quantity = quantity
        self.img = img
    }
    
    
    init?(dictionary: [String: Any]) {
        guard let id = dictionary["productID"] as? String,
              let name = dictionary["name"] as? String,
              let price = dictionary["price"] as? Double,
              let quantity = dictionary["quantity"] as? Int,
              let img = dictionary["img"] as? String else {
            return nil
        }
        self.init(id: id, name: name, price: price, quantity: quantity, img: img)
    }
}
