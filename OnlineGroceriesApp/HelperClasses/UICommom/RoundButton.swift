//
//  RoundButton.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 11/07/24.
//

import SwiftUI

struct RoundButton: View {
    @State var title: String = "Title"
    var didTap: (() -> Void)?
    var destination: AnyView?
    @State private var navigate = false

    var body: some View {
        Button(action: {
            didTap?()
            if destination != nil {
                navigate = true
            }
        }) {
            Text(title)
                .font(.customfont(.semibold, fontSize: 18))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60)
                .contentShape(Rectangle())
        }
        .background(Color.primaryApp)
        .cornerRadius(20)
        .buttonStyle(PlainButtonStyle())
        .background(
            NavigationLink(destination: destination, isActive: $navigate) {
                EmptyView()
            }
        )
    }
}

#Preview {
    RoundButton()
        .padding(20)
}
