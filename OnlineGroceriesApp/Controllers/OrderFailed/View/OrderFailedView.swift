//
//  OrderFailedView.swift
//  OnlineGroceriesApp
//
//  Created by Prince on 29/07/24.
//

import SwiftUI

struct OrderFailedView: View {
    @Binding var isPresented: Bool
    @State private var inputText: String = ""

    var body: some View {
        VStack(spacing: 20) {
                   Text("Custom Dialog Title")
                       .font(.headline)
                   
                   Text("This is a custom dialog message.")
                       .font(.subheadline)
                   
                   TextField("Enter something...", text: $inputText)
                       .textFieldStyle(RoundedBorderTextFieldStyle())
                       .padding()
                   
                   HStack {
                       Button("Cancel") {
                           isPresented = false
                       }
                       .padding()
                       .background(Color.gray.opacity(0.2))
                       .cornerRadius(8)
                       
                       Button("Clear") {
                           inputText = ""
                       }
                       .padding()
                       .background(Color.orange)
                       .foregroundColor(.white)
                       .cornerRadius(8)
                       
                       Button("OK") {
                           // Handle OK action
                           print("Input Text: ")
                           isPresented = false
                       }
                       .padding()
                       .background(Color.blue)
                       .foregroundColor(.white)
                       .cornerRadius(8)
                   }
               }
               .padding()
               .frame(maxWidth: 300)
               .background(Color.white)
               .cornerRadius(12)
               .shadow(radius: 10)
               .transition(.scale)
               .animation(.spring())
           }
    }


#Preview {
    OrderFailedView(isPresented: .constant(true))
}
