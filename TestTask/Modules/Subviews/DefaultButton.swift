//
// DefaultButton.swift
// TestTask
//
// Created by Oleg Zakladnyi on 05.07.2025

import SwiftUI

struct DefaultButton: View {
    let title: String
    let isLoading: Bool
    let action: () -> Void
    var backgroundColor: Color = Color(hex: "#F4E041")
    var foregroundColor: Color = .black
    
    
    var body: some View {
        Button(action: {
            if !isLoading {
                action()
            }
        }) {
            Group {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: foregroundColor))
                } else {
                    Text(title)
                        .font(.setFont(.nunitoSemiBold, size: 18))
                        .foregroundColor(foregroundColor)
                        .background(
                            GeometryReader { geo in
                                Color.clear
                            }
                        )
                }
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 24)
            .background(backgroundColor)
            .clipShape(Capsule())
        }
        .disabled(isLoading)
    }
}
