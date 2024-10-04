//
//  SelectLocationView.swift
//  OnlineGroceriesApp
//
//  Created by Prince on 26/07/24.
//

import SwiftUI
import CoreLocation
import GooglePlaces

struct SelectLocationView: View {
    @StateObject private var viewModel = SelectLocationViewModel()
    @ObservedObject var viewModal1 = CheckOutViewModel()
    @EnvironmentObject var homeVM: HomeViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var showError: Bool = false
    @State private var isAutocompletePresented: Bool = false
    @State private var query: String = ""
    @State private var predictions: [GMSAutocompletePrediction] = []
    @State private var placesClient = GMSPlacesClient.shared()
    
    var body: some View {
        Text("Add New Address") // <-- New label added here
                               .font(.customfont(.semibold, fontSize: 20)) // Adjust font as needed
                               .foregroundColor(.primaryText)
                               .padding(.top, 20) // Add some padding at the top
        ScrollView {
            
            ZStack {
                VStack {
                    
                    Image("map")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .padding(.top, 10)
                    
                    

                    SearchTextField(placeholder: "Search Location...", txt: $query)
                        .onChange(of: query) { newValue in
                            fetchAutocompletePredictions(for: newValue)
                        }
                        .padding(.top, 10)
                        .padding(.horizontal, 15)
                    
                    if query.isEmpty {
                        
                        Button(action: {
                            viewModel.requestLocation()
                        }) {
                            if viewModel.isLoading {
                                HStack(spacing: 8) {
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle(tint: .primaryApp))
                                    Text("Fetching Location...")
                                        .font(.customfont(.semibold, fontSize: 16))
                                        .foregroundColor(Color.primaryApp)
                                }
                            } else {
                                HStack(spacing:15){
                                    Image(systemName: "mappin.and.ellipse")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(.green)
                                  
                                    Text("Go to Current Location")
                                        .font(.customfont(.semibold, fontSize: 16))
                                        .foregroundColor(Color.primaryApp)
                                }
                               
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading) // Make the button full width
                                                  .padding()
                                                  .background(Color.white) // Background color to match SearchTextField
                                                  .cornerRadius(8)
                                                  .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                                                  .padding(.top, 10) // Padding above the button
                                                  .padding(.horizontal, 15) // Ensure horizontal padding
                        
                        //
                    } else {
                        
                        if !predictions.isEmpty {
                            ScrollView {
                                VStack(spacing: 0) {
                                    ForEach(predictions, id: \.placeID) { prediction in
                                        Button(action: {
                                            selectPrediction(prediction)
                                        }) {
                                            Text(prediction.attributedPrimaryText.string)
                                                .font(.customfont(.regular, fontSize: 16))
                                                .foregroundColor(.primaryText)
                                                .padding()
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .background(Color.white)
                                                .cornerRadius(8)
                                                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                                        }
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 5)
                                        
                                        //
                                    }
                                }
                                .padding(.top, 10)
                            }
                            .frame(height: 200)
                        }
                        
                        
                    }
                    
                    // Display the fetched address
                    if let address = viewModel.address {
                        Text("\(address.city) \(address.state) \(address.country) \(address.zipCode)")
                            .font(.customfont(.semibold, fontSize: 16))
                            .foregroundColor(.primaryText)
                            .padding(.top, 10)
                    }
                    
                    if showError {
                        Text("Please Add New Address.")
                            .foregroundColor(.red)
                            .font(.customfont(.semibold, fontSize: 14))
                            .padding(.bottom, 10)
                    }
                    
                    HStack(alignment: .center) {
                        Image(systemName: viewModel.isDefaultLocationChecked ? "checkmark.square.fill" : "square")
                            .foregroundColor(viewModel.isDefaultLocationChecked ? .primaryApp : .gray)
                            .onTapGesture {
                                viewModel.isDefaultLocationChecked.toggle()
                            }
                        
                        Text("Set My Default Location")
                            .font(.customfont(.semibold, fontSize: 16))
                            .foregroundColor(.primaryText)
                        
                        Spacer()
                    }
                    .padding(.leading, 25)
                    .padding(.bottom, 10)
                    .padding(.top, 10)
                    
                    Button(action: {
                        
                        if viewModel.address?.isValid() == true {
                            viewModel.saveAddress()
                            presentationMode.wrappedValue.dismiss()
                        } else {
                            showError = true
                        }
                    }) {
                        Text("Save")
                            .font(.customfont(.semibold, fontSize: 16))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.primaryApp)
                            .cornerRadius(8)
                    }
                    .disabled(viewModel.address == nil)
                    .padding(.bottom, 30)
                    
                    Spacer()
                }
                .padding(.horizontal, 25)
            }
            .onAppear {
                viewModel.fetchUsername()
                viewModel.address = Address()
            }
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
        }
    }
    
    
    
    
    func fetchAutocompletePredictions(for query: String) {
        let filter = GMSAutocompleteFilter()
        filter.type = .address
        
        let token = GMSAutocompleteSessionToken.init()
        placesClient.findAutocompletePredictions(fromQuery: query, filter: filter, sessionToken: token) { (results, error) in
            if let error = error {
                print("Error fetching predictions: \(error)")
                return
            }
            
            if let results = results {
                self.predictions = results
            }
        }
    }
    
    
    func selectPrediction(_ prediction: GMSAutocompletePrediction) {
        let placeID = prediction.placeID
        
        placesClient.fetchPlace(fromPlaceID: placeID, placeFields: [.name, .coordinate, .addressComponents], sessionToken: nil) { (place, error) in
            if let error = error {
                print("Error fetching place details: \(error)")
                return
            }
            
            if let place = place {
                
                let city = place.addressComponents?.first(where: { $0.types.contains("locality") })?.name ?? ""
                let country = place.addressComponents?.first(where: { $0.types.contains("country") })?.name ?? ""
                let zipCode = place.addressComponents?.first(where: { $0.types.contains("postal_code") })?.name ?? ""
                
                viewModel.address = Address(city: city, state: "", country: country, zipCode: zipCode)
            }
        }
    }
}

struct AutocompleteView: UIViewControllerRepresentable {
    var onSelectPlace: (GMSPlace) -> Void
    
    func makeCoordinator() -> Coordinator {
        Coordinator(onSelectPlace: onSelectPlace)
    }
    
    func makeUIViewController(context: Context) -> GMSAutocompleteViewController {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = context.coordinator
        autocompleteController.placeFields = [.name, .placeID]
        
        
        let filter = GMSAutocompleteFilter()
        filter.type = .city
        autocompleteController.autocompleteFilter = filter
        
        return autocompleteController
    }
    
    func updateUIViewController(_ uiViewController: GMSAutocompleteViewController, context: Context) {}
    
    class Coordinator: NSObject, GMSAutocompleteViewControllerDelegate {
        var onSelectPlace: (GMSPlace) -> Void
        
        init(onSelectPlace: @escaping (GMSPlace) -> Void) {
            self.onSelectPlace = onSelectPlace
        }
        
        func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
            onSelectPlace(place)
            viewController.dismiss(animated: true, completion: nil)
        }
        
        func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
            print("Error: ", error.localizedDescription)
            viewController.dismiss(animated: true, completion: nil)
        }
        
        func wasCancelled(_ viewController: GMSAutocompleteViewController) {
            viewController.dismiss(animated: true, completion: nil)
        }
    }
}

extension Address {
    func isValid() -> Bool {
        // Check if all required fields are filled
        return !city.isEmpty || !country.isEmpty || !zipCode.isEmpty
    }
}
