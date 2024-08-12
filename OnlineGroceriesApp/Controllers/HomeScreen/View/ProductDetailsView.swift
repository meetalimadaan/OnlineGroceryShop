//
//  ProductDetailsView.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 18/07/24.
//

import SwiftUI


struct ProductDetailsView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State private var isFavorite: Bool = false
    var product: Product
    
    
    var body: some View {
        
        ZStack{
            
            ScrollView{
                ZStack{
                    Rectangle()
                        .foregroundColor(Color(hex: "F2F2F2"))
                        .frame(width: .screenWidth, height: .screenWidth * 0.8)
                        .cornerRadius(20, corner: [.bottomLeft, .bottomRight])
                    
                    AsyncImage(url: URL(string: product.img)) { image in
                        image.resizable()
                            .scaledToFit()
                            .frame(width: .screenWidth * 0.8, height: .screenWidth * 0.8)
                    } placeholder: {
                        ProgressView()
                    }
                    
                }
                .frame(width: .screenWidth, height: .screenWidth * 0.8)
                
                
                
                
                VStack{
                    HStack{
                        
                        Text(product.name)
                            .font(.customfont(.semibold, fontSize: 24))
                            .foregroundColor(.primaryText)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        
                        Button {
                            toggleFavorite()
                        } label: {
                            Image(systemName: isFavorite ? "heart.fill" : "heart")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                        }
                        .foregroundColor(isFavorite ? .red : .secondaryText)
                        
                    }
                    
                    Text("\(product.stock) pcs, price")
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
                        Text("$\(product.price, specifier: "%.2f")")
                            .font(.customfont(.bold, fontSize: 28))
                            .foregroundColor(.primaryText)
                        
                    }
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
                    
                    Text(product.description)
                        .font(.customfont(.medium, fontSize: 13))
                        .foregroundColor(.secondaryText)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 8)
                    
                    Divider()
                    
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 20)
                .padding(20)
            }
            
            
            
            
            VStack{
                
                HStack{
                    
                    
                    Button{
                        mode.wrappedValue.dismiss()
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
    private func toggleFavorite() {
        isFavorite.toggle()
        // Add logic to update favorite status in your data source
    }
}

//#Preview {
//    ProductDetailsView(product: Product(name: "", categoryID: "", price: 0, description: "", img: "", stock: ""))
//}



