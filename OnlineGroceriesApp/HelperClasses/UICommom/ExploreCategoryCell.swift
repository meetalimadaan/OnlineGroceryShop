//
//  ExploreCategoryCell.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 19/07/24.
//

import SwiftUI

struct ExploreCategoryCell: View {
    var category: Category
    
    var body: some View {
        NavigationLink(destination: ExploreItemsView(category: category)) {
            VStack {
                if let url = URL(string: category.imgURL!) {
                    AsyncImage(url: url) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .scaledToFit()
                    .frame(width: 120, height: 90)
                } else {
                    Image("placeholderImage")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 90)
                }
                
                Spacer()
                
                Text(category.name!)
                    .font(.customfont(.bold, fontSize: 16))
                    .foregroundColor(.primaryText)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                
                Spacer()
            }
            .padding(15)
            .background(Color.yellow.opacity(0.3))
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.yellow.opacity(0.3), lineWidth: 1)
            )
        }
        .onTapGesture {
            print("Tapped on category: \(category.name)")
        }
    }
}

