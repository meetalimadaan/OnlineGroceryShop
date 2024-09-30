import SwiftUI

struct CheckOut: View {
    @ObservedObject var viewModel = CheckOutViewModel()
    
    @Environment(\.presentationMode) var presentationMode
    @State private var navigateToOrderAccepted = false
    @State private var showAddressErrorMessage = false
    var body: some View {
        VStack {
            
            HStack {
                Spacer()
                Text("CheckOut")
                    .font(.customfont(.bold, fontSize: 20))
                    .frame(height: 46)
                Spacer()
            }
            .padding(.top, .topInsets)
            .background(Color.white)
            .shadow(color: Color.black.opacity(0.2), radius: 2)
            
            Spacer()
            
            
            if viewModel.addresses.isEmpty {
                Text("Please add an address")
                    .font(.customfont(.regular, fontSize: 18))
                    .foregroundColor(.gray)
                    .padding(.top, 20)
            } else {
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(viewModel.addresses.indices, id: \.self) { index in
                            AddressRow(address: viewModel.addresses[index],
                                       isDefault: $viewModel.addresses[index].isDefault,
                                       toggleDefaultStatus: {
                                viewModel.toggleDefaultStatus(for: viewModel.addresses[index])
                            })
                        }
                        
                    }
                    .padding(.top, 10)
                }
            }
            
            Spacer()
            
            // "Add New Address" button
            NavigationLink(destination: SelectLocationView(viewModal1: viewModel).navigationBarBackButtonHidden(true)) {
                Text("Add New Address")
                    .font(.customfont(.semibold, fontSize: 22))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60)
                    .contentShape(Rectangle())
                    .background(Color.primaryApp)
                    .cornerRadius(20)
                    .buttonStyle(PlainButtonStyle())
                    .padding(.horizontal, 20)
            }
            .navigationBarBackButtonHidden(true)
            .padding(.bottom, 10)
            
            
            
            if showAddressErrorMessage {
                Text("Please select an address before placing your order")
                    .foregroundColor(.red)
                    .font(.caption)
            }
            
            
            if !viewModel.addresses.isEmpty {
                Button(action: {
                    if viewModel.selectedAddress == nil {
                        
                        showAddressErrorMessage = true
                    } else {
                        
                        viewModel.addOrder()
                        navigateToOrderAccepted = true
                    }
                }) {
                    Text("Confirm & Place Order")
                        .font(.customfont(.semibold, fontSize: 22))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60)
                        .contentShape(Rectangle())
                        .background(viewModel.selectedAddress != nil ? Color.primaryApp : Color.gray)
                        .cornerRadius(20)
                        .buttonStyle(PlainButtonStyle())
                }
                .padding(.horizontal, 20)
                .background(
                    NavigationLink(destination: OrderAcceptedView(), isActive: $navigateToOrderAccepted) {
                        EmptyView()
                    }
                )
            }
        }
        .padding(.bottom, .bottomInsets + 80)
        .onAppear {
            NotificationCenter.default.addObserver(forName: Notification.Name("AddressUpdated"), object: nil, queue: .main) { _ in
                viewModel.fetchSavedAddresses()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.backward")
                    Text("Back")
                }
            }
        }
        .ignoresSafeArea()
    }
}

// Preview code
struct CheckOut_Previews: PreviewProvider {
    static var previews: some View {
        CheckOut()
    }
}
