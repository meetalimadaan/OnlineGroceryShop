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
    private var db = Firestore.firestore()

    init() {
        fetchUserOrders()
    }

    func fetchUserOrders() {
        guard let userID = Auth.auth().currentUser?.uid else {
            print("User not logged in")
            return
        }

        db.collection("userOrders").document(userID).collection("orders").getDocuments { [weak self] (querySnapshot, error) in
            if let error = error {
                print("Error fetching orders: \(error)")
                return
            }

            if let querySnapshot = querySnapshot {
                self?.orders = querySnapshot.documents.map { document in
                    let data = document.data()
                    return Order(
                        id: data["orderID"] as? String ?? UUID().uuidString,
                        status: data["status"] as? String ?? "Unknown",
                        orderDate: (data["orderDate"] as? Timestamp)?.dateValue() ?? Date(),
                        totalPrice: data["totalPrice"] as? Double ?? 0.0,
                        selectedAddress: data["selectedAddress"] as? [String: Any],
                        cartItems: data["cartItems"] as? [[String: Any]] ?? []
                    )
                }
            }
        }
    }
}
struct Order: Identifiable {
    var id: String
    var status: String
    var orderDate: Date
    var totalPrice: Double
    var selectedAddress: [String: Any]?
    var cartItems: [[String: Any]]
}
