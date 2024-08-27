//
//  SelectLocationView.swift
//  OnlineGroceriesApp
//
//  Created by Prince on 26/07/24.
//

import SwiftUI
import CoreLocation
struct SelectLocationView: View {
    @StateObject private var viewModel = SelectLocationViewModel()
    
    
    var body: some View {
        //        NavigationView{
        ScrollView {
            ZStack {
                VStack {
                    Image("map")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 180, height: 180)
                        .padding(.top, 20)
                    
                    Text("Hello \(viewModel.username), Select Your Location")
                        .font(.customfont(.semibold, fontSize: 16))
                        .foregroundColor(.primaryText)
                        .multilineTextAlignment(.leading)
                        .padding(.bottom, 40)
                    
                    Button(action: {
                        viewModel.requestLocation()
                    }) {
                        Text("Use My Current Location")
                            .font(.customfont(.semibold, fontSize: 16))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                    .padding(.bottom, 20)
                    
                    AddLocationView(address: $viewModel.address)
                    
                    HStack(alignment: .center) {
                        Image(systemName: viewModel.isDefaultLocationChecked ? "checkmark.square.fill" : "square")
                            .foregroundColor(viewModel.isDefaultLocationChecked ? .blue : .gray)
                            .onTapGesture {
                                viewModel.isDefaultLocationChecked.toggle()
                                print("Default Status: \(viewModel.isDefaultLocationChecked)")
                            }
                        
                        Text("Set My Default Location")
                            .font(.customfont(.semibold, fontSize: 16))
                            .foregroundColor(.primaryText)
                        
                        Spacer()
                    }
                    .padding(.leading, 25)
                    .padding(.bottom, 20)
                    
                    Button(action: {
                        viewModel.saveAddress()
                        
                        print("Location saved: \(viewModel.address ?? Address(city: "Unknown", state: "Unknown", country: "Unknown", zipCode: "Unknown", isDefault: false))")
                    }) {
                        Text("Save")
                            .font(.customfont(.semibold, fontSize: 16))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(8)
                    }
                    .padding(.bottom, 30)
                    
                    Spacer()
                }
                .padding(.horizontal, 25)
            }
            .onAppear {
                viewModel.fetchUsername()
            }
        }
    }
}


#Preview {
    SelectLocationView()
}
