//
//  AccountRow.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 22/07/24.
//

import SwiftUI

struct AccountRow: View {
    @State var title: String = "Title"
    @State var icon: String = "Orders icon"
    
    var body: some View {
        VStack{
            
            HStack(spacing: 15){
                Image(icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                
                Text(title)
                    .font(.customfont(.semibold, fontSize: 18))
                    .foregroundColor(.primaryText)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                
                Image("back arrow 1")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 15, height: 15)
                
            }
            .padding(20)
           
            Divider()
        }
    }
}

#Preview {
    AccountRow()
}
