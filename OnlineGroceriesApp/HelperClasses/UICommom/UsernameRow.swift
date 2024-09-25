//
//  UsernameRow.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 24/09/24.
//
import SwiftUI

struct UsernameRow: View {
    var username: String // The fetched username
    var title: String
    var iconName: String // The icon name for the HStack
    var editAction: () -> Void // Closure for the edit action

    var body: some View {
        HStack {
            // Icon on the left
            Image(systemName: iconName) 
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
            
            // VStack for the username details
            VStack(alignment: .leading) {
                Text(title) // Title
                    .font(.customfont(.semibold, fontSize: 18))
                    .foregroundColor(.primaryText)
                
                Text(username) // Fetched username
                    .font(.customfont(.regular, fontSize: 16))
                    .foregroundColor(.secondary) // Optional: Use a secondary color for distinction
            }
            .padding(.leading, 10) // Add some space between icon and text
            
            Spacer() // Pushes the content to the left
            
            // Edit pencil icon on the right
            Button(action: editAction) {
                Image(systemName: "pencil")
//                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.primaryApp) // Change to your desired color
            }
            .padding(.leading, 10) // Space between text and icon
        }
        .padding(20) // Padding around the entire HStack
//        .background(Color(.systemGray6)) // Optional: background color for better visibility
        .cornerRadius(8) // Optional: rounded corners for styling
        .padding(.bottom, 5) // Space below this row
    }
}

//#Preview {
//    UsernameRow(username: "example_username", iconName: "bookmark 1") {
//        print("Edit button tapped")
//    }
//}



