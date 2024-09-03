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

    private var db = Firestore.firestore()

    init() {
        fetchUserOrders()
    }

    func fetchUserOrders() {
            guard let userID = Auth.auth().currentUser?.uid else {
                print("User not logged in")
                return
            }

            db.collection("userOrders").document(userID).collection("orders").getDocuments { snapshot, error in
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
                        
                        return Order(id: orderID, status: status, orderDate: orderDate, totalPrice: totalPrice)
                    }
                    self.applyFilter()
                }
            }
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
    }
