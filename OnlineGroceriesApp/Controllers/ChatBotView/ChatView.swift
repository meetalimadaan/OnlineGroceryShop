//
//  ChatView.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 07/10/24.
//

import SwiftUI

struct ChatView: View {
    @State private var messages: [ChatMessage] = []
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State private var newMessage: String = ""
    
    var body: some View {
        
        VStack {
            // Header
            HStack {
                Button(action: {
                    mode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.backward")
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                        .foregroundColor(.primaryApp)
                }
                
                Spacer()
                
            
                HStack(spacing: 8) {
                    
                    Image("png-clipart-chatbot-logo-robotics-robot-electronics-leaf-thumbnail")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .clipShape(Circle())
                    
             
                    Text("Rufus")
                        .font(.customfont(.bold, fontSize: 20))
                        .frame(height: 46)
                }
                
                Spacer()
            }
            .padding(.horizontal, 10)
            .padding(.top, 10)
            .background(Color.white)
            .shadow(color: Color.black.opacity(0.2), radius: 2)
            
            
            
    
            if messages.isEmpty {
                VStack {
                    Spacer()
                    
                    Image("Screenshot 2024-10-10 at 12.28.18 PM")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 150)
                    
                    
                    
                    Text("How can we help you?")
                        .font(.customfont(.bold, fontSize: 16))
                        .padding(.top, 5)
                        .foregroundColor(.gray)
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                // Chat Messages
                ScrollViewReader { scrollViewProxy in
                    ScrollView {
                        VStack(alignment: .leading, spacing: 10) {
                            ForEach(messages) { message in
                                if message.isBot {
                                    if message.isProduct, let product = message.product {
                                        ProductView(product: product)
                                            .id(message.id)
                                    } else {
                                        BotMessageView(text: message.text ?? "", timestamp: message.timestamp) // Pass timestamp
                                                       .id(message.id)
                                    }
                                } else {
                                    UserMessageView(text: message.text ?? "", timestamp: message.timestamp) // Pass timestamp
                                               .id(message.id)
                                }
                            }
                        }
                        .padding()
                    }
                    .onChange(of: messages) { _ in
                        if let lastMessage = messages.last {
                            DispatchQueue.main.async {
                                scrollViewProxy.scrollTo(lastMessage.id, anchor: .top)
                            }
                        }
                    }
                }
            }

            // Text input and send button
            HStack {
                TextField("Ask Rufus a question", text: $newMessage)
                    .font(.customfont(.medium, fontSize: 18))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(height: 40)
                Button(action: {
                    if !newMessage.isEmpty {
                        messages.append(ChatMessage(text: newMessage, isBot: false, product: nil))
                        sendQueryToAPI(query: newMessage)
                        newMessage = ""
                    }
                }) {
                    Image(systemName: "paperplane.fill")
                        .font(.title2)
                        .foregroundColor(Color.primaryApp)
                        .padding(8)
                }
            }
            .padding()
            .background(Color(UIColor.systemGray5))
        }
        //        .navigationBarTitle("HelpBot", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .onAppear {
                   // Append a static welcome message from the bot if no messages exist
                   if messages.isEmpty {
                       let botMessage = "Hello, welcome to our grocery store. How can i assist you today?."
                       messages.append(ChatMessage(text: botMessage, isBot: true))
                   }
               }
    }
    
    
    
    func sendQueryToAPI(query: String) {
        
        
        print("Sending query to API: \(query)")
        
        // Proceed with the API request for other queries
        guard let url = URL(string: "http://10.10.60.217:8000/query") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: String] = ["query": query]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            print("Failed to encode request body: \(error)")
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error sending query: \(error)")
                DispatchQueue.main.async {
                    messages.append(ChatMessage(text: "Error: \(error.localizedDescription)", isBot: true, product: nil))
                }
                return
            }
            
            guard let data = data else {
                print("No data received")
                DispatchQueue.main.async {
                    messages.append(ChatMessage(text: "No data received from server", isBot: true))
                }
                return
            }
            
            do {
                if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    print("Response from API: \(jsonResponse)")
                    
                    
                    if let aiResponse = jsonResponse["response"] as? [String: Any] {
                        if let botMessage = aiResponse["ai_response"] as? String {
                            DispatchQueue.main.async {
                                messages.append(ChatMessage(text: botMessage, isBot: true))
                            }
                        }
                        
                        
                        if let productData = aiResponse["data"] as? String,
                           let data = productData.data(using: .utf8) {
                            do {
                                let products = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
                                
                                if let products = products {
                                    for productData in products {
                                        if let productName = productData["name"] as? String,
                                           let productID = productData["productID"] as? String,
                                           let productDescription = productData["description"] as? String,
                                           let productPrice = productData["price"] as? Double,
                                           let productImageURL = productData["img"] as? String,
                                           let productNutritions = productData["nutritions"] as? String {
                                            
                                            
                                            let product = Product(id: productID,name: productName, price: productPrice, productID: productID, description: productDescription, img: productImageURL, nutritions: productNutritions,images: [productImageURL] )
                                            DispatchQueue.main.async {
                                                messages.append(ChatMessage(text: "", isBot: true, isProduct: true, product: product))
                                            }
                                        }
                                    }
                                }
                            } catch {
                                print("Failed to parse product data: \(error)")
                                
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            messages.append(ChatMessage(text: "Unexpected response format", isBot: true))
                        }
                    }
                }
            } catch {
                print("Failed to parse response: \(error)")
                DispatchQueue.main.async {
                    messages.append(ChatMessage(text: "Failed to parse response: \(error.localizedDescription)", isBot: true))
                }
            }
        }.resume()
    }
    
    
    
}

struct BotMessageView: View {
    let text: String
    let timestamp: Date
    var body: some View {
        HStack(alignment: .bottom, spacing: 8) {
            
            Image("png-clipart-chatbot-logo-robotics-robot-electronics-leaf-thumbnail")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .clipShape(Circle())
            
            
            VStack(alignment: .leading, spacing: 4) {
                            Text(text)
                                .font(.customfont(.medium, fontSize: 16))
                                .padding(12)
                                .background(Color(UIColor.systemGray6))
                                .cornerRadius(20, corners: [.topLeft, .topRight, .bottomRight])
                                .frame(maxWidth: 250, alignment: .leading)
                                .shadow(radius: 2)
                            
                            Text(timestamp.formatted())
                                .font(.footnote)
                                .foregroundColor(.gray)
                                .padding(.leading, 12) // Optional: Aligns the timestamp with the message text
                        }
                        
            
            Spacer()
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
    }
}

struct UserMessageView: View {
    let text: String
    let timestamp: Date
    
    var body: some View {
        HStack(alignment: .bottom) {
            Spacer()
            VStack(alignment: .trailing, spacing: 4) {
                            Text(text)
                                .font(.customfont(.medium, fontSize: 16))
                                .padding(12)
                                .background(Color.primaryApp)
                                .foregroundColor(.white)
                                .cornerRadius(20, corners: [.topLeft, .topRight, .bottomLeft])
                                .frame(maxWidth: 250, alignment: .trailing)
                                .shadow(radius: 2)
                            
                            Text(timestamp.formatted()) // Display formatted timestamp
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
    }
}
import Foundation

struct ChatMessage: Identifiable, Equatable {
    let id = UUID()
    let text: String?
    let isBot: Bool
    let isProduct: Bool
    let product: Product?
    let timestamp: Date
    
    init(text: String? = nil, isBot: Bool, isProduct: Bool = false, product: Product? = nil) {
        self.text = text
        self.isBot = isBot
        self.isProduct = isProduct
        self.product = product
        self.timestamp = Date()
    }
    
    static func == (lhs: ChatMessage, rhs: ChatMessage) -> Bool {
        return lhs.id == rhs.id
    }
}





struct RoundedCorners: Shape {
    var radius: CGFloat = 25.0
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorners(radius: radius, corners: corners))
    }
}
extension Date {
    func formatted() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: self)
    }
}

#Preview {
    ChatView()
}


