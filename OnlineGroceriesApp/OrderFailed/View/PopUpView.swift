//
//  PopUpView.swift
//  OnlineGroceriesApp
//
//  Created by Prince on 29/07/24.
//

import SwiftUI

struct Popup<Content: View>: View {

    @Binding var isPresented: Bool
    let content: Content
    let dismissOnTapOutside: Bool

    private let buttonSize: CGFloat = 24

    var body: some View {

        ZStack {

            Rectangle()
                .fill(.gray.opacity(0.7))
                .ignoresSafeArea()
                .onTapGesture {
                    if dismissOnTapOutside {
                        withAnimation {
                            isPresented = false
                        }
                    }
                }

            content
                .frame(
                    width: UIScreen.main.bounds.size.width - 100, height: 500)
                .padding()
                .padding(.top, buttonSize)
                .background(.white)
                .cornerRadius(12)
                .overlay(alignment: .topLeading) {
                    Button(action: {
                        withAnimation {
                            isPresented = false
                        }
                    }, label: {
                        Image(systemName: "multiply").foregroundColor(.black)
                    })
                    .font(.system(size: 24, weight: .bold, design: .default))
                    .foregroundStyle(Color.gray.opacity(0.7))
                    .padding(.all, 15)
                }
        }
        .ignoresSafeArea(.all)
        .frame(
            width: UIScreen.main.bounds.size.width,
            height: UIScreen.main.bounds.size.height,
            alignment: .center
        )
    }
        
}
//#Preview {
////    PopUpView()
//}
extension Popup {

    init(isPresented: Binding<Bool>,
         dismissOnTapOutside: Bool = true,
         @ViewBuilder _ content: () -> Content) {
        _isPresented = isPresented
        self.dismissOnTapOutside = dismissOnTapOutside
        self.content = content()
    }
}
