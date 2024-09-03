//
//  OrderAcceptedView.swift
//  OnlineGroceriesApp
//
//  Created by Prince on 29/07/24.
//

import SwiftUI

struct OrderAcceptedView: View {
    
    var body: some View {
        ScrollView{
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
           
            NavigationLink {
               HomeView()
            } label: {
                Text("BAck to Home")
                    .font(.customfont(.semibold, fontSize: 14))
                    .foregroundColor(.black)
                
                
            }.padding(.horizontal, 25)
        }
        .navigationBarBackButtonHidden(true)
    }
}
#Preview {
    OrderAcceptedView()
}
