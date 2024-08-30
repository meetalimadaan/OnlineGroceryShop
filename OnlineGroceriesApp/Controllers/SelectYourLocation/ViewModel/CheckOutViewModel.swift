import Foundation
import FirebaseFirestore
import FirebaseAuth

class CheckOutViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var addresses: [Address] = []
    @Published var selectedAddress: Address?

    private var db = Firestore.firestore()
    
    init() {
        fetchUsername()
        fetchSavedAddresses()
    }
    
    func fetchUsername() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        db.collection("users").document(userID).getDocument { (document, error) in
            if let document = document, document.exists {
                self.username = document.data()?["username"] as? String ?? "Guest"
            } else {
                print("Document does not exist")
            }
        }
    }
    
    func fetchSavedAddresses() {
        guard let userID = Auth.auth().currentUser?.uid else {
            print("User not logged in")
            return
        }
        
        db.collection("userAddress").document(userID).getDocument { [weak self] (document, error) in
            if let error = error {
                print("Error fetching addresses: \(error)")
                return
            }
            
            if let document = document, document.exists {
                let data = document.data()
                if let addressesData = data?["addresses"] as? [[String: Any]] {
                    let addresses = addressesData.map { addressData in
                        Address(
                            city: addressData["city"] as? String ?? "Unknown",
                            state: addressData["state"] as? String ?? "Unknown",
                            country: addressData["country"] as? String ?? "Unknown",
                            zipCode: addressData["zipCode"] as? String ?? "Unknown",
                            isDefault: addressData["isDefault"] as? Bool ?? false,
                            timestamp: addressData["timestamp"] as? Date ?? Date()
                        )
                    }
                    self?.addresses = addresses
//                    print("Addresses fetched: \(self?.addresses ?? [])")
                } else {
                    print("No addresses field found")
                    self?.addresses = []
                }
            } else {
                print("No document found for the user")
                self?.addresses = []
            }
        }
    }
    
    func toggleDefaultStatus(for address: Address) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        print("Toggling default status for address: \(address)")
        // Create the updated list of addresses
        var updatedAddresses = addresses.map { addr in
            var updatedAddress = addr
            if addr.id == address.id {
                updatedAddress.isDefault = !addr.isDefault
                print("Updated address to be default: \(updatedAddress)")
            } else {
                updatedAddress.isDefault = false
            }
            return updatedAddress
        }

        // Update Firestore
        let addressData: [[String: Any]] = updatedAddresses.map { addr in
            [
                "city": addr.city,
                "state": addr.state,
                "country": addr.country,
                "zipCode": addr.zipCode,
                "isDefault": addr.isDefault,
                "timestamp": addr.timestamp
            ]
        }
        
        db.collection("userAddress").document(userID).setData(["addresses": addressData], merge: true) { error in
            if let error = error {
                print("Error updating address status: \(error)")
            } else {
                print("Address default status updated successfully")
                self.fetchSavedAddresses() // Refresh the address list
            }
        }
    }
}
