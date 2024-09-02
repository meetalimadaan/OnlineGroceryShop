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
    @State private var currentPassword: String = ""
    @State private var newPassword: String = ""
    @State private var confirmNewPassword: String = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""

    var body: some View {
        VStack {
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
                    }
                
                SecureField("Current Password", text: $currentPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                SecureField("New Password", text: $newPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                SecureField("Confirm New Password", text: $confirmNewPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
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
        // Check if new passwords match
        if !newPassword.isEmpty && newPassword != confirmNewPassword {
            alertMessage = "New passwords do not match."
            showAlert = true
            return
        }
        
        accountVM.username = username
        
        // Save changes to Firebase
        accountVM.updateUserProfile(currentPassword: currentPassword, newPassword: newPassword) { success in
            if success {
                alertMessage = "Profile updated successfully!"
            } else {
                alertMessage = "Failed to update profile. Please try again."
            }
            showAlert = true
        }
    }
}
