//
//  OrderView.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 28/08/24.
//
import SwiftUI

struct OrderView: View {
    @ObservedObject var viewModel = OrderViewModel()

    var body: some View {
        VStack {
            // Header
            HStack {
                Spacer()
                Text("Your Orders")
                    .font(.customfont(.bold, fontSize: 20))
                    .frame(height: 46)
                Spacer()
            }
            .padding(.top, .topInsets)
            .background(Color.white)
            .shadow(color: Color.black.opacity(0.2), radius: 2)
            
//            Spacer()
         
            // Order Status Filter Picker
                      Picker("Order Status", selection: $viewModel.selectedStatus) {
                          Text("All").tag("All")
                          Text("Pending").tag("Pending")
                          Text("Shipped").tag("Shipped")
                          Text("Delivered").tag("Delivered")
                      }
                      .pickerStyle(SegmentedPickerStyle())
                      .padding()

                      Spacer()

                      if viewModel.filteredOrders.isEmpty {
                          Text("No orders found")
                              .font(.headline)
                              .foregroundColor(.gray)
                              .padding()
                      } else {
                          List(viewModel.filteredOrders) { order in
                              VStack(alignment: .leading) {
                                  Text("Order ID: \(order.id)")
                                  Text("Status: \(order.status)")
                                  Text("Date: \(order.orderDate, formatter: DateFormatter.shortDate)")
                                  Text("Total Price: $\(order.totalPrice, specifier: "%.2f")")
                              }
                              .padding()
                          }
                          .listStyle(InsetGroupedListStyle())
                      }

                      Spacer()
                  }
                  .background(Color(.systemGray6))
                  .edgesIgnoringSafeArea(.top)
                  .onAppear {
                      viewModel.fetchUserOrders()
                  }
                  .onChange(of: viewModel.selectedStatus, perform: { _ in
                      viewModel.applyFilter()
                  })
              }
          }
// DateFormatter extension for formatting dates
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
