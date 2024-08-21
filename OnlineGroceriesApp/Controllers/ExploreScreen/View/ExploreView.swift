//
//  ExploreView.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 17/07/24.
//

import SwiftUI

struct ExploreView: View {
    @StateObject var exploreVM = ExploreVireModel()
    
    var column = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15)
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    HStack {
                        Spacer()
                        
                        Text("Find Category")
                            .font(.customfont(.bold, fontSize: 20))
                            .frame(height: 46)
                        
                        Spacer()
                    }
                    .padding(.top, .topInsets)
                    
                    SearchTextField(placeholder: "Search Categories", txt: $exploreVM.searchText)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 4)
                    
                    ScrollView {
                        if exploreVM.filteredCategories.isEmpty {
                            Text("No matches")
                                .font(.customfont(.bold, fontSize: 18))
                                .foregroundColor(.gray)
                                .padding(.top, 50)
                        } else {
                            LazyVGrid(columns: column, spacing: 20) {
                                ForEach(exploreVM.filteredCategories) { category in
                                    ExploreCategoryCell(category: category)
                                        .aspectRatio(0.95, contentMode: .fill)
                                }
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .padding(.bottom, .bottomInsets + 60)
                        }
                    }
                    
                    Spacer()
                }
            }
            .ignoresSafeArea()
        }
    }
}

    
//    #Preview {
//        NavigationView{
//            ExploreView()
//        }
//        
//    }

