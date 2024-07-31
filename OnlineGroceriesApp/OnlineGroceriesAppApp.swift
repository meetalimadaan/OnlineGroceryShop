//
//  OnlineGroceriesAppApp.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 10/07/24.
//

import SwiftUI
import Firebase
@main
struct OnlineGroceriesAppApp: App {
    init() {
          
            FirebaseApp.configure()
        }
    
    var body: some Scene {
        WindowGroup {
            
            
            NavigationView {
                
//                if mainVM{
//                    MainTabView()
//                }else{
//                    WelcomeView()
//                }
                WelcomeView()
//                SignUpView()
//                MainTabView()
//                LoginView()
            }
           
        }
    }
}
