//
//  OrderAcceptedView.swift
//  OnlineGroceriesApp
//
//  Created by Prince on 29/07/24.
//

import SwiftUI

struct OrderAcceptedView: View {
    @EnvironmentObject var homeVM: HomeViewModel
    @State private var navigateToHome = false

    var body: some View {
        ScrollView {
            Spacer()
            Image("ic_order_accepted")
            
            VStack {
                Text("Your Order has been accepted")
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 25)
                    .padding(.vertical, 10)
                    .font(.customfont(.semibold, fontSize: 20))
                
                Text("Your items have been placed and are on its way to being processed.")
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 25)
                    .font(.customfont(.regular, fontSize: 16))
                    .foregroundColor(.gray)
            }
            .padding(.top, 10)
            Spacer()
            Spacer()
            
            Button(action: {
                homeVM.selectedTab = 0
                navigateToHome = true
            }) {
                Text("Back to Home")
                    .font(.customfont(.semibold, fontSize: 14))
                    .foregroundColor(.black)
            }
            .padding(.horizontal, 25)
            .background(
                NavigationLink(destination: MainTabView(), isActive: $navigateToHome) {
                    EmptyView()
                }
            )
        }
        .navigationBarBackButtonHidden(true)
    }
}
