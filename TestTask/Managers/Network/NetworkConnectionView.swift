//
// NetworkConnectionView.swift
// TestTask
//
// Created by Oleg Zakladnyi on 22.06.2025

import SwiftUI

struct NetworkConnectionView: View {
    @ObservedObject private var networkMonitor = NetworkMonitor.shared
    @Environment(\.dismiss) private var dismiss
    @State private var isLoading = false

    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()

            VStack(spacing: 24) {
                Image("networkConnection")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 200, maxHeight: 200)
                Text("There is no internet connection")
                    .font(.setFont(.nunitoRegular, size: 24))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                    .padding(.horizontal)
                

                DefaultButton(title: "Try again", isLoading: isLoading) {
                    checkConnection()
                }
            }
            .padding()
        }
    }
    
    private func checkConnection() {
            isLoading = true

            if networkMonitor.isConnected {
                NetworkOverlayManager.shared.hideOverlay()
                return
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                isLoading = false
            }
        }
}
