//
// TabBarItem.swift
// TestTask
//
// Created by Oleg Zakladnyi on 15.06.2025

import SwiftUI

struct TabBarItem: View {
    let imageName: String
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: {
            action()
        }) {
            HStack(spacing: 8) {
                Image(imageName)
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 17)
                    .foregroundColor(isSelected ? Color(hex: "#00BDD3") : Color.black.opacity(0.6))

                Text(title)
                    .foregroundColor(isSelected ? Color(hex: "#00BDD3") : Color.black.opacity(0.6))
                    .font(.system(size: 14))
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
        }
        .buttonStyle(BounceButtonStyle())
    }
}
