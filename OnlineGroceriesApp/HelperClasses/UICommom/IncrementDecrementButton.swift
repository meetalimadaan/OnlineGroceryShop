//
//  IncrementDecrementButton.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 14/08/24.
//

import SwiftUI

struct IncrementDecrementButton: View {
    @ObservedObject var viewModel: ProductCellViewModel
    
    var body: some View {
        HStack {
            Button {
                viewModel.decrementQuantity()
            } label: {
                Image("Vector-5")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 10, height: 10)
                    .padding(10)
            }
            .padding(4)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.secondaryText.opacity(0.5), lineWidth: 1)
            )
            
            Text("\(viewModel.cartQuantity)")
                .font(.customfont(.semibold, fontSize: 16))
                .foregroundColor(.primaryText)
                .multilineTextAlignment(.center)
                .frame(width: 45, height: 45, alignment: .center)
            
            Button {
                viewModel.incrementQuantity()
            } label: {
                Image("Vector-6")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 10, height: 10)
                    .padding(10)
            }
            .padding(4)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.secondaryText.opacity(0.5), lineWidth: 1)
            )
        }
    }
}
