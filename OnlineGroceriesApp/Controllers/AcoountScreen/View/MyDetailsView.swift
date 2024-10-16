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
    @State private var isUploading = false
    @State private var isEditAlertPresented: Bool = false
    @State private var editedValue: String = ""
    @State private var fieldToEdit: String = ""
    
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
                        .foregroundColor(.primaryApp)
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
                            .clipShape(Circle())
                    }
                } else if let selectedImage = viewModel.selectedImage {
                    
                    Image(uiImage: selectedImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: radius * 2, height: radius * 2)
                        .clipShape(Circle())
                } else {
                    
                    Image("original 1")
                           .resizable()
                           .frame(width: radius * 2, height: radius * 2)
                           .clipShape(Circle())
                }
                
                
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
                .offset(x: offset, y: offset)
            }
            .padding(.top, 10)
            
            
            if viewModel.selectedImage != nil {
                if isUploading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .green))
                        .padding()
                } else if !viewModel.uploadCompleted {
                    Button(action: {
                        isUploading = true
                        viewModel.uploadProfileImage {
                            isUploading = false
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
            
            
            
            if let userProfile = viewModel.userProfile {
                UsernameRow(username: userProfile.username, title: "Username", iconName: "person") {
                    
                    print("Edit username tapped")
                }
                
                UsernameRow(username: userProfile.email, title: "Email", iconName: "envelope") {
                    
                    print("Edit email tapped")
                }
            } else {
                //
            }
            
            Spacer()
        }
        .navigationBarHidden(true)
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePicker(selectedImage: $viewModel.selectedImage)
        }
    }
}




