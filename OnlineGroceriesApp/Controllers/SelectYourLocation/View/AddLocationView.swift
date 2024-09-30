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
            // City Section
            Text("City")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.gray)
            
            // Removed TextField
            Text(address?.city ?? "No City Entered")
                .padding(.vertical, 8)
                .foregroundColor(.primary)
            
            Divider()
                .background(Color.gray)
                .padding(.bottom, .screenWidth * 0.07)
            
            // State Section
            Text("State")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.gray)
            
            // Removed TextField
            Text(address?.state ?? "No State Entered")
                .padding(.vertical, 8)
                .foregroundColor(.primary)
            
            Divider()
                .background(Color.gray)
                .padding(.bottom, .screenWidth * 0.07)
            
            // Country Section
            Text("Country")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.gray)
            
            // Removed TextField
            Text(address?.country ?? "No Country Entered")
                .padding(.vertical, 8)
                .foregroundColor(.primary)
            
            Divider()
                .background(Color.gray)
                .padding(.bottom, .screenWidth * 0.07)
            
            // Zipcode Section
            Text("Zipcode")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.gray)
            
            // Removed TextField
            Text(address?.zipCode ?? "No Zipcode Entered")
                .padding(.vertical, 8)
                .foregroundColor(.primary)
            
            Divider()
                .background(Color.gray)
                .padding(.bottom, .screenWidth * 0.07)
        }
        .padding(.horizontal, 10)
    }
}

