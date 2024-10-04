//
//  MainTabView.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 17/07/24.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var homeVM: HomeViewModel
    
    
    var body: some View {
        NavigationStack{
            TabView(selection: $homeVM.selectedTab) {
                HomeView()
                    .tabItem {
                        Label("Shop", systemImage: "bag")
                    }
                    .tag(0)
                
                ExploreView()
                    .tabItem {
                        Label("Explore", systemImage: "magnifyingglass")
                    }
                    .tag(1)
                
                MyCartView()
                    .tabItem {
                        Label("Cart", systemImage: "cart")
                        
                        
                    }
                    .tag(2)
                
                FavouriteView()
                    .tabItem {
                        Label("Favourite", systemImage: "heart")
                        
                    }
                    .tag(3)
                
                AccountView()
                    .tabItem {
                        Label("Account", systemImage: "person")
                    }
                    .tag(4)
            }
            .accentColor(Color.primaryApp)
            .navigationTitle("Online Groceries")
            .navigationBarHidden(true)
            .ignoresSafeArea()
        }
    }
}
