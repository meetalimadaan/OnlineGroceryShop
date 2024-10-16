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
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @ObservedObject private var viewModel = MyCartViewModel.shared
    @State private var navigateToCheckout: Bool = false
    var showBackButton: Bool = false

    var body: some View {
        NavigationStack {
            ZStack {
                if viewModel.cartItems.isEmpty {
                    GeometryReader { geometry in
                        Text("Your cart is empty")
                            .font(.customfont(.bold, fontSize: 18))
                            .foregroundColor(.secondaryText)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                    }
                    .frame(maxHeight: .infinity) // Ensure the GeometryReader takes all available height
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
                        if showBackButton {
                            Button(action: {
                                mode.wrappedValue.dismiss()
                            }) {
                                Image(systemName: "chevron.backward")
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(.primaryApp)
                            }
                        }
                        Spacer()
                        
                        Text("My Cart")
                            .font(.customfont(.bold, fontSize: 20))
                            .frame(height: 46)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 10)
                    .padding(.top, .topInsets)
                    .background(Color.white)
                    .shadow(color: Color.black.opacity(0.2), radius: 2)
                    
                    Spacer()
                    
                    if !viewModel.cartItems.isEmpty {
                        VStack {
                            Button(action: {
                                navigateToCheckout = true
                            }) {
                                HStack {
                                    Text("Proceed to Checkout")
                                        .font(.customfont(.semibold, fontSize: 18))
                                        .foregroundColor(.white)
                                    
                                    Text("Rs \(viewModel.totalAmount, specifier: "%.2f")")
                                        .font(.customfont(.semibold, fontSize: 18))
                                        .foregroundColor(.white)
                                }
                                .multilineTextAlignment(.center)
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60)
                                .contentShape(Rectangle())
                                .background(Color.primaryApp)
                                .cornerRadius(20)
                                .buttonStyle(PlainButtonStyle())
                            }
                            .padding(.horizontal, 20)
                            .padding(.bottom, showBackButton ? .bottomInsets + 30 : .bottomInsets + 80) // Conditional padding
                            
                            NavigationLink(destination: CheckOut(), isActive: $navigateToCheckout) {
                                EmptyView()
                            }
                        }
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
}

// Preview code
#Preview {
    MyCartView()
}
