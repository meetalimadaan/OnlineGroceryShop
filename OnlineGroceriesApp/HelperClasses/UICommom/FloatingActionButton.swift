//
//  FloatingActionButton.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 07/10/24.
//
import SwiftUI

struct FloatingActionButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "message")
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .padding()
                .background(Color.primaryApp)
                .foregroundColor(.white)
                .clipShape(Circle())
                .shadow(radius: 4)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .trailing)
        .padding(.trailing, 16)
        .padding(.bottom, 16)
    }
}
