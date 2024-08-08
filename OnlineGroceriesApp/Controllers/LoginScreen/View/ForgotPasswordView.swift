//
//  ForgotPasswordView.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 02/08/24.
//

import SwiftUI
import FirebaseAuth

struct ForgotPasswordView: View {
    @State private var email = ""
    @State private var message = ""
    @State private var isShowingAlert = false
    
    var body: some View {
        VStack {
            Text("Forgot Password")
                .font(.largeTitle)
                .padding()
            
            TextField("Enter your email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Send Reset Link") {
                sendPasswordReset()
            }
            .padding()
            .alert(isPresented: $isShowingAlert) {
                Alert(title: Text("Message"), message: Text(message), dismissButton: .default(Text("OK")))
            }
        }
        .padding()
    }
    
    private func sendPasswordReset() {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                message = "Error: \(error.localizedDescription)"
            } else {
                message = "Password reset email sent. Please check your inbox."
            }
            isShowingAlert = true
        }
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}

