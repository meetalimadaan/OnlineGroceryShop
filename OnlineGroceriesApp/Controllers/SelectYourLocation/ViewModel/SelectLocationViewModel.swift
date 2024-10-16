//
//  SelectLocationViewModel.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 23/08/24.
//

import Foundation
import CoreLocation
import Firebase
import FirebaseFirestore
import FirebaseAuth

class SelectLocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var username: String = ""
    @Published var city: String = ""
       @Published var state: String = ""
       @Published var country: String = ""
       @Published var zipCode: String = ""
    @Published var flatHouseNo: String = ""
    @Published var village: String = ""
    
    @Published var address: Address?
    @Published var isDefaultLocationChecked = false
    @Published var isLoading: Bool = false
    
    @Published var alertMessage: String = ""

    private let locationManager = CLLocationManager()
    private var db = Firestore.firestore()

    override init() {
        super.init()
        locationManager.delegate = self
    }

    func fetchUsername() {
        guard let userID = Auth.auth().currentUser?.uid else {
            print("User not logged in")
            return
        }

        db.collection("users").document(userID).getDocument { [weak self] (document, error) in
            if let error = error {
                print("Error fetching document: \(error)")
                return
            }

            if let document = document, document.exists {
                let data = document.data()
                self?.username = data?["username"] as? String ?? "Unknown User"
            } else {
                print("Document does not exist")
            }
        }
    }

    func requestLocation() {
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            isLoading = true
            locationManager.requestLocation()
        } else {
            alertMessage = "Location services are not enabled."
           
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            isLoading = false
            return
        }
        fetchAddress(from: location)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get location: \(error.localizedDescription)")
    }

    private func fetchAddress(from location: CLLocation) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            guard let self = self else { return }
            self.isLoading = false
            
            if let error = error {
                self.alertMessage = "Failed to retrieve address: \(error.localizedDescription)"
                return
            }
            
            guard let placemark = placemarks?.first else {
                self.alertMessage = "No address found."
                return
            }
            
            let timestamp = Date()
            
            
            let area = placemark.locality ?? "N/A"
            let street = placemark.thoroughfare ?? "N/A"
            let sector = placemark.subThoroughfare ?? "N/A"
            let village = placemark.name ?? "N/A"
       
         
            self.address = Address(
                city: area,
                state: placemark.administrativeArea ?? "N/A",
                country: placemark.country ?? "N/A",
                zipCode: placemark.postalCode ?? "N/A",
                street: street,
                sector: sector,
                village: village,
                flatHouseNo: self.flatHouseNo,
                isDefault: self.isDefaultLocationChecked,
                timestamp: timestamp
            )

         
//       

            print("Fetched Address:")
                  print("Flat/House No: \(self.address?.flatHouseNo ?? "N/A")")
//            self.saveAddress()
        }
    }


    func saveAddress() {
        guard let userID = Auth.auth().currentUser?.uid else {
            print("User not logged in")
            return
        }

        
        guard var address = address else {
            print("No address to save")
            return
        }

       
        address.isDefault = isDefaultLocationChecked
        address.timestamp = Date()

      
        print("Flat/House No. before saving: \(flatHouseNo)")

    
        address.flatHouseNo = flatHouseNo

        
        let addressData: [String: Any] = [
            "city": address.city,
            "state": address.state,
            "country": address.country,
            "zipCode": address.zipCode,
            "street": address.street ?? "",
            "sector": address.sector ?? "",
            "village": address.village ?? "",
            "flatHouseNo": address.flatHouseNo ?? "",
            "isDefault": address.isDefault,
            "timestamp": address.timestamp
        ]

      
        let userDocRef = db.collection("userAddress").document(userID)

        userDocRef.getDocument { [weak self] (document, error) in
            if let error = error {
                print("Error fetching document: \(error)")
                return
            }

            var addresses = [addressData]

           
            if let document = document, document.exists, let data = document.data(), let existingAddresses = data["addresses"] as? [[String: Any]] {
                if address.isDefault {
                   
                    for var existingAddress in existingAddresses {
                        var mutableAddress = existingAddress
                        mutableAddress["isDefault"] = false
                        addresses.append(mutableAddress)
                    }
                } else {
                 
                    addresses.append(contentsOf: existingAddresses)
                }
            }

        
            userDocRef.setData(["addresses": addresses], merge: true) { error in
                if let error = error {
                    print("Error saving address: \(error)")
                } else {
                    print("Address successfully saved with default status: \(address.isDefault)")
                    print("Flat: \(address.flatHouseNo ?? "")")
                   
                    NotificationCenter.default.post(name: Notification.Name("AddressUpdated"), object: nil)
                }
            }
        }
    }



}


//    jdffgfidfg
  


struct Address: Identifiable {
    var id: String
    var city: String = ""
    var state: String = ""
    var country: String = ""
    var zipCode: String = ""
    var street: String = ""
    var sector: String = ""
    var village: String = ""
    var flatHouseNo: String = ""
    var isDefault: Bool = false
    var timestamp: Date?

    init(id: String = UUID().uuidString, city: String = "", state: String = "", country: String = "", zipCode: String = "", street: String = "", sector: String = "", village: String = "",flatHouseNo: String = "", isDefault: Bool = false, timestamp: Date? = nil) {
        self.id = id
        self.city = city
        self.state = state
        self.country = country
        self.zipCode = zipCode
        self.street = street
        self.sector = sector
        self.village = village
        self.flatHouseNo = flatHouseNo
        self.isDefault = isDefault
        self.timestamp = timestamp
    }
}


