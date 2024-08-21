//
//  MyCartView.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 22/07/24.
//

import SwiftUI
import FirebaseFirestore
import Firebase

struct MyCartView: View {
    @ObservedObject private var viewModel = MyCartViewModel.shared
    
    var body: some View {
            ZStack {
                if viewModel.cartItems.isEmpty {
                    // Display message when cart is empty
                    Text("Your cart is empty")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    ScrollView {
                        LazyVStack {
                            ForEach(viewModel.cartItems) { cartItem in
                                let productCellViewModel = ProductCellViewModel(cartItem: cartItem)
                                CartItemRow(viewModel: productCellViewModel, cartItem: cartItem)
                            }
                        }
                        .padding(20)
                        .padding(.top, .topInsets + 46)
                        .padding(.bottom, .bottomInsets + 60)
                    }
                }
                
                VStack {
                    HStack {
                        Spacer()
                        
                        Text("My Cart")
                            .font(.customfont(.bold, fontSize: 20))
                            .frame(height: 46)
                        
                        Spacer()
                    }
                    .padding(.top, .topInsets)
                    .background(Color.white)
                    .shadow(color: Color.black.opacity(0.2), radius: 2)
                    
                    Spacer()
                    
                    if !viewModel.cartItems.isEmpty {
                        RoundButton(title: "Go to Checkout")
                            .padding(.horizontal, 20)
                            .padding(.bottom, .bottomInsets + 80)
                    }
                }
            }
            .navigationTitle("")
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            .ignoresSafeArea()
            .onAppear {
                viewModel.fetchCartItems()
            }
        }
    }

    #Preview {
        MyCartView()
    }
