//
// PhotoSourceAlert.swift
// TestTask
//
// Created by Oleg Zakladnyi on 06.07.2025

import SwiftUI

struct PhotoSourceAlertModifier: ViewModifier {
    @Binding var isPresented: Bool
    let cameraHandler: () -> Void
    let galleryHandler: () -> Void

    func body(content: Content) -> some View {
        content
            .confirmationDialog("Choose how you want to add a photo",
                                isPresented: $isPresented,
                                titleVisibility: .visible) {
                Button("Camera", action: cameraHandler)
                Button("Gallery", action: galleryHandler)
                Button("Cancel", role: .cancel, action: {})
            }
    }
}

