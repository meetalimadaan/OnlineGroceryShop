//
//  ExploreCategoryCell.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 19/07/24.
//

import SwiftUI

struct ExploreCategoryCell: View {
    @State var color: Color = Color.yellow
    var didAddCart: (()->())?
    
    var body: some View {
        VStack{
            
            Image("4215936-pulses-png-8-png-image-pulses-png-409_409 1")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 90)
           
            Spacer()
            
                Text("Pulses")
                .font(.customfont(.bold, fontSize: 16))
                .foregroundColor(.primaryText)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            
            Spacer()
            
        }
        .padding(15)
//        .frame( height:  100)
        .background(color.opacity(0.3))
        .cornerRadius(16)
        .overlay (
        RoundedRectangle(cornerRadius: 16)
            .stroke(color.opacity(0.3), lineWidth: 1)
        )
        
        VStack{
            
            Image("4215936-pulses-png-8-png-image-pulses-png-409_409 1")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 90)
           
            Spacer()
            
                Text("Pulses")
                .font(.customfont(.bold, fontSize: 16))
                .foregroundColor(.primaryText)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            
            Spacer()
            
        }
        .padding(15)
//        .frame( height:  100)
        .background(color.opacity(0.3))
        .cornerRadius(16)
        .overlay (
        RoundedRectangle(cornerRadius: 16)
            .stroke(color.opacity(0.3), lineWidth: 1)
        )
        VStack{
            
            Image("4215936-pulses-png-8-png-image-pulses-png-409_409 1")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 90)
           
            Spacer()
            
                Text("Pulses")
                .font(.customfont(.bold, fontSize: 16))
                .foregroundColor(.primaryText)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            
            Spacer()
            
        }
        .padding(15)
//        .frame( height:  100)
        .background(color.opacity(0.3))
        .cornerRadius(16)
        .overlay (
        RoundedRectangle(cornerRadius: 16)
            .stroke(color.opacity(0.3), lineWidth: 1)
        )
//
        
        VStack{
            
            Image("4215936-pulses-png-8-png-image-pulses-png-409_409 1")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 90)
           
            Spacer()
            
                Text("Pulses")
                .font(.customfont(.bold, fontSize: 16))
                .foregroundColor(.primaryText)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            
            Spacer()
            
        }
        .padding(15)
//        .frame( height:  100)
        .background(color.opacity(0.3))
        .cornerRadius(16)
        .overlay (
        RoundedRectangle(cornerRadius: 16)
            .stroke(color.opacity(0.3), lineWidth: 1)
        )
//
    }
}

#Preview {
    ExploreCategoryCell()
        .padding(20)
}
