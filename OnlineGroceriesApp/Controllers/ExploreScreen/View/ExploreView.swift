//
//  ExploreView.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 17/07/24.
//

import SwiftUI

struct ExploreView: View {
    @StateObject var exploreVM = ExploreVireModel()
    @State var txtSearch: String = ""
    
    var column = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15)
    ]
    
    var body: some View {
        NavigationView{
            ZStack{
                
                VStack{
                    HStack{
                        
                        Spacer()
                        
                        Text("Find Products")
                            .font(.customfont(.bold, fontSize: 20))
                            .frame(height: 46)
                        
                        Spacer()
                    }
                    .padding(.top, .topInsets)
                    
                    
                    SearchTextField(placeholder: "Search Store", txt: $txtSearch)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 4)
                    
                    
                    ScrollView{
                        LazyVGrid(columns: column, spacing: 20) {
                            ForEach(exploreVM.categories) { category in
                                ExploreCategoryCell(category: category)
                                    .aspectRatio(0.95, contentMode: .fill)
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .padding(.bottom, .bottomInsets + 60)
                    }
                    
                    Spacer()
                }
            }
            .ignoresSafeArea()
        }
    }
    
//    #Preview {
//        NavigationView{
//            ExploreView()
//        }
//        
//    }
}
