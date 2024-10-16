//
//  FavouriteRow.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 23/07/24.
//

import SwiftUI

struct FavouriteRow: View {
    var product: Product
    
    var body: some View {
        
        VStack{
            HStack(spacing: 15){
                
                AsyncImage(url: URL(string: product.img)) { image in
                    image.resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                } placeholder: {
                    ProgressView()
                }
                
                VStack(spacing:4){
                    Text(product.name)
                        .font(.customfont(.bold, fontSize: 16))
                        .foregroundColor(.primaryText)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    
                    Text("\(product.stock ?? "")")
                        .font(.customfont(.medium, fontSize: 14))
                        .foregroundColor(.secondaryText)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                }
                
                Text("Rs \(product.price, specifier: "%.2f")")
                    .font(.customfont(.semibold, fontSize: 18))
                    .foregroundColor(.primaryText)
                //                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                
//                Image("back arrow 1")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 15, height: 15)
                
                //                            Text("Favourites")
                //                                 .font(.customfont(.bold, fontSize: 20))
            }
            Divider()
        }
    }
}

//#Preview {
//    FavouriteRow(product: Product)
//}
