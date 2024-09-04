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
    @StateObject private var homeVM = HomeViewModel()
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                MainTabView()
                    .environmentObject(homeVM)
            } else {
                WelcomeView()
            }
        }
    }
}

