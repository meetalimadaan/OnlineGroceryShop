//
//  AddLocationView.swift
//  OnlineGroceriesApp
//
//  Created by Prince on 26/07/24.
//

import SwiftUI

struct AddLocationView: View {
    @Binding var address: Address?
    @StateObject var locationVM = LocationViewModel.shared
    
    var body: some View {
        VStack(alignment: .leading){
            Text("City").frame(alignment: .leading).font(.system(size: 16, weight: .semibold, design: .default)).foregroundColor(.gray)
            VStack{
                //                NavigationLink(destination: EmptyView()) {
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.white).frame(height: 40)
                    HStack{
                        Text(address?.city ?? "Enter City").font(.system(size: 16, design: .default)).foregroundColor(.gray)
                        Spacer()
                        //                        Image(systemName: "chevron.down").frame(alignment: .trailing).padding(.horizontal,10).foregroundColor(.gray)
                    }
                    
                }
                //            }
                
                Divider()
            }.padding(.bottom, .screenWidth * 0.07)
            
            Text("State").frame(alignment: .leading)   .font(.system(size: 16, weight: .semibold, design: .default)).foregroundColor(.gray)
            VStack{
                //                NavigationLink(destination: EmptyView()) {
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.white).frame(height: 40)
                    HStack{
                        Text(address?.state ?? "Enter State").font(.system(size: 16, design: .default)).foregroundColor(.gray)
                        Spacer()
                        //                            Image(systemName: "chevron.down").frame(alignment: .trailing).padding(.horizontal,10).foregroundColor(.gray)
                    }
                    
                }
                //                }
                Divider()
            }.padding(.bottom, .screenWidth * 0.07)
            
            Text("Country").frame(alignment: .leading)   .font(.system(size: 16, weight: .semibold, design: .default)).foregroundColor(.gray)
            VStack{
                //                NavigationLink(destination: EmptyView()) {
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.white).frame(height: 40)
                    HStack{
                        Text(address?.country ?? "Enter Country").font(.system(size: 16, design: .default)).foregroundColor(.gray)
                        Spacer()
                        //                            Image(systemName: "chevron.down").frame(alignment: .trailing).padding(.horizontal,10).foregroundColor(.gray)
                    }
                    
                }
                //                }
                Divider()
            }.padding(.bottom, .screenWidth * 0.07)
            
            Text("Zipcode").frame(alignment: .leading)   .font(.system(size: 16, weight: .semibold, design: .default)).foregroundColor(.gray)
            VStack{
                //                NavigationLink(destination: EmptyView()) {
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.white).frame(height: 40)
                    HStack{
                        Text(address?.zipCode ?? "Enter Zipcode").font(.system(size: 16, design: .default)).foregroundColor(.gray)
                        Spacer()
                        //                            Image(systemName: "chevron.down").frame(alignment: .trailing).padding(.horizontal,10).foregroundColor(.gray)
                    }
                    
                }
                //                }
                Divider()
            }.padding(.bottom, .screenWidth * 0.07)
            
            //            NavigationLink(destination: MainTabView()) {
            //                RoundButton(title: "Submit") {
            ////                   navigateToMainTabView = true
            //                }
            //            }
                .padding(.bottom, .screenWidth * 0.05)
            
            
            
        }.padding(.horizontal,25)
    }
}

//#Preview {
//    AddLocationView()
//}
