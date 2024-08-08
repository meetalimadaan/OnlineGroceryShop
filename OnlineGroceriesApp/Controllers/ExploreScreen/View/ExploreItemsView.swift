//
//  ExploreItemsView.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 22/07/24.
//

import SwiftUI

struct ExploreItemsView: View {
    @StateObject var exploreVM = ExploreVireModel()
    @StateObject var homeVM = HomeViewModel()
    @Environment(\.presentationMode)  var mode: Binding<PresentationMode>
    var category: Category
    
    var column = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15)
    ]
    
    var body: some View {
        ZStack{
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
                    
                    
                    
                    Text(category.name!)
                        .font(.customfont(.bold, fontSize: 20))
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                    
                    
                    Button{
                        mode.wrappedValue.dismiss()
                    } label: {
                        Image("Group 6839")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                    }
                }
                
                ScrollView{
                    
                    LazyVGrid(columns: column, spacing: 15) {
                        ForEach(homeVM.products) { product in
                            ProductCell(product: product) {
                                
                            }
                        }
                        
                    }
                    //                    .padding(.horizontal, 10)
                    .padding(.vertical, 10)
                    .padding(.bottom, .bottomInsets + 60)
                }
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

//#Preview {
//    ExploreItemsView()
//}
