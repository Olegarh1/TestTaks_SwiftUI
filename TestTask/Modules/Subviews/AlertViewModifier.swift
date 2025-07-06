//
// AlertViewModifier.swift
// TestTask
//
// Created by Oleg Zakladnyi on 05.07.2025

import SwiftUI

struct AlertViewModifier: ViewModifier {
    @Binding var alertState: AlertState?

    func body(content: Content) -> some View {
        content.alert(item: $alertState) { state in
            if let secondary = state.secondaryButtonTitle {
                return Alert(
                    title: Text(state.title),
                    message: Text(state.message),
                    primaryButton: .default(Text(state.primaryButtonTitle), action: state.primaryAction ?? {}),
                    secondaryButton: .cancel(Text(secondary), action: state.secondaryAction ?? {})
                )
            } else {
                return Alert(
                    title: Text(state.title),
                    message: Text(state.message),
                    dismissButton: .default(Text(state.primaryButtonTitle), action: state.primaryAction ?? {})
                )
            }
        }
    }
}
