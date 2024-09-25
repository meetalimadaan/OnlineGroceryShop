//
//  SectionViewAllProducts.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 23/09/24.
//

import SwiftUI

struct SectionViewAllProducts: View {
    
    var titleAll: String = "See All Products"
    var didTap: (() -> Void)?
    
    var body: some View {
        HStack {
            NavigationLink(destination: AllProducts()) {
                Text(titleAll)
                    .font(.customfont(.semibold, fontSize: 20))
                    .foregroundColor(.primaryApp)
                    .padding()
                
                Image(systemName: "arrow.right")
                    .foregroundColor(.green)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .frame(height: 40)
        .frame(maxWidth: .infinity)
        .background(Color.green.opacity(0.2))
        .cornerRadius(8)
    }
}

#Preview {
    SectionViewAllProducts()
        .padding(20)
}

