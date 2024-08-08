//
//  CategoryCell.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 18/07/24.
//

import SwiftUI

struct CategoryCell: View {
    var category: Category
    @State var color: Color = Color.yellow
    var didAddCart: (()->())?
    
    var body: some View {
        HStack{
            
//            Image("4215936-pulses-png-8-png-image-pulses-png-409_409 1")
//                .resizable()
//                .scaledToFit()
//                .frame(width: 70, height: 70)
            if let url = URL(string: category.imgURL!) {
                AsyncImage(url: url) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .scaledToFit()
                .frame(width: 70, height: 70)
            } else {
                Image("placeholderImage") // A placeholder image if URL is invalid
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 70)
            }
            
            Text(category.name!)
                .font(.customfont(.bold, fontSize: 16))
                .foregroundColor(.primaryText)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            
        }
        .padding(15)
        .frame(width: 250, height:  100)
        .background(color.opacity(0.3))
        .cornerRadius(16)
//        
    }
}

//#Preview {
//    CategoryCell()
//}
