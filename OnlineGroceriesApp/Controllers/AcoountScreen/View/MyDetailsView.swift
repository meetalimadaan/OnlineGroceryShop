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
    @State private var isUploading = false // Track upload state
    @State private var isEditAlertPresented: Bool = false
    @State private var editedValue: String = ""
    @State private var fieldToEdit: String = "" // "username" or "email"

    let radius: CGFloat = 50
    var offset: CGFloat {
        sqrt(radius * radius / 2)
    }

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    mode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                }
                
                Text("User Profile")
                    .font(.customfont(.bold, fontSize: 20))
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                
//                NavigationLink(destination: EditProfileView()) {
//                    Image(systemName: "pencil")
//                        .foregroundColor(.primaryApp)
//                        .frame(width: 24, height: 24)
//                        .padding()
//                }
            }

            // Profile image in a circle with a camera icon
            ZStack {
                if let profileImageURL = viewModel.userProfile?.profileImageURL, !profileImageURL.isEmpty {
                    AsyncImage(url: URL(string: profileImageURL)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: radius * 2, height: radius * 2)
                            .clipShape(Circle())
                    } placeholder: {
                        Circle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: radius * 2, height: radius * 2)
                            .overlay(Text("No Image"))
                    }
                } else if let selectedImage = viewModel.selectedImage {
                    // Show selected image before uploading
                    Image(uiImage: selectedImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: radius * 2, height: radius * 2)
                        .clipShape(Circle())
                } else {
                    // Placeholder circle in case no profile image is available
                    Circle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: radius * 2, height: radius * 2)
                        .overlay(Text("No Image"))
                }
                
                // Camera icon overlay
                Button(action: {
                    isImagePickerPresented = true
                }) {
                    Image(systemName: "camera.fill")
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color.primaryApp)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(Color.white, lineWidth: 2)
                        )
                }
                .offset(x: offset, y: offset) // Positioning the camera icon
            }
            .padding(.top, 10)

            // Button to upload image
                   if viewModel.selectedImage != nil {
                       if isUploading { // Show loader when uploading
                           ProgressView() // Circular loader
                               .progressViewStyle(CircularProgressViewStyle(tint: .green))
                               .padding()
                       } else if !viewModel.uploadCompleted { // Hide button if upload is completed
                           Button(action: {
                               isUploading = true // Set uploading state
                               viewModel.uploadProfileImage {
                                   isUploading = false // Reset uploading state after completion
                               }
                           }) {
                               Text("Upload Image")
                                   .padding()
                                   .background(Color.green)
                                   .foregroundColor(.white)
                                   .cornerRadius(8)
                           }
                           .padding()
                       }
                   }
                   
            
            // Display UsernameRow for user profile details
                                  if let userProfile = viewModel.userProfile {
                                      UsernameRow(username: userProfile.username, title: "Username", iconName: "person") {
                                          // Define what happens when the edit button for username is tapped
                                          print("Edit username tapped")
                                      }
                                      
                                      UsernameRow(username: userProfile.email, title: "Email", iconName: "envelope") {
                                          // Define what happens when the edit button for email is tapped
                                          print("Edit email tapped")
                                      }
                                  } else {
//                                      Text("Loading...")
//                                          .padding()
                                  }

                                  Spacer()
                              }
                              .navigationBarHidden(true)
                              .sheet(isPresented: $isImagePickerPresented) {
                                  ImagePicker(selectedImage: $viewModel.selectedImage)
                              }
                          }
                      }




