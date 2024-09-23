//
//  OrderView.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 28/08/24.
//
import SwiftUI

struct OrderView: View {
    @ObservedObject var viewModel = OrderViewModel()
    @State private var showModal = false
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
      
            VStack {
                HStack {
                    Spacer()
                    Button {
                        mode.wrappedValue.dismiss()
                    } label: {
                        Image("back arrow")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                    }
                    
                    Text("Your Orders")
                        .font(.customfont(.bold, fontSize: 20))
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                    
                    Button(action: {
                        print("Button tapped")
                        showModal.toggle()
                        
                    }) {
                        Image("Group 6839")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .padding()
                    }
                    .sheet(isPresented: $showModal) {
                        
                        FilterView(selectedStatus: $viewModel.selectedStatus)
                            .presentationDetents([.height(300)])
                    }
                }
                
                
                Spacer()
             
                if viewModel.filteredOrders.isEmpty {
                               Text("No orders found")
                                   .font(.headline)
                                   .foregroundColor(.gray)
                                   .padding()
                           } else {
                               ScrollView {
                                   LazyVStack {
                                       ForEach(viewModel.filteredOrders) { order in
                                           NavigationLink(destination: OrderSummaryView(order: order)) {
                                               OrderRow(order: order)
                                           }
                                       }
                                   }
                                   .padding()
                               }
                           }
                           
                 Spacer()
            }
            
            .navigationBarHidden(true)
       
        .onAppear {
            viewModel.fetchUserOrders()
        }
        .onChange(of: viewModel.selectedStatus, perform: { _ in
            viewModel.applyFilter()
        })
    }
}


extension DateFormatter {
    static let shortDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
}

// Preview code
struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView()
    }
}

