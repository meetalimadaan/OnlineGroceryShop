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
    @Published var address: Address?
    @Published var isDefaultLocationChecked = false // Track if the location should be default

    private let locationManager = CLLocationManager()
    private var db = Firestore.firestore()

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
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
            // Here is where we set the default status based on isDefaultLocationChecked
            self.address = Address(
                city: placemark.locality ?? "N/A",
                state: placemark.administrativeArea ?? "N/A",
                country: placemark.country ?? "N/A",
                zipCode: placemark.postalCode ?? "N/A",
                isDefault: self.isDefaultLocationChecked // This should reflect the checked status
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

        // Log the current state of isDefaultLocationChecked
        print("Saving address with default status: \(isDefaultLocationChecked)")

        // Update the address with the current default status
        address.isDefault = isDefaultLocationChecked

        let addressData: [String: Any] = [
            "city": address.city,
            "state": address.state,
            "country": address.country,
            "zipCode": address.zipCode,
            "isDefault": address.isDefault
        ]

        let userDocRef = db.collection("userAddress").document(userID)

        userDocRef.getDocument { [weak self] (document, error) in
            if let error = error {
                print("Error fetching document: \(error)")
                return
            }

            var addresses = [addressData]

            if let document = document, document.exists, let data = document.data(), let existingAddresses = data["addresses"] as? [[String: Any]] {
                addresses.append(contentsOf: existingAddresses)
            }

            userDocRef.setData(["addresses": addresses], merge: true) { error in
                if let error = error {
                    print("Error saving address: \(error)")
                } else {
                    print("But Address successfully saved with default status: \(address.isDefault)")
                  
                }
            }
        }
    }
}

//    jdffgfidfg
  



struct Address: Identifiable {
    var id = UUID() // Assuming you need a unique identifier
    var city: String
    var state: String
    var country: String
    var zipCode: String
    var isDefault: Bool
    var isChecked: Bool = false // New property to track checkbox state
}
