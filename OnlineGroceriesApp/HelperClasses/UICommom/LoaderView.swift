//
//  LoaderView.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 23/09/24.
//

import SwiftUI

struct LoaderView: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .edgesIgnoringSafeArea(.all)
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                .scaleEffect(1.5)
        }
    }
}
