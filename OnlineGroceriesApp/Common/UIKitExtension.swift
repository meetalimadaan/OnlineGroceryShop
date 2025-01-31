//
//  UIKitExtension.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 17/07/24.
//

import Foundation

extension String{
    func isValidEmail() -> Bool {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-aa-z]{2,}"
            let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
            return emailTest.evaluate(with: self)
        }
}
