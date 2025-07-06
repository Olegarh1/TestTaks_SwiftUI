//
// TabBarView.swift
// TestTask
//
// Created by Oleg Zakladnyi on 15.06.2025

import SwiftUI

struct TabBarView: View {
    @Binding var selectedIndex: Int
    let tabs: [(title: String, imageName: String)]

    var body: some View {
        HStack {
            ForEach(tabs.indices, id: \.self) { idx in
                Spacer()
                TabBarItem(
                    imageName: tabs[idx].imageName,
                    title: tabs[idx].title,
                    isSelected: selectedIndex == idx
                ) {
                    selectedIndex = idx
                }
                Spacer()
            }
        }
        .padding(.vertical, 10)
        .padding(.bottom, 16)
        .background(Color(hex: "#F8F8F8"))
    }
}
