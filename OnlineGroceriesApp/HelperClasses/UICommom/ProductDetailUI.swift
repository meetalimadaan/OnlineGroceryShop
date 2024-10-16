//
//  ProductDetailUI.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 08/10/24.
//

import SwiftUI

struct ProductMessageView: View {
    let productName: String
    let productDescription: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(productName)
                .font(.headline)
                .padding(12)
                .background(Color(UIColor.systemGreen))
                .cornerRadius(10)
                .frame(maxWidth: 250, alignment: .leading)
                .shadow(radius: 2)
            
            Text(productDescription)
                .font(.subheadline)
                .padding(12)
                .background(Color(UIColor.systemGreen).opacity(0.8))
                .cornerRadius(10)
                .frame(maxWidth: 250, alignment: .leading)
                .shadow(radius: 2)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
    }
}
