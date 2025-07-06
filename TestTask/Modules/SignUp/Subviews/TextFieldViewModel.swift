//
// TextFieldViewModel.swift
// TestTask
//
// Created by Oleg Zakladnyi on 06.07.2025

import SwiftUI

class TextFieldViewModel: ObservableObject {
    @Published var text: String = ""
    @Published var errorMessage: String? = nil

    var type: TextFieldType

    init(type: TextFieldType) {
        self.type = type
    }

    @discardableResult
    func validate() -> Bool {
        switch type {
        case .username:
            return validateUsername()
        case .email:
            return validateEmail()
        case .phone:
            return validatePhone()
        case .camera:
            return validateCamera()
        }
    }

    private func validateUsername() -> Bool {
        if text.isEmpty {
            errorMessage = "Required field"
            return false
        }
        if text.count < 3 {
            errorMessage = "Username too short"
            return false
        }
        if text.range(of: "^[a-zA-Z]+$", options: .regularExpression) == nil {
            errorMessage = "Username must contain only letters"
            return false
        }
        errorMessage = nil
        return true
    }

    private func validateEmail() -> Bool {
        if text.isEmpty {
            errorMessage = "Required field"
            return false
        }
        let pattern = #"^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$"#
        if text.range(of: pattern, options: [.regularExpression, .caseInsensitive]) == nil {
            errorMessage = "Invalid email format"
            return false
        }
        errorMessage = nil
        return true
    }

    private func validatePhone() -> Bool {
        if text == "+380" {
            text = ""
        }
        if text.isEmpty {
            errorMessage = "Required field"
            return false
        }
        let pattern = #"^\+380\d{9}$"#
        if text.range(of: pattern, options: .regularExpression) == nil {
            errorMessage = "Invalid phone format. Format is +380XXXXXXXXX"
            return false
        }
        errorMessage = nil
        return true
    }

    private func validateCamera() -> Bool {
        if text.isEmpty {
            errorMessage = "Photo is required"
            return false
        }
        errorMessage = nil
        return true
    }
}

