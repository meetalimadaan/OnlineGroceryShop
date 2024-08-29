//
//  MyDetailsView.swift
//  OnlineGroceriesApp
//
//  Created by meetali on 28/08/24.
//

import SwiftUI

struct MyDetailsView: View {
    @ObservedObject private var viewModel = AccountViewModel.shared

    var body: some View {
        VStack {
            // Header
            HStack {
                Spacer()
                Text("My Details")
                    .font(.customfont(.bold, fontSize: 20))
                    .frame(height: 46)
                Spacer()
            }
            .padding(.top, .topInsets)
            .background(Color.white)
            .shadow(color: Color.black.opacity(0.2), radius: 2)

            Spacer()

            // User Details
            if viewModel.isLoading {
                ProgressView()
                    .padding()
            } else {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Username: \(viewModel.username)")
                        .font(.headline)

                    Text("Email: \(viewModel.email)")
                        .font(.headline)

                    Spacer()
                }
                .padding()
            }

            Spacer()
        }
        .background(Color(.systemGray6))
        .edgesIgnoringSafeArea(.top)
        .onAppear {
            print("Fetching user data")
            viewModel.fetchUserData()
        }
    }
}

