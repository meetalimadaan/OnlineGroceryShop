import SwiftUI

struct CheckOut: View {
    @ObservedObject var viewModel = CheckOutViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                // Header
                HStack {
                    Spacer()
                    Text("Select a Location")
                        .font(.customfont(.bold, fontSize: 20))
                        .frame(height: 46)
                    Spacer()
                }
                .padding(.top, .topInsets)
                .background(Color.white)
                .shadow(color: Color.black.opacity(0.2), radius: 2)
                
               
                Spacer()
               
                NavigationLink(destination: SelectLocationView()) {
                    Text("Add New Address")
                        .font(.customfont(.semibold, fontSize: 18))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60)
                        .contentShape(Rectangle())
                        .background(Color.primary)
                        .cornerRadius(20)
                        .buttonStyle(PlainButtonStyle())
                        .padding(.horizontal, 20)
                    
                }
                .padding(.bottom, 10)
                
                // List of saved addresses
                if !viewModel.savedAddresses.isEmpty {
                    ScrollView {
                        VStack(alignment: .center) {
                            Text("SAVED ADDRESSES:")
                                .font(.headline)
                                .padding(.bottom, 4)
                            
                            ForEach($viewModel.savedAddresses, id: \.id) { $address in
                                HStack {
                                    Image(systemName: address.isChecked ? "checkmark.square.fill" : "square")
                                        .foregroundColor(address.isChecked ? .green : .gray)
                                        .onTapGesture {
                                            address.isChecked.toggle()
                                            print("Address \(address.city) isChecked: \(address.isChecked)")
                                        }
                                    VStack(alignment: .leading) {
                                        Text("City: \(address.city)")
                                        Text("State: \(address.state)")
                                        Text("Country: \(address.country)")
                                        Text("Zip Code: \(address.zipCode)")
                                        Divider()
                                    }
                                }
                                .padding(.vertical, 8)
                            }
                        }
                        .padding()
                    }
                } else {
                    Text("No addresses saved.")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .padding()
                }

                Spacer()
                
                // "Confirm & Placed Order" button
                NavigationLink(destination: OrderAcceptedView()) {
                    Text("Confirm & Placed Order")
                        .font(.customfont(.semibold, fontSize: 18))
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
            }
            .onAppear {
                viewModel.fetchSavedAddresses()
            }
            .navigationTitle("")
//            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
            .ignoresSafeArea()
        }
    }
}

// Preview code
struct CheckOut_Previews: PreviewProvider {
    static var previews: some View {
        CheckOut()
    }
}
