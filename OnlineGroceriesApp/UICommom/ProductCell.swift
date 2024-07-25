//
//  ProductCell.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 18/07/24.
//

import SwiftUI

struct ProductCell: View {
    
    var didAddCart: (()->())?
    @State var width: Double =  180.0
    var body: some View {
        VStack{
            
            Image("92f1ea7dcce3b5d06cd1b1418f9b9413 3")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 80)
            
            Spacer()
            
                Text("Banana")
                .font(.customfont(.bold, fontSize: 16))
                .foregroundColor(.primaryText)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            
            Text("7pcs, price")
            .font(.customfont(.medium, fontSize: 14))
            .foregroundColor(.secondaryText)
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            HStack{
                Text("$2.99 ")
                .font(.customfont(.semibold, fontSize: 18))
                .foregroundColor(.primaryText)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                Button{
                    didAddCart?()
                } label: {
                    Image("Vector-3")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 15, height: 15)
                }
                .frame(width: 40, height: 40)
                .background(Color.primaryApp)
                .cornerRadius(15)
                
            }
            
        }
        .padding(15)
        .frame(width: width, height:  230)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.primaryText.opacity(0.5), lineWidth: 1)
            
        )
        
        
        
        VStack{
            
            Image("92f1ea7dcce3b5d06cd1b1418f9b9413 3")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 80)
            
            Spacer()
            
                Text("Banana2")
                .font(.customfont(.bold, fontSize: 16))
                .foregroundColor(.primaryText)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            
            Text("7pcs, price")
            .font(.customfont(.medium, fontSize: 14))
            .foregroundColor(.secondaryText)
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            HStack{
                Text("$2.99 ")
                .font(.customfont(.semibold, fontSize: 18))
                .foregroundColor(.primaryText)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                Button{
                    didAddCart?()
                } label: {
                    Image("Vector-3")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 15, height: 15)
                }
                .frame(width: 40, height: 40)
                .background(Color.primaryApp)
                .cornerRadius(15)
                
            }
            
        }
        .padding(15)
        .frame(width: width, height:  230)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.primaryText.opacity(0.5), lineWidth: 1)
            
        )
            }
}

#Preview {
    ProductCell()
}
