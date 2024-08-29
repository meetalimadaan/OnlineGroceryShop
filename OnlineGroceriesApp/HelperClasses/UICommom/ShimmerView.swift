//
//  ShimmerView.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 08/08/24.
//

import SwiftUI
import ShimmerView

struct ShimmerView: View {
    @State private var isAnimating: Bool = true
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        ShimmerScope(isAnimating: $isAnimating) {
            HStack(alignment: .top) {
                ShimmerElement(width: width, height: height)
                    .cornerRadius(4)
                VStack(alignment: .leading, spacing: 8) {
                    ShimmerElement(height: 12)
                        .cornerRadius(4)
                    ShimmerElement(height: 12)
                        .cornerRadius(4)
                    ShimmerElement(width: width, height: 12)
                        .cornerRadius(4)
                }
            }
            .padding(.horizontal, 16)
        }
        .frame(width: width, height: height)
    }
}

#Preview {
    ShimmerView(width: 100, height: 100)
}
