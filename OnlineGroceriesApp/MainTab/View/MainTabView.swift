//
//  MainTabView.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 17/07/24.
//

import SwiftUI

struct MainTabView: View {
    
    @StateObject var homeVM = HomeViewModel.shared
    
    var body: some View {
        ZStack{
            
//            TabView(selection: $homeVM.selectTab) {
//                HomeView().tag(0)
//                ExploreView().tag(1)
//                ExploreView().tag(2)
//                ExploreView().tag(3)
//                ExploreView().tag(4)
//            }
////
//            .tabViewStyle(.page(indexDisplayMode: .never))
//                    
//            .onChange(of: homeVM.selectTab){ newValue in
//                debugPrint("Sel Tab: \(newValue)")
            
            if (homeVM.selectTab == 0){
                HomeView()
            }else if (homeVM.selectTab == 1){
                ExploreView()
            }else if (homeVM.selectTab == 2){
                MyCartView ()
            }else if (homeVM.selectTab == 3){
                FavouriteView()
            }else if (homeVM.selectTab == 4){
                AccountView()
            }
            
           
            VStack {
                Spacer()
                HStack{
                    
                    TabButton(title: "Shop", icon: "store 1-2", isSelect: homeVM.selectTab == 0) {
                        print("Button Tabbb")
                        DispatchQueue.main.async {
                            withAnimation {
                                homeVM.selectTab = 0
                            }
                        }
                    }
                    
                    TabButton(title: "Explore", icon: "Group 3", isSelect: homeVM.selectTab == 1) {
                        DispatchQueue.main.async {
                            withAnimation {
                                homeVM.selectTab = 1
                            }
                        }
                    }
                    
                    TabButton(title: "Cart", icon: "Vector 1", isSelect: homeVM.selectTab == 2) {
                        DispatchQueue.main.async {
                            withAnimation {
                                homeVM.selectTab = 2
                            }
                        }
                    }
                    
                    TabButton(title: "Favourite", icon: "bookmark 1", isSelect: homeVM.selectTab == 3) {
                        DispatchQueue.main.async {
                            withAnimation {
                                homeVM.selectTab = 3
                            }
                        }
                    }
                    
                    TabButton(title: "Account", icon: "user 1", isSelect: homeVM.selectTab == 4) {
                        DispatchQueue.main.async {
                            withAnimation {
                                homeVM.selectTab = 4
                            }
                        }
                    }
                   
                }
                .padding(.top, 10)
                .padding(.bottom, 10)
                .padding(.horizontal, 10)
                .background(Color.white)
                .cornerRadius(15)
            .shadow(color: Color.black.opacity(0.15), radius: 3, x:0, y: -2)
            }
        }
        
        .navigationTitle("wehhdef")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
        
    }
}

#Preview {
    MainTabView()
}
