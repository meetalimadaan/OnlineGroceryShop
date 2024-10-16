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
    @State var isPresentedFromCheckOut: Bool = false
    @State private var flatHouseNo: String = ""
    
    var body: some View {
        
//                Text("Add New Address")
//                    .font(.customfont(.semibold, fontSize: 20))
//                    .foregroundColor(.primaryText)
//                    .padding(.top, 20)
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
                       
                    
                    //                        .padding(.horizontal, 15)
                    
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
                                    
                                    Text("Use My Current Location")
                                        .font(.customfont(.semibold, fontSize: 16))
                                        .foregroundColor(Color.primaryApp)
                                }
                                
                            }
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 10, maxHeight: 10, alignment: .leading)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                        .padding(.top, 10)
                        .padding(.bottom, 10)
                        //                        .padding(.horizontal, 15)
                        
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
                                //                                .padding(.bottom, 30)
                            }
                            .frame(height: 200)
                        }
                        
                        
                    }
                    
                    if let address = viewModel.address {
                        VStack(alignment: .leading, spacing: 15) {
                            
                            VStack(alignment: .leading) {
                                Text("Flat")
                                    .font(.customfont(.semibold, fontSize: 16))
                                    .foregroundColor(.gray)
                                TextField("Flat/House No.", text: $viewModel.flatHouseNo)
                                    .font(.customfont(.regular, fontSize: 16))
                                    .foregroundColor(.primaryText)
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 10)
                                    .background(Color.clear)
                                    .overlay(RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.black, lineWidth: 1))
                                    .frame(height: 40)
                                    .onChange(of: viewModel.flatHouseNo) { newValue in
                                        print("User input: \(newValue)")
                                    }
                            }
                        
                            
                         
                            VStack(alignment: .leading) {
                                Text("Area/Village Street:")
                                    .font(.customfont(.semibold, fontSize: 16))
                                    .foregroundColor(.gray)
                                TextField("Enter Area/Village Street", text: .constant(address.village))
                                    .font(.customfont(.regular, fontSize: 16))
                                    .foregroundColor(.primaryText)
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 10)
                                    .background(Color.clear)
                                    .overlay(RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.black, lineWidth: 1))
                                    .frame(height: 40)
                            }
                            
                            
                         
                            HStack {
                             
                                VStack(alignment: .leading) {
                                    Text("Pincode:")
                                        .font(.customfont(.semibold, fontSize: 16))
                                        .foregroundColor(.gray)
                                    TextField("Enter Pincode", text: .constant(address.zipCode))
                                        .font(.customfont(.regular, fontSize: 16))
                                        .foregroundColor(.primaryText)
                                        .padding(.vertical, 8)
                                        .padding(.horizontal, 10)
                                        .background(Color.clear)
                                        .overlay(RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.black, lineWidth: 1))
                                        .frame(height: 40)
                                }
                                .frame(maxWidth: .infinity)
                                
                                
                                VStack(alignment: .leading) {
                                    Text("City:")
                                        .font(.customfont(.semibold, fontSize: 16))
                                        .foregroundColor(.gray)
                                    TextField("Enter City", text: .constant(address.city))
                                        .font(.customfont(.regular, fontSize: 16))
                                        .foregroundColor(.primaryText)
                                        .padding(.vertical, 8)
                                        .padding(.horizontal, 10)
                                        .background(Color.clear)
                                        .overlay(RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.black, lineWidth: 1))
                                        .frame(height: 40)
                                }
                                .frame(maxWidth: .infinity)
                            }
                            
                         
                            VStack(alignment: .leading) {
                                Text("State:")
                                    .font(.customfont(.semibold, fontSize: 16))
                                    .foregroundColor(.gray)
                                TextField("Enter State", text: .constant(address.state))
                                    .font(.customfont(.regular, fontSize: 16))
                                    .foregroundColor(.primaryText)
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 10)
                                    .background(Color.clear)
                                    .overlay(RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.black, lineWidth: 1))
                                    .frame(height: 40)
                            }
                          
                            VStack(alignment: .leading) {
                                Text("Country:")
                                    .font(.customfont(.semibold, fontSize: 16))
                                    .foregroundColor(.gray)
                                TextField("Enter State", text: .constant(address.country))
                                    .font(.customfont(.regular, fontSize: 16))
                                    .foregroundColor(.primaryText)
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 10)
                                    .background(Color.clear)
                                    .overlay(RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.black, lineWidth: 1))
                                    .frame(height: 40)
                            }
                            //
                        }
                        //                        .padding(.horizontal, 25) // Adjust padding around the VStack
                        .padding(.top, 15)
                        .padding(.bottom, 15)
                        .background(Color.white)
                        .cornerRadius(8)
                        //                        .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 1)
                    }
                    
                    
                    if showError {
                        Text("Please Add New Address.")
                            .foregroundColor(.red)
                            .font(.customfont(.semibold, fontSize: 14))
                            .padding(.bottom, 10)
                    }
                    Divider()
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
                    .padding(.leading, 5)
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
                        Text("Use this address")
                            .font(.customfont(.semibold, fontSize: 20))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
//                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 40, maxHeight: 40)
                            .background(Color.primaryApp)
                            .cornerRadius(8)
                    }
                    .disabled(viewModel.address == nil)
                    .padding(.bottom, 20)
                    
                  
                }
                .padding(.horizontal, 25)
            }
            .navigationBarBackButtonHidden(!isPresentedFromCheckOut)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    if isPresentedFromCheckOut {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "chevron.backward")
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .foregroundColor(Color.primaryApp)
                            
                        }
                    }
                }
                ToolbarItem(placement: .principal) {
                                Text("Select Location")
                        .font(.customfont(.bold, fontSize: 20))
                                   
                                    .frame(maxWidth: .infinity, alignment: .center)
                            }
            }
            
            
            .onAppear {
                viewModel.fetchUsername()
                viewModel.address = Address()
                isPresentedFromCheckOut = true
            }
            
            //            .toolbar {
            //                ToolbarItem(placement: .navigationBarLeading) {
            //                    Button(action: {
            //                        presentationMode.wrappedValue.dismiss()
            //                    }) {
            //                        Image(systemName: "chevron.backward")
            //                        Text("Back")
            //                    }
            //                }
            //            }
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
                // Extract address components
                var city = ""
                var state = ""
                var country = ""
                var zipCode = ""
                var area = ""
                var village = ""
                
          
                if let components = place.addressComponents {
                    for component in components {
                        if component.types.contains("locality") {
                            city = component.name
                        }
                        if component.types.contains("administrative_area_level_1") {
                            state = component.name
                        }
                        if component.types.contains("country") {
                            country = component.name
                        }
                        if component.types.contains("postal_code") {
                            zipCode = component.name
                        }
                        if component.types.contains("sublocality") || component.types.contains("neighborhood") {
                                                   village = component.name
                                               }
                                               if component.types.contains("route") || component.types.contains("street_address") {
                                                   area = component.name
                                               }
                    }
                }
                
              
                viewModel.address = Address(city: city, state: state, country: country, zipCode: zipCode, village: village)
                               query = place.name ?? ""
                               predictions.removeAll()
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
            autocompleteController.placeFields = [.name, .placeID, .addressComponents]
                    
            
            
            let filter = GMSAutocompleteFilter()
            filter.type = .noFilter
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
}
extension Address {
    func isValid() -> Bool {
        
        return !city.isEmpty || !country.isEmpty || !zipCode.isEmpty
    }
}
