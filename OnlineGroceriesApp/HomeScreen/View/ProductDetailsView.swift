//
//  ProductDetailsView.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 18/07/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProductDetailsView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @State var title: String = "Banana"
    @State var subTitle: String = "1kg, Price"
    @State var price: String = "$12.45"
    
    var body: some View {
        
        ZStack{
            
            ScrollView{
                ZStack{
                    Rectangle()
                        .foregroundColor(Color(hex: "F2F2F2"))
                        .frame(width: .screenWidth, height: .screenWidth * 0.8)
                        .cornerRadius(_radius: 20, corner: [.bottomLeft, .bottomRight])
                    
//                    WebImage(url: URL(string: "Group-2"))
//                        .resizable()
//                        .indicator(.activity)
//                        .transition(.fade(duration: 0.5))
//                        .scaledToFit()
//                        .frame(width: .screenWidth * 0.8, height: .screenWidth * 0.8)
                    
                    Image("92f1ea7dcce3b5d06cd1b1418f9b9413 3")
                        .resizable()
                        .scaledToFit()
                    .frame(width: .screenWidth * 0.8, height: .screenWidth * 0.8)
                    
                }
                .frame(width: .screenWidth, height: .screenWidth * 0.8)
                
                
                
                
                VStack{
                    HStack{
                        
                        Text(title)
                            .font(.customfont(.semibold, fontSize: 24))
                            .foregroundColor(.primaryText)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)

                        Button{
                            
                        } label: {
                            Image("bookmark 1-2")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                        }
                        .foregroundColor(Color.secondaryText)
                        
                    }
                    
                    Text(subTitle)
                        .font(.customfont(.semibold, fontSize: 16))
                        .foregroundColor(.secondaryText)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    
                    HStack{
                        
                        Button{
                            
                        } label: {
                            Image("Vector-5")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .padding(10)
                        }
                        .foregroundColor(Color.secondaryText)
                        
                        Text("1")
                            .font(.customfont(.semibold, fontSize: 24))
                            .foregroundColor(.primaryText)
                            .multilineTextAlignment(.center)
                            .frame(width: 45, height: 45, alignment: .center)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.secondaryText.opacity(0.5), lineWidth: 1)
                            )
                                
                            
                                
                        
                        Button{
                            
                        } label: {
                            Image("Vector-6")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .padding(10)
                        }
                        .foregroundColor(Color.secondaryText)
                        
                        Spacer()
                        Text(price)
                            .font(.customfont(.bold, fontSize: 28))
                            .foregroundColor(.primaryText)
                           

                    }
//                    .padding(.vertical, 8)
                    
                    Divider()
                    
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                
                
                
                
                
                
                VStack{
                    HStack{
                        
                        Text("Product detail")
                            .font(.customfont(.semibold, fontSize: 16))
                            .foregroundColor(.primaryText)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)

                        Button{
                            withAnimation {
                                
                            }
                        } label: {
                            Image("Vector-7")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 15, height: 15)
                                .padding(15)
                        }
                        .foregroundColor(Color.primaryText)
                        
                    }
//                    if {
                        Text("subTitlesubTitlesubTitlesubTitlesubTitlesubTitlesubTitlesubTitlesubTitlesubTitlesubTitlesubTitlesubTitlesubTitlesubTitlesubTi tlesubTitlesubTitlesubTitlesubTitlesubTitlesubTitlesubTitlesubTitlesubTitlesubTitlesubTitlesubTitlesubTitlesubTitlesubTitlesubTitlesubTitlesubTitlesubTitle")
                            .font(.customfont(.medium, fontSize: 13))
                            .foregroundColor(.secondaryText)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 8)
//                    }
//
                    
                    Divider()
                 
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 20)
                
               RoundButton(title: "Add to Basket")
                {
                    
                }
                .padding(20)
            }
            
            
            
            
            VStack{
                
                HStack{
                    
                    
                    Button{
                    
                    } label: {
                        Image("back arrow")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                    }
                    
                    Spacer()
                    
                    
                    Button{
                        mode.wrappedValue.dismiss()
                    } label: {
                        Image("Vector-4")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                    }
                }
                
                Spacer()
            }
            . padding(.top, .topInsets)
            .padding(.horizontal, 20)
        }
        
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

#Preview {
    ProductDetailsView()
}



