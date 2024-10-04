import SwiftUI

struct DeliveryAddresss: View {
    @ObservedObject var viewModel = CheckOutViewModel()
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            // Header with back button and title
            HStack {
                Button {
                    mode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                }
                Spacer()
                
                Text("Saved Addresses")
                    .font(.customfont(.bold, fontSize: 20))
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                Spacer()
            }
            .padding(.horizontal)

            Spacer()

            if viewModel.addresses.isEmpty {
                Text("No Address")
                    .font(.customfont(.bold, fontSize: 18))
                    .foregroundColor(.secondaryText)
                    .padding(.top, .topInsets + 46)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            } else {
                // Use ScrollView + VStack instead of List
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(viewModel.addresses) { address in
                            AddressRow11(address: address, toggleDefaultAction: {
                                viewModel.toggleDefaultStatus(for: address)
                            })
                            .padding()
                            .background(Color(.white))
                            .cornerRadius(8)
                            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                        }
                    }
                    .padding(.top, 20)
                    .padding(.horizontal)
                }
            }
        }
        .navigationBarHidden(true)
    }
}

struct AddressRow11: View {
    let address: Address
    let toggleDefaultAction: () -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(address.city), \(address.country)")
//                Text("\(address.country)")
            }
            Spacer()
//            if address.isDefault {
//                Image(systemName: "checkmark")
//                    .foregroundColor(.green)
//            }
//            Button(action: {
//                toggleDefaultAction() // Call the toggle action when button is pressed
//            }) {
//                Text(address.isDefault ? "Default" : "Make Default")
//                    .foregroundColor(.blue)
//            }
        }
    }
}

//#Preview {
//    DeliveryAddresses()
//}
