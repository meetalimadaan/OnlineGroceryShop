//
//  AddressRow.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 29/08/24.
//

import SwiftUI

struct AddressRow: View {
    let address: Address
        @State var isChecked: Bool
        let isSelectable: Bool
        
        var body: some View {
            HStack {
                Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                    .foregroundColor(isChecked ? .green : .gray)
                    .onTapGesture {
                        if isSelectable {
                            isChecked.toggle()
                            print("Address \(address.city) isChecked: \(isChecked)")
                        }
                    }
                
                VStack(alignment: .leading) {
                    Text("City: \(address.city)")
                    Text("State: \(address.state)")
                    Text("Country: \(address.country)")
                    Text("Zip Code: \(address.zipCode)")
                    Divider()
                }
            }
        }
    }
