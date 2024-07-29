//
//  CommonAppBar.swift
//  OnlineGroceriesApp
//
//  Created by Prince on 26/07/24.
//

import SwiftUI

struct CommonAppBar: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    var centerTitle = "Center";
    var isTitle = false;
    var isBackButton = false;
    var isTrailingButton = false;
    var trailingIcon = "Vector-4";
    var body: some View {
        VStack{
            
            HStack{
                
                if(isBackButton){
                    Button{
                        
                    } label: {
                        Image("back arrow")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                    }
                }
                
                Spacer()
                if(isTitle){
                    Text(centerTitle)
                }
                Spacer()
                if(isTrailingButton){
                    Button{
                                            mode.wrappedValue.dismiss()
                    } label: {
                        Image(trailingIcon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                    }
                }
            }
            
            Spacer()
        }
        . padding(.top, .topInsets)
        .padding(.horizontal, 20)

    }
}

#Preview {
    CommonAppBar()
}
