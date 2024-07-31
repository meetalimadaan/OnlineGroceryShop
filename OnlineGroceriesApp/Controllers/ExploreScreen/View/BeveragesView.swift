//
//  BeveragesView.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 19/07/24.
//

import SwiftUI

struct BeveragesView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Button{
                    
                    } label: {
                        Image("back arrow")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                    }
                    
                    Spacer()
                    Text("fhjgngjh")
                    Spacer()
                    
                    
                    Button{
                        mode.wrappedValue.dismiss()
                    } label: {
                        Image("Group 6839")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                    }
                }
                Spacer()
            }
            
            . padding(.top, .topInsets)
            .padding(.horizontal, 20)
            
            
//            ScrollView(.vertical, showsIndicators: false){
//                LazyHStack(spacing: 15){
//                    ForEach(0...5, id: \.self) {
//                        index in
//                        
//                        ProductCell {
//                            
//                        }
//                        
//                    }
//                }
//                .padding(.horizontal, 20)
//                .padding(.vertical, 4)
//            }
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

#Preview {
    BeveragesView()
}
