//
//  CartItemRow.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 25/07/24.
//

import SwiftUI

struct CartItemRow: View {
    var body: some View {
        VStack{
            HStack(spacing: 15){
                
                Image("92f1ea7dcce3b5d06cd1b1418f9b9413 3")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                
                VStack(spacing:4){
                    Text("Banana")
                        .font(.customfont(.bold, fontSize: 16))
                        .foregroundColor(.primaryText)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    
                    Text("7pcs, price")
                        .font(.customfont(.medium, fontSize: 14))
                        .foregroundColor(.secondaryText)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                }
                
                Text("$2.99 ")
                    .font(.customfont(.semibold, fontSize: 18))
                    .foregroundColor(.primaryText)
                //                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                
                Image("back arrow 1")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 15, height: 15)
                
                //                            Text("Favourites")
                //                                 .font(.customfont(.bold, fontSize: 20))
            }
            Divider()
        }
    }
}
#Preview {
    CartItemRow()
}
