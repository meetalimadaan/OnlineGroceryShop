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
                        .foregroundColor(.primaryApp)
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
                GeometryReader { geometry in
                    Text("No Address")
                        .font(.customfont(.bold, fontSize: 18))
                        .foregroundColor(.secondaryText)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                        .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                }
                .frame(maxHeight: .infinity)
            } else {
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(viewModel.addresses) { address in
                            AddressRow11(address: address, isSelected: viewModel.selectedAddress?.id == address.id) {
                                viewModel.selectedAddress = address
                                viewModel.toggleDefaultStatus(for: address)
                            }
                            .padding()
                            .background(Color(.white))
                            .cornerRadius(8)
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 3)
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
    let isSelected: Bool
    let toggleDefaultAction: () -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                
                Text(address.flatHouseNo)
                                .font(.headline)
                                .foregroundColor(.black)
                            Text(address.village)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Text("\(address.city), \(address.state), \(address.zipCode)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Text(address.country)
                                .font(.subheadline)
                                .foregroundColor(.gray)
            }
            Spacer()
            // Checkmark icon
            if isSelected {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.primaryApp)
            }
        }
        .contentShape(Rectangle()) // Make the entire row tappable
        .onTapGesture {
            toggleDefaultAction()
        }
    }
}
//#Preview {
//    DeliveryAddresses()
//}
