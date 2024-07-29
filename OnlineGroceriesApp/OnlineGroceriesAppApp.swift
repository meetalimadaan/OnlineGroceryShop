//
//  OnlineGroceriesAppApp.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 10/07/24.
//

import SwiftUI

@main
struct OnlineGroceriesAppApp: App {
    @StateObject var  mainVM = LoginViewModel.shared
    
    var body: some Scene {
        WindowGroup {
            
            
            NavigationView {
                
//                if mainVM{
//                    MainTabView()
//                }else{
//                    WelcomeView()
//                }
                SelectLocationView()

//                WelcomeView()
//                MainTabView()
//                LoginView()
            }
           
        }
    }
}
