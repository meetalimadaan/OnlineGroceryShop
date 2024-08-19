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
    @State private var cartItems: [CartItem] = []
    
    var body: some View {
        ZStack {
            
            //            ScrollView{
            //
            //            }
            //
            //            VStack{
            //                HStack{
            //                    Spacer()
            //
            //                   Text("My Cart")
            //                        .font(.customfont(.bold, fontSize: 20))
            //                        .frame(height: 46)
            //
            //                    Spacer()
            //
            //                }
            //                .padding(.top, .topInsets)
            //                .background(Color.white)
            //                .shadow(color: Color.black.opacity(0.2), radius: 2 )
            //
            //                Spacer()
            //            }
            
            
            ScrollView{
                LazyVStack{
                    
                    ForEach(cartItems) { cartItem in
                        CartItemRow(cartItem: cartItem)
                    }
                }
                .padding(20)
                .padding(.top, .topInsets + 46)
                .padding(.bottom, .bottomInsets + 60)
                
            }
            //            .padding(.top, .topInsets + 60)
            
            VStack{
                HStack{
                    Spacer()
                    
                    Text("My Cart")
                        .font(.customfont(.bold, fontSize: 20))
                        .frame(height: 46)
                    
                    Spacer()
                    
                }
                .padding(.top, .topInsets)
                .background(Color.white)
                .shadow(color: Color.black.opacity(0.2), radius: 2 )
                
                Spacer()
                
                //                RoundButton(title: "Go to Checkout")
                //                    .padding(.horizontal, 20)
                //                    .padding(.bottom, .bottomInsets + 80)
            }
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea()
        .onAppear {
            fetchCartItems()
        }
    }
    
    func fetchCartItems() {
        guard let userID = getCurrentUserID() else { return }
        
        let userCartRef = Firestore.firestore().collection("userCart").document(userID)
        
        userCartRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let cartItemsData = document.data()?["cartItems"] as? [[String: Any]] ?? []
                
                self.cartItems = cartItemsData.compactMap { data in
                    return CartItem(
                        id: data["productID"] as? String ?? "",
                        name: data["name"] as? String ?? "",
                        price: data["price"] as? Double ?? 0.0,
                        quantity: data["quantity"] as? Int ?? 0,
                        img: data["img"] as? String ?? ""
                    )
                }
            }
        }
    }
    
    func getCurrentUserID() -> String? {
        return Auth.auth().currentUser?.uid
    }
    
    
}


#Preview {
    MyCartView()
}
