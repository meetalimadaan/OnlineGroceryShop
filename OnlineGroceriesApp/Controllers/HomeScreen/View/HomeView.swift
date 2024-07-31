//
//  HomeView.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 17/07/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject var homeVM = HomeViewModel.shared
    
    var body: some View {
        ZStack{
            ScrollView{
                VStack{
                    Image("Group-2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25)
//                        .padding(.bottom, .screenWidth * 0.1)
                    
                    NavigationLink{
                        SelectLocationView()
                    }label: {
                        HStack{
                            Image("Exclude")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 16, height: 16)
    //                            .padding(.bottom, .screenWidth * 0.1)
                            
                            
                            Text("dhaka, Banassre")
                                .font(.customfont(.semibold, fontSize: 18))
                                .foregroundColor(.darkGray)
                        }
                    }
                    
                    SearchTextField(placeholder: "Search Store", txt: $homeVM.txtSearch)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                }
                .padding(.top, .topInsets)
                
                Image("banner")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 115)
                    .padding(.horizontal, 20)
                
                SectionTitleAll(title: "Exclusive offer", titleAll: "See All") {
                    
                }
                .padding(.horizontal, 20)
                
                ScrollView(.horizontal, showsIndicators: false){
                    LazyHStack(spacing: 15){
                        ForEach(0...5, id: \.self) {
                            index in
                            
                            ProductCell {
                                
                            }
                            
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 4)
                }
                
                
                SectionTitleAll(title: "Best Selling", titleAll: "See All") {
                    
                }
                .padding(.horizontal, 20)
                
                ScrollView(.horizontal, showsIndicators: false){
                    LazyHStack(spacing: 15){
                        ForEach(0...5, id: \.self) {
                            index in
                            
                            ProductCell {
                                
                            }
                            
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 4)
                }
                
                SectionTitleAll(title: "Groceries", titleAll: "See All") {
                    
                }
                .padding(.horizontal, 20)
                
                
                ScrollView(.horizontal, showsIndicators: false){
                    LazyHStack(spacing: 15){
                        ForEach(0...5, id: \.self) {
                            index in
                            
                            CategoryCell(color: Color(hex: "F8A44C")) {
                                
                            }
                            
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 4)
                }
                .padding(.bottom, 8)
                
                
                ScrollView(.horizontal, showsIndicators: false){
                    LazyHStack(spacing: 15){
                        ForEach(0...5, id: \.self) {
                            index in
                            
                            ProductCell {
                                
                            }
                            
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 4)
                }
//                .padding(.bottom, 30)
                .padding(.bottom, .bottomInsets + 60)
                
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    HomeView()
}
