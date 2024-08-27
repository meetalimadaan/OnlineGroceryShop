import Foundation
import FirebaseFirestore
import FirebaseAuth

class CheckOutViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var savedAddresses: [Address] = []
    @Published var isDefaultLocationChecked = false
    @Published var selectedAddress: Address?
    
    private var db = Firestore.firestore()
    
    init() {
        fetchUsername()
        fetchSavedAddresses()
    }
    func toggleDefaultStatus(for address: Address) {
            // Set the selected address and handle default status logic
            selectedAddress = address
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
                print("Error fetching address: \(error)")
                return
            }
            
            if let document = document, document.exists {
                let data = document.data()
                if let addresses = data?["addresses"] as? [[String: Any]] {
                    // Print all addresses for debugging purposes
                    print("All addresses: \(addresses)")
                    
                    // Filter the addresses to find the ones marked as default
                    let defaultAddresses = addresses.filter { $0["isDefault"] as? Int == 1 }
                    
                    // Print default addresses
                    print("Default addresses: \(defaultAddresses)")
                    
                    if defaultAddresses.isEmpty {
                        print("No default address found")
                    } else {
                        // Map all default addresses to Address objects
                        self?.savedAddresses = defaultAddresses.map { address in
                            Address(
                                city: address["city"] as? String ?? "Unknown",
                                state: address["state"] as? String ?? "Unknown",
                                country: address["country"] as? String ?? "Unknown",
                                zipCode: address["zipCode"] as? String ?? "Unknown",
                                isDefault: true
                            )
                        }
                    }
                } else {
                    print("No addresses field found")
                }
            } else {
                print("No document found for the user")
            }
        }
    }
}

