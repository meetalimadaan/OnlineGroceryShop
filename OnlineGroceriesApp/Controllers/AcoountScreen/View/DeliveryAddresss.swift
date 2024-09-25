//
//  DeliveryAddresss.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 06/09/24.
//

import SwiftUI

struct DeliveryAddresss: View {
    @ObservedObject var viewModel = CheckOutViewModel()
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        
        VStack {
            HStack {
                Spacer()
                Button {
                    mode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.left")
//                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                }
                
                Text("Saved Addresses")
                    .font(.customfont(.bold, fontSize: 20))
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                
            }
            
            
            Spacer()
            
            
            if viewModel.addresses.isEmpty {
                Text("No Address")
                    .font(.customfont(.bold, fontSize: 18))
                    .foregroundColor(.secondaryText)
                    .padding(.top, .topInsets + 46)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            } else {
                List {
                    ForEach(viewModel.addresses) { address in
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
                                viewModel.toggleDefaultStatus(for: address)
                            }) {
                                Text(address.isDefault ? "" : "")
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                }
                
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    DeliveryAddresss()
}
