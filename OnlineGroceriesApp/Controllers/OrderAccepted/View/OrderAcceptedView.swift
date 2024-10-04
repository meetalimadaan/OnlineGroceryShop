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
        VStack {
//            Spacer()
            Image("ic_order_accepted")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                
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
            .padding(.top, 30)
//            Spacer()

            Button(action: {
                homeVM.selectedTab = 0
                navigateToHome = true
            }) {
                Text("Back to Home")
                    .font(.customfont(.semibold, fontSize: 14))
                    .foregroundColor(.black)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
            }
            .padding(.horizontal, 25)
            .padding(.top, 20)
            .fullScreenCover(isPresented: $navigateToHome) {
                MainTabView()
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("")
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

struct OrderAcceptedView_Previews: PreviewProvider {
    static var previews: some View {
      
        let mockHomeVM = HomeViewModel()
    
        OrderAcceptedView()
            .environmentObject(mockHomeVM)
    }
}
