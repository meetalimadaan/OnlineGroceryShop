import Foundation
import FirebaseFirestore
import FirebaseAuth

class CheckOutViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var addresses: [Address] = []
    @Published var selectedAddress: Address?
    @Published var orderStatus: String = "Pending"
    @Published var orderDate: Date = Date() 
    
    private var db = Firestore.firestore()
    private var cartViewModel = MyCartViewModel()
   
    
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
                            id: addressData["id"] as? String ?? UUID().uuidString,
                            city: addressData["city"] as? String ?? "Unknown",
                            state: addressData["state"] as? String ?? "Unknown",
                            country: addressData["country"] as? String ?? "Unknown",
                            zipCode: addressData["zipCode"] as? String ?? "Unknown",
                            isDefault: addressData["isDefault"] as? Bool ?? false,
                            timestamp: addressData["timestamp"] as? Date
                        )
                    }
                    self?.addresses = addresses
                    // Find the default address
                    if let defaultAddress = addresses.first(where: { $0.isDefault }) {
                        self?.selectedAddress = defaultAddress
                        print("Selected address: \(self?.selectedAddress ?? Address(id: "", city: "", state: "", country: "", zipCode: "", isDefault: false))")
                    } else {
                        self?.selectedAddress = nil
                        print("No default address found")
                    }
                } else {
                    print("No addresses field found")
                    self?.addresses = []
                    self?.selectedAddress = nil
                }
            } else {
                print("No document found for the user")
                self?.addresses = []
                self?.selectedAddress = nil
            }
        }
    }
    
   
    func addOrder()  {
        guard let userID = Auth.auth().currentUser?.uid else {
            print("User not logged in")
            return
        }

     
        let userOrdersRef = db.collection("userOrders").document(userID).collection("orders")

      
        let newOrderRef = userOrdersRef.document()
        let orderID = newOrderRef.documentID

       
        var orderData: [String: Any] = [
            "orderID": orderID,
            "status": orderStatus,
            "orderDate": Timestamp(date: orderDate),
            "totalPrice": cartViewModel.totalAmount
            ]
       
        if let address = selectedAddress {
            orderData["selectedAddress"] = [
                "id": address.id,
                "city": address.city,
                "state": address.state,
                "country": address.country,
                "zipCode": address.zipCode
            ]
        }
        
     
        orderData["cartItems"] = cartViewModel.cartItems.map { cartItem in
            return [
                "productID": cartItem.id,
                "name": cartItem.name,
                "price": cartItem.price,
                "quantity": cartItem.quantity,
                "img": cartItem.img
            ]
        }

        
        print("Order Data to be saved:", orderData)

      
        newOrderRef.setData(orderData) { error in
            if let error = error {
                print("Error adding order: \(error.localizedDescription)")
            } else {
                print("Order added successfully with orderID: \(orderID)")
                print("Order Data successfully saved to Firestore!")
                
                self.clearCart(for: userID)
//                NotificationCenter.default.post(name: Notification.Name("AddressUpdated"), object: nil)
              
            }
        }
    }


    private func clearCart(for userID: String) {
        let userCartRef = Firestore.firestore().collection("userCart").document(userID)

        userCartRef.updateData(["cartItems": []]) { error in
            if let error = error {
                print("Error clearing cart: \(error.localizedDescription)")
            } else {
                print("Cart cleared successfully!")
            }
        }
    }
    
    func toggleDefaultStatus(for address: Address) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        print("Toggling default status for address: \(address)")
        
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

  
        let addressData: [[String: Any]] = updatedAddresses.map { addr in
            [
                "id": addr.id,
                "city": addr.city,
                "state": addr.state,
                "country": addr.country,
                "zipCode": addr.zipCode,
                "isDefault": addr.isDefault,
                "timestamp": addr.timestamp ?? Date()
            ]
        }
        
        db.collection("userAddress").document(userID).setData(["addresses": addressData], merge: true) { error in
            if let error = error {
                print("Error updating address status: \(error)")
            } else {
                print("Address default status updated successfully")
                self.fetchSavedAddresses()
            }
        }
    }
}
