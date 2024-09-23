//
//  FilterRow.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 06/09/24.
//

import SwiftUI

struct FilterRow: View {
    let status: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        HStack {
            Text(status)
            Spacer()
            if isSelected {
                Image(systemName: "checkmark")
                    .foregroundColor(.green)
            }
        }
        .padding()
        .contentShape(Rectangle()) 
        .onTapGesture {
            action()
        }
    }
}

