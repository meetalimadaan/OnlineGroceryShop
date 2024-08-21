//
//  SearchTextField.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 18/07/24.
//

import SwiftUI

struct SearchTextField: View {
  
    var placeholder: String = "Placeholder"
    @Binding var txt: String
 

    
    var body: some View {
        HStack(spacing: 15) {
            
            Image("Vector-2")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
          
            
            TextField(placeholder, text: $txt)
                .font(.customfont(.regular, fontSize: 17))
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .frame(minWidth: 0, maxWidth: .infinity)
            
        }
        .frame(height: 20)
        .padding(15)
        .background(Color(hex: "F2F3F2"))
        .cornerRadius(16)
    }
}

//struct SearchTextField_Previews: PreviewProvider {
//   
//    static var previews: some View {
//        SearchTextField(placeholder: "Search Store", txt: $txt)
//        .padding(15)
//}
//}
