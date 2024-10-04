//
//  LocationRow.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 04/10/24.
//

//import SwiftUI
//
//struct LocationRow: View {
//    var address: UserAddress // Assuming you have a UserAddress model
//    
//    var body: some View {
//        VStack {
//            HStack(spacing: 15) {
//                // If you have an icon for the address, add it here
//                Image(systemName: "location.fill") // Example icon
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 30, height: 30)
//                    .foregroundColor(.primaryApp)
//                
//                VStack(spacing: 4) {
//                    Text(address.fullAddress) // Assuming fullAddress is a property in UserAddress
//                        .font(.customfont(.bold, fontSize: 16))
//                        .foregroundColor(.primaryText)
//                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
//                    
//                    // Optionally, you can display other details
//                    Text("\(address.city), \(address.state), \(address.zipCode)") // Example details
//                        .font(.customfont(.medium, fontSize: 14))
//                        .foregroundColor(.secondaryText)
//                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
//                }
//                
//                Spacer()
//                
//                // Action button (like select or delete)
//                Button(action: {
//                    // Add your action for selecting or editing the address
//                }) {
//                    Text("Select")
//                        .font(.customfont(.semibold, fontSize: 14))
//                        .foregroundColor(.primaryApp)
//                }
//            }
//            Divider()
//        }
//        .padding(.vertical, 10)
//    }
//}

//// Example Usage
//struct LocationRow_Previews: PreviewProvider {
//    static var previews: some View {
//        LocationRow(address: UserAddress(fullAddress: "123 Main St", city: "CityName", state: "StateName", zipCode: "12345"))
//    }
//}
