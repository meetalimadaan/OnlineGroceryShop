//
//  AddressRow.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 29/08/24.
//

import SwiftUI

struct AddressRow: View {
    let address: Address
    let onToggleDefault: () -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(address.city), \(address.state)")
                Text("\(address.country) - \(address.zipCode)")
            }
            Spacer()
            if address.isDefault {
                Image(systemName: "checkmark")
                    .foregroundColor(.green)
            }
            Button(action: {
                onToggleDefault()
            }) {
                Text(address.isDefault ? "" : "")
                    .foregroundColor(.green)
            }
        }
        .padding() // Add padding for spacing inside the row
         
                .cornerRadius(8) // Optional: rounded corners for a more polished look
                .shadow(color: Color.gray.opacity(0.2), radius: 4, x: 0, y: 2)
    }
}

