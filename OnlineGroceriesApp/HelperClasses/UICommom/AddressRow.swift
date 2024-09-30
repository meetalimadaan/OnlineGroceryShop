//
//  AddressRow.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 29/08/24.
//
import SwiftUI

struct AddressRow: View {
    var address: Address
    @Binding var isDefault: Bool 
    var toggleDefaultStatus: () -> Void

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(address.city)")
                    .font(.customfont(.regular, fontSize: 18))
                Text("\(address.country)")
                    .font(.customfont(.regular, fontSize: 14))
                    .foregroundColor(.gray)
            }
            Spacer()
            if isDefault {
                Image(systemName: "checkmark")
                    .foregroundColor(.green)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        .padding(.horizontal)
        .onTapGesture {
            toggleDefaultStatus()
        }
    }
}

