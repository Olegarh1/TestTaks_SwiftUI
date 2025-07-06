//
// ValidatedTextField.swift
// TestTask
//
// Created by Oleg Zakladnyi on 06.07.2025

import SwiftUI

enum TextFieldType {
    case username
    case email
    case phone
    case camera
}

struct ValidatedTextField: View {
    @ObservedObject var viewModel: TextFieldViewModel
    let placeholder: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            TextField(placeholder, text: $viewModel.text, onEditingChanged: { isEditing in
                if !isEditing {
                    viewModel.validate()
                }
            })
            .padding(.horizontal, 16)
            .frame(height: 56)
            .background(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(viewModel.errorMessage == nil ? Color.gray.opacity(0.5) : Color(hex: "#CB3D40"), lineWidth: 1)
            )

            if let error = viewModel.errorMessage {
                Text(error)
                    .font(.setFont(.nunitoRegular, size: 16))
                    .foregroundColor(Color(hex: "#CB3D40"))
                    .padding(.leading, 16)
            } else if viewModel.type == .phone {
                Text("+38 (XXX) XXX - XX - XX")
                    .font(.setFont(.nunitoRegular, size: 16))
                    .foregroundColor(.gray)
                    .padding(.leading, 16)
            } else {
                Text(" ")
                    .font(.footnote)
            }
        }
    }
}
