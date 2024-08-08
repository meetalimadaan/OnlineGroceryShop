//
//  UserDefaultsManager.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 01/08/24.
//

import Foundation

class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    
    private let adminIdKey = "adminId"
    private let usernameKey = "username"
    private let emailKey = "email"
    private let uidKey = "uid"
    
    private init() { }
    
    func setAdminId(_ adminId: String) {
        UserDefaults.standard.set(adminId, forKey: adminIdKey)
        print("Admin ID '\(adminId)' saved to UserDefaults.")
    }
    
    func getAdminId() -> String? {
        let adminId = UserDefaults.standard.string(forKey: adminIdKey)
        if let adminId = adminId {
            print("Admin ID '\(adminId)' retrieved from UserDefaults.")
        } else {
            print("Admin ID not found in UserDefaults.")
        }
        return adminId
    }
    
//    func removeAdminId() {
//        UserDefaults.standard.removeObject(forKey: adminIdKey)
//        print("Admin ID removed from UserDefaults.")
//    }
    
    func setUsername(_ username: String) {
        UserDefaults.standard.set(username, forKey: usernameKey)
        print("Username '\(username)' saved to UserDefaults.")
    }
    
    func getUsername() -> String? {
        let username = UserDefaults.standard.string(forKey: usernameKey)
        if let username = username {
            print("Username '\(username)' retrieved from UserDefaults.")
        } else {
            print("Username not found in UserDefaults.")
        }
        return username
    }
    
    func setEmail(_ email: String) {
        UserDefaults.standard.set(email, forKey: emailKey)
        print("Email '\(email)' saved to UserDefaults.")
    }
    
    func getEmail() -> String? {
        let email = UserDefaults.standard.string(forKey: emailKey)
        if let email = email {
            print("Email '\(email)' retrieved from UserDefaults.")
        } else {
            print("Email not found in UserDefaults.")
        }
        return email
    }
    
    func setUID(_ uid: String) {
        UserDefaults.standard.set(uid, forKey: uidKey)
        print("UID '\(uid)' saved to UserDefaults.")
    }
    
    func getUID() -> String? {
        let uid = UserDefaults.standard.string(forKey: uidKey)
        if let uid = uid {
            print("UID '\(uid)' retrieved from UserDefaults.")
        } else {
            print("UID not found in UserDefaults.")
        }
        return uid
    }
    
    func removeUserInfo() {
        UserDefaults.standard.removeObject(forKey: usernameKey)
        UserDefaults.standard.removeObject(forKey: emailKey)
        UserDefaults.standard.removeObject(forKey: uidKey)
        UserDefaults.standard.removeObject(forKey: adminIdKey)
        print("User info removed from UserDefaults.")
    }
}


