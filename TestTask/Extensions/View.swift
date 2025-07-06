//
// View.swift
// TestTask
//
// Created by Oleg Zakladnyi on 05.07.2025

import SwiftUI

extension View {
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

