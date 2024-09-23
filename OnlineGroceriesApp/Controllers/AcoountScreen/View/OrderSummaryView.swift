//
//  OrderSummaryView.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 04/09/24.
//

import SwiftUI

struct OrderSummaryView: View {
    var order: Order
    var totalAmount: Double {
        return order.cartItems.reduce(0) { $0 + ($1.price * Double($1.quantity)) }
    }
    
    var body: some View {
        
        VStack {
            // Header
            HStack {
                Spacer()
                Text("Order Summary")
                    .font(.customfont(.bold, fontSize: 20))
                    .frame(height: 46)
                Spacer()
            }
            .padding(.top, .topInsets)
            .background(Color.white)
            .shadow(color: Color.black.opacity(0.2), radius: 2)
            
            Text("\(order.cartItems.count) \(order.cartItems.count == 1 ? "item" : "items") in this order")
                .font(.customfont(.bold, fontSize: 18))
                .padding(.top, 5)
            
            Spacer()
            
            
            ScrollView {
                //                Product Items Section
                LazyVStack(spacing: 20) {
                    ForEach(order.cartItems) { item in
                        ProductRow(item: item)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
//                // Bill Details Section
//                VStack(alignment: .leading, spacing: 10) {
//                    Text("Bill Details")
//                        .font(.customfont(.bold, fontSize: 18))
//                        .padding(.top, 10)
//                    
//                    HStack {
//                        Text("Total Amount:")
//                            .font(.customfont(.regular, fontSize: 16))
//                        Spacer()
//                        Text("Rs\(totalAmount, specifier: "%.2f")")
//                            .font(.customfont(.bold, fontSize: 16))
//                    }
//                    .padding(.vertical, 5)
//                }
//                .padding()
//                .background(Color.gray.opacity(0.2))
//                .cornerRadius(10)
//                .padding(.horizontal)
                
                
                // Order Details Section
                VStack(alignment: .leading, spacing: 10) {
                    Text("Order Details")
                        .font(.customfont(.bold, fontSize: 18))
                        .padding(.top, 10)
                    
                    HStack {
                        Text("Order ID:")
                            .font(.customfont(.regular, fontSize: 16))
                        Spacer()
                        Text(order.id)
                            .font(.customfont(.bold, fontSize: 16))
                    }
                    
                    HStack {
                        Text("Order Status:")
                            .font(.customfont(.regular, fontSize: 16))
                        Spacer()
                        Text(order.status)
                            .font(.customfont(.bold, fontSize: 16))
                    }
                    
                    HStack {
                        Text("Deliver To:")
                            .font(.customfont(.regular, fontSize: 16))
                        Spacer()
                        if let address = order.selectedAddress {
                            Text("\(address.city), \(address.state), \(address.country) \(address.zipCode)")
                                .font(.customfont(.bold, fontSize: 16))
                        } else {
                            Text("N/A")
                                .font(.customfont(.bold, fontSize: 16))
                        }
                    }
                    //
                    //                                       HStack {
                    //                                           Text("Deliver To:")
                    //                                               .font(.customfont(.regular, fontSize: 16))
                    //                                           Text(order.deliveryAddress)
                    //                                               .font(.customfont(.bold, fontSize: 16))
                    //                                       }
                    HStack {
                        Text("Order Placed:")
                            .font(.customfont(.regular, fontSize: 16))
                        Spacer()
                        Text(order.orderDate, formatter: DateFormatter.fullDateTime)
                            .font(.customfont(.bold, fontSize: 16))
                    }
                    
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding(.horizontal)
            }
            
            // Bill Details Section
            VStack(alignment: .leading, spacing: 10) {
                Text("Bill Details")
                    .font(.customfont(.bold, fontSize: 18))
                    .padding(.top, 10)
                
                HStack {
                    Text("Total Amount:")
                        .font(.customfont(.regular, fontSize: 16))
                    Spacer()
                    Text("Rs\(totalAmount, specifier: "%.2f")")
                        .font(.customfont(.bold, fontSize: 16))
                }
                .padding(.vertical, 5)
            }
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
            .padding(.horizontal)
           
        }
        .edgesIgnoringSafeArea(.top)
    }
    
}

extension DateFormatter {
    static let fullDateTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
}
