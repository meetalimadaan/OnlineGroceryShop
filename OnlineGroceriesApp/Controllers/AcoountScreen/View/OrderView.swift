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
                    Image(systemName: "chevron.left")
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                        .foregroundColor(.primaryApp)
                }
                
                Text("Your Orders")
                    .font(.customfont(.bold, fontSize: 20))
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                
                Button(action: {
                    print("Button tapped")
                    showModal.toggle()
                }) {
                    Image(systemName: "slider.horizontal.3")
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.primaryApp)
                        .padding()
                }
                .sheet(isPresented: $showModal) {
                    FilterView(selectedStatus: $viewModel.selectedStatus)
                        .presentationDetents([.height(550)])
                }
            }
            
            Spacer()
            
            if viewModel.filteredOrders.isEmpty {
                GeometryReader { geometry in
                    Text("No orders found")
                        .font(.customfont(.bold, fontSize: 18))
                        .foregroundColor(.secondaryText)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                        .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                }
                .frame(maxHeight: .infinity) // Ensure the GeometryReader takes all available height
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

