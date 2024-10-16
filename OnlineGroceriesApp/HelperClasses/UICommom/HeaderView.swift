//
//  HeaderView.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 14/10/24.
//

import SwiftUI

struct HeaderView: View {
    var title: String
       var showBackButton: Bool = true
    @Environment(\.presentationMode) var presentationMode
       var body: some View {
           HStack {
               // Back button on the left side
               if showBackButton {
                   Button(action: {
                       presentationMode.wrappedValue.dismiss()
                   }) {
                       Image(systemName: "chevron.left")
                           .foregroundColor(.black)
                           .padding()
                   }
               } else {
                   // Empty space if back button is hidden
                   Spacer().frame(width: 44) // Same width as button
               }

               Spacer()

               // Title in the center
               Text(title)
                   .font(.customfont(.bold, fontSize: 20))
                   .frame(height: 46)

               Spacer() // Spacer to center the title
           }
         
           .padding(.horizontal, 10)
           .padding(.top, .topInsets)
           .background(Color.white)
           .shadow(color: Color.black.opacity(0.2), radius: 2)
       }
   }
#Preview {
    HeaderView(title: "VIEW")
}
