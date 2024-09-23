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

class SelectLocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var username: String = ""
    @Published var city: String = ""
       @Published var state: String = ""
       @Published var country: String = ""
       @Published var zipCode: String = ""
    @Published var address: Address?
    @Published var isDefaultLocationChecked = false

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
        locationManager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        fetchAddress(from: location)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get location: \(error.localizedDescription)")
    }

    private func fetchAddress(from location: CLLocation) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            guard let self = self, let placemark = placemarks?.first else { return }
            let timestamp = Date()
            self.address = Address(
                city: placemark.locality ?? "N/A",
                state: placemark.administrativeArea ?? "N/A",
                country: placemark.country ?? "N/A",
                zipCode: placemark.postalCode ?? "N/A",
                isDefault: self.isDefaultLocationChecked,
                timestamp: timestamp
            )
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

        let addressData: [String: Any] = [
            "city": address.city,
            "state": address.state,
            "country": address.country,
            "zipCode": address.zipCode,
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
                    
                    
                    NotificationCenter.default.post(name: Notification.Name("AddressUpdated"), object: nil) // Notify that address has been saved
                }
            }
        }
    }


}


//    jdffgfidfg
  


struct Address: Identifiable {
    var id: String 
    var city: String
    var state: String
    var country: String
    var zipCode: String
    var isDefault: Bool
    var timestamp: Date?

    init(id: String = UUID().uuidString, city: String, state: String, country: String, zipCode: String, isDefault: Bool, timestamp: Date? = nil) {
        self.id = id
        self.city = city
        self.state = state
        self.country = country
        self.zipCode = zipCode
        self.isDefault = isDefault
        self.timestamp = timestamp
    }
}
