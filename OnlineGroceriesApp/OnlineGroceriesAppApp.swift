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
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false

    init() {
          
            FirebaseApp.configure()
        }
    
    var body: some Scene {
            WindowGroup {
                if isLoggedIn {
                    MainTabView()
                } else {
                    LoginView()
                }
            }
        }
    }
