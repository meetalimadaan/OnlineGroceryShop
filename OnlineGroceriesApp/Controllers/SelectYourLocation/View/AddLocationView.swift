//
//  AddLocationView.swift
//  OnlineGroceriesApp
//
//  Created by Prince on 26/07/24.
//

import SwiftUI

struct AddLocationView: View {
    @Binding var address: Address?
    @StateObject var locationVM = LocationViewModel.shared
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("City")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.gray)
            
            VStack {
                TextField("Enter City", text: Binding(
                    get: { address?.city ?? "" },
                    set: { newValue in address?.city = newValue }
                ))
                .padding(.vertical, 8)
                .foregroundColor(.primary)
                
                Divider()
                    .background(Color.gray)
            }
            .padding(.bottom, .screenWidth * 0.07)
            
            Text("State")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.gray)
            
            VStack {
                TextField("Enter State", text: Binding(
                    get: { address?.state ?? "" },
                    set: { newValue in address?.state = newValue }
                ))
                .padding(.vertical, 8)
                .foregroundColor(.primary)
                
                Divider()
                    .background(Color.gray)
            }
            .padding(.bottom, .screenWidth * 0.07)
            
            Text("Country")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.gray)
            
            VStack {
                TextField("Enter Country", text: Binding(
                    get: { address?.country ?? "" },
                    set: { newValue in address?.country = newValue }
                ))
                .padding(.vertical, 8)
                .foregroundColor(.primary)
                
                Divider()
                    .background(Color.gray)
            }
            .padding(.bottom, .screenWidth * 0.07)
            
            Text("Zipcode")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.gray)
            
            VStack {
                TextField("Enter Zipcode", text: Binding(
                    get: { address?.zipCode ?? "" },
                    set: { newValue in address?.zipCode = newValue }
                ))
                .padding(.vertical, 8)
                .foregroundColor(.primary)
                
                Divider()
                    .background(Color.gray)
            }
            .padding(.bottom, .screenWidth * 0.07)
        }
        .padding(.horizontal, 25)
    }
}


//#Preview {
//    AddLocationView()
//}
