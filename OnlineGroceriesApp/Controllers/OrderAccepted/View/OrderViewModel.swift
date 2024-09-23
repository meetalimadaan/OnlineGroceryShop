//
//  OrderViewModel.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 30/08/24.
//
import Foundation
import FirebaseFirestore
import FirebaseAuth

class OrderViewModel: ObservableObject {
    @Published var orders: [Order] = []
    @Published var filteredOrders: [Order] = []
    @Published var selectedStatus: String = "All"
    @Published var productOrderCounts: [String: Int] = [:]

    private var db = Firestore.firestore()
    private var listener: ListenerRegistration?

    init() {
        fetchUserOrders()
    }
    deinit {
            listener?.remove()
        }
    func fetchUserOrders() {
            guard let userID = Auth.auth().currentUser?.uid else {
                print("User not logged in")
                return
            }

            // Use a snapshot listener for real-time updates
            listener = db.collection("userOrders").document(userID).collection("orders")
                .addSnapshotListener { snapshot, error in
                    if let error = error {
                        print("Error fetching orders: \(error)")
                        return
                    }

                    if let documents = snapshot?.documents {
                        self.orders = documents.map { doc -> Order in
                            let data = doc.data()
                            let orderID = data["orderID"] as? String ?? ""
                            let status = data["status"] as? String ?? "Pending"
                            let orderDate = (data["orderDate"] as? Timestamp)?.dateValue() ?? Date()
                            let totalPrice = data["totalPrice"] as? Double ?? 0.0
                            
                            // Fetching cartItems
                            let cartItemsData = data["cartItems"] as? [[String: Any]] ?? []
                            let cartItems = cartItemsData.map { itemData -> CartItem in
                                let productID = itemData["productID"] as? String ?? ""
                                let name = itemData["name"] as? String ?? ""
                                let price = itemData["price"] as? Double ?? 0.0
                                let quantity = itemData["quantity"] as? Int ?? 0
                                let img = itemData["img"] as? String ?? ""
                                let arrivalDate = (itemData["arrivalDate"] as? Timestamp)?.dateValue() ?? Date()
                                return CartItem(id: productID, name: name, price: price, quantity: quantity, img: img)
                            }
                            
                            // Fetching selectedAddress
                            let addressData = data["selectedAddress"] as? [String: Any]
                            let selectedAddress = addressData.map { addrData in
                                Address(
                                    id: addrData["id"] as? String ?? UUID().uuidString,
                                    city: addrData["city"] as? String ?? "Unknown",
                                    state: addrData["state"] as? String ?? "Unknown",
                                    country: addrData["country"] as? String ?? "Unknown",
                                    zipCode: addrData["zipCode"] as? String ?? "Unknown",
                                    isDefault: false
                                )
                            }
                            
                            return Order(id: orderID, status: status, orderDate: orderDate, totalPrice: totalPrice, cartItems: cartItems, selectedAddress: selectedAddress)
                        }
                        self.applyFilter()
                        self.countProductOrders()
                    }
                }
        }
    func countProductOrders() {
        // Clear existing counts
        productOrderCounts.removeAll()

        // Count orders for each product
        for order in orders {
            for item in order.cartItems {
                productOrderCounts[item.id, default: 0] += item.quantity
            }
        }

        
        self.objectWillChange.send()
    }

    func applyFilter() {
        if selectedStatus == "All" {
            filteredOrders = orders
        } else {
            filteredOrders = orders.filter { $0.status == selectedStatus }
        }
    }
}

struct Order: Identifiable {
    var id: String
    var status: String
    var orderDate: Date
    var totalPrice: Double
    var cartItems: [CartItem]
    var selectedAddress: Address?
}


