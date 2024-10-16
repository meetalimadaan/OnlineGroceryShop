//
//  UsernameRow.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 24/09/24.
//
import SwiftUI

struct UsernameRow: View {
    var username: String
    var title: String
    var iconName: String
    var editAction: () -> Void

    var body: some View {
        HStack {
           
            Image(systemName: iconName) 
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
            
         
            VStack(alignment: .leading) {
                Text(title)
                    .font(.customfont(.semibold, fontSize: 18))
                    .foregroundColor(.primaryText)
                
                Text(username)
                    .font(.customfont(.regular, fontSize: 16))
                    .foregroundColor(.secondary)
            }
            .padding(.leading, 10)
            
            Spacer()
            
           
            Button(action: editAction) {
                Image(systemName: "pencil")
//                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.primaryApp)
            }
            .padding(.leading, 10)
        }
        .padding(20)
//        .background(Color(.systemGray6))
        .cornerRadius(8)
        .padding(.bottom, 5)
    }
}

//#Preview {
//    UsernameRow(username: "example_username", iconName: "bookmark 1") {
//        print("Edit button tapped")
//    }
//}



