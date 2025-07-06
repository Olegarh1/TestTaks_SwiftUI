//
// CustomNavigationTitleModifier.swift
// TestTask
//
// Created by Oleg Zakladnyi on 05.07.2025

import SwiftUI

struct CustomNavigationBar: View {
    let title: String

    var body: some View {
        VStack {
            Color(hex: "#F4E041")
                .frame(height: 56)
                .overlay(
                    Text(title)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.black)
                )
        }
    }
}
