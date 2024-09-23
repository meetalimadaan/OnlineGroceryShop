//
//  MyDetailsView.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 28/08/24.
//
import SwiftUI

struct MyDetailsView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @StateObject private var viewModel = UserProfileViewModel()
    @State private var isImagePickerPresented = false
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    mode.wrappedValue.dismiss()
                } label: {
                    Image("back arrow")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                }
                
                Text("User Profile")
                    .font(.customfont(.bold, fontSize: 20))
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                
                NavigationLink(destination: EditProfileView()) {
                    Image(systemName: "pencil")
                        .foregroundColor(.primaryApp)
                        .frame(width: 24, height: 24)
                        .padding()
                }
            }
            
            // Profile image in a circle
            VStack {
                if let profileImageURL = viewModel.userProfile?.profileImageURL, !profileImageURL.isEmpty {
                    AsyncImage(url: URL(string: profileImageURL)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                    } placeholder: {
                        Circle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 100, height: 100)
                            .overlay(Text("No Image"))
                    }
                } else if let selectedImage = viewModel.selectedImage {
                    // Show selected image before uploading
                    Image(uiImage: selectedImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                } else {
                    // Placeholder circle in case no profile image is available
                    Circle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 100, height: 100)
                        .overlay(Text("No Image"))
                }
                
                // Pencil icon to choose image
                if viewModel.selectedImage == nil {
                    Button(action: {
                        isImagePickerPresented = true
                    }) {
                        Image(systemName: "pencil")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.blue)
                            .padding(.top, 10)
                    }
                }
            }
            
            // Button to upload image
            if viewModel.selectedImage != nil {
                Button(action: {
                    viewModel.uploadProfileImage()
                }) {
                    Text("Upload Image")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
            }
            
            if let userProfile = viewModel.userProfile {
                VStack(alignment: .leading) {
                    Text("Username: \(userProfile.username)")
                        .font(.headline)
                    Text("Email: \(userProfile.email)")
                        .font(.subheadline)
                }
                .padding()
            } else {
                Text("Loading...")
                    .padding()
            }
            
            Spacer()
        }
        .navigationBarHidden(true)
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePicker(selectedImage: $viewModel.selectedImage)
        }
    }
}



