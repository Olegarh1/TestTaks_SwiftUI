//
// PositionSelector.swift
// TestTask
//
// Created by Oleg Zakladnyi on 06.07.2025

import SwiftUI

struct PositionSelector: View {
    @Binding var selectedPositionID: Int?
    let positions: [Position]
    var showError: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            if !positions.isEmpty {
                Text("Select your position")
                    .font(.setFont(.nunitoRegular, size: 18))
                    .foregroundColor(showError ? Color(hex: "#CB3D40") : .black)
                    .transition(.opacity)

                ForEach(positions, id: \.id) { position in
                    RadioButtonView(
                        title: position.name,
                        isSelected: selectedPositionID == position.id
                    ) {
                        selectedPositionID = position.id
                    }
                }
                .padding(.leading, 16)

                if showError {
                    Text("Please select a position")
                        .font(.setFont(.nunitoRegular, size: 16))
                        .foregroundColor(Color(hex: "#CB3D40"))
                        .padding(.leading, 16)
                }
            }
        }
        .animation(.easeInOut, value: positions)
    }
}
