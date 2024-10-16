//
//  FilterView.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 05/09/24.
//

import SwiftUI

struct FilterView: View {
    @Binding var selectedStatus: String
    @Environment(\.dismiss) var dismiss
    let statuses = ["All", "Pending", "Shipped", "Delivered"]
    @State private var temporaryStatus: String
    
    init(selectedStatus: Binding<String>) {
        self._selectedStatus = selectedStatus
        self._temporaryStatus = State(initialValue: selectedStatus.wrappedValue)
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("Select Filter")
                    .font(.headline)
                    .padding(.top, 20)
                    .padding(.bottom, 10)
                
                LazyVStack {
                    ForEach(statuses, id: \.self) { status in
                        FilterRow(status: status, isSelected: status == temporaryStatus) {
                            temporaryStatus = status
                        }
                        Divider()
                    }
                }
                .frame(maxHeight: geometry.size.height * 0.6)
                
                Spacer()
                
               
                Button(action: {
                    selectedStatus = temporaryStatus
                    dismiss()
                }) {
                    Text("Apply Filter")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.primaryApp)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .padding(.bottom, geometry.safeAreaInsets.bottom + 20) 
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
        }
    }
}
