//
//  EditProfileView.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 28/08/24.
//

import SwiftUI

struct EditProfileView: View {
    @StateObject private var accountVM = AccountViewModel.shared
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""

    var body: some View {
        VStack{
            // Header
            HStack {
                Spacer()
                Text("Edit Profile")
                    .font(.customfont(.bold, fontSize: 20))
                    .frame(height: 46)
                Spacer()
            }
            .padding(.top, .topInsets)
            .background(Color.white)
            .shadow(color: Color.black.opacity(0.2), radius: 2)
            
            Spacer()
            
                    VStack(spacing: 20) {
            
                        TextField("Username", text: $username)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                            .onAppear {
                                username = accountVM.username
//                                email = accountVM.email
                            }
            
//                        TextField("Email", text: $email)
//                            .textFieldStyle(RoundedBorderTextFieldStyle())
//                            .padding()
            
                        Button(action: saveProfile) {
                            Text("Save Changes")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(8)
                        }
            
                        Spacer()
                    }
            
                
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Success"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
        }
        .background(Color(.systemGray6))
        .edgesIgnoringSafeArea(.top)
    }
    private func saveProfile() {
       
        accountVM.username = username
//        accountVM.email = email
        
        // Save changes to Firebase
        accountVM.updateUserProfile { success in
            if success {
                alertMessage = "Profile updated successfully!"
            } else {
                alertMessage = "Failed to update profile. Please try again."
            }
            showAlert = true
        }
    }
}

