//
// UIApplication.swift
// TestTask
//
// Created by Oleg Zakladnyi on 06.07.2025

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
