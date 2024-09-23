//
//  FilterProductsView.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 02/09/24.
//

import SwiftUI

struct FilterProductsView: View {
   
    @Binding var selectedStatus: String
    @Environment(\.dismiss) var dismiss
    let statuses = ["Price: Low to High", "Price: High to Low"] 
    @State private var temporaryStatus: String
    
    init(selectedStatus: Binding<String>) {
        self._selectedStatus = selectedStatus
        self._temporaryStatus = State(initialValue: selectedStatus.wrappedValue)
    }
    
    var body: some View {
      
                    VStack {
                        
                            
                        Text("Select Filter")
                                        .font(.headline)
                                        .padding(.top, 20)
                                        .padding(.bottom, 10)
                        
                          
                        ScrollView {
                            LazyVStack {
                                ForEach(statuses, id: \.self) { status in
                                    FilterRow(status: status, isSelected: status == temporaryStatus) {
                                        temporaryStatus = status
                                    }
                                    Divider()
                                }
                            }
                        }
                        .frame(maxHeight: 200)
                        
                        Button(action: {
                            selectedStatus = temporaryStatus
                            dismiss()
                        }) {
                            Text("Apply Filter")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .padding(.horizontal)
                        }
                        Spacer()
                    }
                }
            }
