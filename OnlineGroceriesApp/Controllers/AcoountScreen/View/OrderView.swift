//
//  OrderView.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 28/08/24.
//

import SwiftUI

struct OrderView: View {
   
    @State private var orders: [String] = []

    var body: some View {
        VStack {
            // Header
            HStack {
                Spacer()
                Text("My Orders")
                    .font(.customfont(.bold, fontSize: 20))
                    .frame(height: 46)
                Spacer()
            }
            .padding(.top, .topInsets)
            .background(Color.white)
            .shadow(color: Color.black.opacity(0.2), radius: 2)
            
            Spacer()
           
            // Orders List or No Data Message
            if orders.isEmpty {
                Text("No Data Here.")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .padding()
            } else {
                List(orders, id: \.self) { order in
                    Text(order)
                        .padding()
                }
            }
            Spacer()
        }
        .background(Color(.systemGray6))
        .edgesIgnoringSafeArea(.top)
    }
}

#Preview {
    OrderView()
}

