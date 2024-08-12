//
//  ViewExtension.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 09/08/24.
//

import SwiftUI

struct showButton: ViewModifier {
    @Binding var isShow: Bool
    public func body(content: Content) -> some View {
        HStack {
            content
            Button {
                isShow.toggle()
            } label: {
                Image(systemName: !isShow ? "eye.slash.fill" : "eye.fill")
                    .foregroundColor(.textTitle)
            }
        }
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corner: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corers: corner))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corers: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corers, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
