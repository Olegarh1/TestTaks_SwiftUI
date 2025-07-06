//
// AlertState.swift
// TestTask
//
// Created by Oleg Zakladnyi on 05.07.2025

import SwiftUI

struct AlertState: Identifiable {
    var id = UUID()
    var title: String
    var message: String
    var primaryButtonTitle: String
    var primaryAction: (() -> Void)?
    var secondaryButtonTitle: String?
    var secondaryAction: (() -> Void)?
}
