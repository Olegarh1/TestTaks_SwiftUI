//
// RadioButtonView.swift
// TestTask
//
// Created by Oleg Zakladnyi on 06.07.2025

import SwiftUI

struct RadioButtonView: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                Image(isSelected ? "selectedCircle" : "unselectedCircle")
                    .resizable()
                    .frame(width: 20, height: 20)
                
                Text(title)
                    .font(.setFont(.nunitoRegular, size: 16))
                    .foregroundColor(.black)
                
                Spacer()
            }
            .padding(.vertical, 8)
        }
        .buttonStyle(.plain)
    }
}
