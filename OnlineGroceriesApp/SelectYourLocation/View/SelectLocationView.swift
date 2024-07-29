//
//  SelectLocationView.swift
//  OnlineGroceriesApp
//
//  Created by Prince on 26/07/24.
//

import SwiftUI

struct SelectLocationView: View {
    var body: some View {
        VStack{
            Spacer()
            Image("map")
            Text("Select Your Location").font(.customfont(.semibold, fontSize: 26))
                .foregroundColor(.primaryText)
                .multilineTextAlignment(.leading)
                .padding(.bottom, 25)
            Text("Switch on your location to stay in tune with what’s happening in your area").multilineTextAlignment(.center).font(.customfont(.semibold, fontSize: 16))
                .foregroundColor(.textTitle)
                .multilineTextAlignment(.leading)
                .padding(.horizontal, 25)
            Spacer()
            
            AddLocationView()
        } .navigationTitle("")
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
       
    }
    
}

#Preview {
    SelectLocationView()
}
