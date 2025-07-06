//
// RegistrationResultView.swift
// TestTask
//
// Created by Oleg Zakladnyi on 21.06.2025

import SwiftUI

struct RegistrationResultView: View {
    let success: Bool
    let message: String
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            Image(success ? "successImage" : "FailedImage")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
            
            Text(message)
                .font(.custom("Nunito-Regular", size: 24))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 16)
            
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                DefaultButton(title: success ? "Got it" : "Try again", isLoading: false) {
                    presentationMode.wrappedValue.dismiss()
                }
            }
            
            Spacer()
        }
        .padding()
        .overlay(
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "xmark")
                    .foregroundColor(Color.black.opacity(0.48))
                    .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            , alignment: .topTrailing
        )
        .background(Color.white.edgesIgnoringSafeArea(.all))
    }
}
