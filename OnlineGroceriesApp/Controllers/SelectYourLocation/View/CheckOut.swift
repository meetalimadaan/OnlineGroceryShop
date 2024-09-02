import SwiftUI

struct CheckOut: View {
    @ObservedObject var viewModel = CheckOutViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State private var navigateToOrderAccepted = false
    var body: some View {
        //        NavigationView {
        VStack {
            // Header
            HStack {
                Spacer()
                Text("Delivery Addresess")
                    .font(.customfont(.bold, fontSize: 20))
                    .frame(height: 46)
                Spacer()
            }
            .padding(.top, .topInsets)
            .background(Color.white)
            .shadow(color: Color.black.opacity(0.2), radius: 2)
            
            Spacer()
            
            
            // List of addresses
            List {
                ForEach(viewModel.addresses) { address in
                    HStack {
                        VStack(alignment: .leading) {
                            Text("\(address.city), \(address.state)")
                            Text("\(address.country) - \(address.zipCode)")
                        }
                        Spacer()
                        if address.isDefault {
                            Image(systemName: "checkmark")
                                .foregroundColor(.green)
                        }
                        Button(action: {
                            viewModel.toggleDefaultStatus(for: address)
                        }) {
                            Text(address.isDefault ? "" : "")
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            Spacer()
            
            // "Add New Address" button
            NavigationLink(destination: SelectLocationView().navigationBarBackButtonHidden(true)) {
                
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
            
            // "Confirm & Place Order" button
            Button(action: {
                viewModel.addOrder()
                navigateToOrderAccepted = true
            }) {
                Text("Confirm & Place Order")
                    .font(.customfont(.semibold, fontSize: 22))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60)
                    .contentShape(Rectangle())
                    .background(Color.primaryApp)
                    .cornerRadius(20)
                    .buttonStyle(PlainButtonStyle())
            }
            .padding(.bottom, .bottomInsets + 80)
            .padding(.horizontal, 20)
            .background(
                NavigationLink(destination: OrderView(), isActive: $navigateToOrderAccepted) {
                    EmptyView()
                }
            )
        }
        .onAppear {
            viewModel.fetchSavedAddresses()
        }
        
        
        .navigationBarTitleDisplayMode(.inline)
        //            .navigationBarBackButtonHidden(true)
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