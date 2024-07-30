//
//  SelectLocationView.swift
//  OnlineGroceriesApp
//
//  Created by Prince on 26/07/24.
//

import SwiftUI

struct SelectLocationView: View {
    @State private var showCustomDialog = false

    var body: some View {
        ZStack{
            VStack{
                Spacer()
                Image("map")
                Text("Select Your Location").font(.customfont(.semibold, fontSize: 26))
                    .foregroundColor(.primaryText)
                    .multilineTextAlignment(.leading)
                    .padding(.bottom, 25)
                Text("Switch on your location to stay in tune with what’s happening in your area").multilineTextAlignment(.center).font(.customfont(.semibold, fontSize: 16))
                    .foregroundColor(.textTitle)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, 25)
                Spacer()
                
                AddLocationView()
                VStack{
                    Button("Show Custom Dialog") {
                        showCustomDialog = true
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
                            } .navigationTitle("")
                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)
            if showCustomDialog {
                            Popup(isPresented: $showCustomDialog) {
                                VStack{
                                    Image("ic_grocery")
                                    VStack{
                                        Text("Oops! Order Failed").multilineTextAlignment(.center)
                                            .padding(.horizontal, 25).padding(.vertical,10).font(.customfont(.semibold, fontSize: 20))


                                        Text("Something went tembly wrong.").multilineTextAlignment(.center)
                                            .padding(.horizontal, 25).font(.customfont(.regular, fontSize: 16)).foregroundColor(.gray)
                                    }.padding(.top,10)
                                    Spacer()
                                    NavigationLink(destination: MainTabView()) {
                                        RoundButton(title: "Please Try Again") {
                            //                   navigateToMainTabView = true
                                        }
                                    }
                                    .padding(.bottom, .screenWidth * 0.05).padding(.horizontal, 25)
                                    NavigationLink {
                                        SignUpView()
                                    } label: {
                                            Text("Back to home")
                                                .font(.customfont(.semibold, fontSize: 14))
                                                .foregroundColor(.primaryText)
                                        
                                        
                                    }.padding(.horizontal, 25)
                                }

                            }
                        }
            
        }
       
    }
    
}

#Preview {
    SelectLocationView()
}
