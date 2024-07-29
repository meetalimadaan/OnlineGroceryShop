//
//  OrderAcceptedView.swift
//  OnlineGroceriesApp
//
//  Created by Prince on 29/07/24.
//

import SwiftUI

struct OrderAcceptedView: View {
    var body: some View {
        Spacer()
        Image("ic_order_accepted")
        
        
        VStack{
            Text("Your Order has been accepted").multilineTextAlignment(.center)
                .padding(.horizontal, 25).padding(.vertical,10).font(.customfont(.semibold, fontSize: 20))


            Text("Your items has been placcd and is on it’s way to being processed").multilineTextAlignment(.center)
                .padding(.horizontal, 25).font(.customfont(.regular, fontSize: 16)).foregroundColor(.gray)
        }.padding(.top,10)
        Spacer()
        Spacer()
        NavigationLink(destination: MainTabView()) {
            RoundButton(title: "Submit") {
//                   navigateToMainTabView = true
            }
        }
        .padding(.bottom, .screenWidth * 0.05).padding(.horizontal, 25)
        NavigationLink {
            SignUpView()
        } label: {
                Text("Back to home")
                    .font(.customfont(.semibold, fontSize: 14))
                    .foregroundColor(.primaryText)
            
            
        }.padding(.horizontal, 25)
    }
}

#Preview {
    OrderAcceptedView()
}
