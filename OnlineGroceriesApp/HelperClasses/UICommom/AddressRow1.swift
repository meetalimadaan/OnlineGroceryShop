//
//  AddressRow1.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 01/10/24.
//

import SwiftUI

struct AddressRow1: View {
    let address: Address
    let toggleDefaultAction: () -> Void
    
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
            Button(action: toggleDefaultAction) {
                Text(address.isDefault ? "" : "")
                    .foregroundColor(.blue)
            }
        }
    }
}

#Preview {
    AddressRow1(address: Address(city: "Sample City", state: "State", country: "Country", zipCode: "000000", isDefault: false), toggleDefaultAction: {})
}

