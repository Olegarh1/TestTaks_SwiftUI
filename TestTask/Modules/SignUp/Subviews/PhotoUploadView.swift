//
// PhotoUploadView.swift
// TestTask
//
// Created by Oleg Zakladnyi on 06.07.2025

import SwiftUI

struct PhotoUploadView: View {
    @Binding var selectedImage: UIImage?
    @Binding var showImagePicker: Bool
    @Binding var showError: Bool
    @Binding var fileName: String
    var uploadAction: () -> Void
    
    @State private var wasTouched = false

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(fileName.isEmpty ? "Upload your photo" : fileName)
                    .font(.setFont(.nunitoRegular, size: 16))
                    .foregroundColor((showError && wasTouched) ? Color(hex: "#CB3D40") : Color.black.opacity(0.6))
                    .lineLimit(1)
                    .truncationMode(.tail)

                Spacer()

                Button("Upload") {
                    wasTouched = true
                    uploadAction()
                }
                
                .font(.setFont(.nunitoRegular, size: 16))
                .foregroundColor(.blue)
            }
            .padding(.horizontal, 16)
            .frame(height: 56)
            .background(
                RoundedRectangle(cornerRadius: 4)
                    .stroke((showError && wasTouched) ? Color(hex: "#CB3D40") : Color.gray.opacity(0.5), lineWidth: 1)
            )

            Group {
                if showError && wasTouched {
                    Text("Photo is required")
                        .font(.setFont(.nunitoRegular, size: 16))
                        .foregroundColor(Color(hex: "#CB3D40"))
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.leading, 16)
                } else {
                    Text(" ")
                        .font(.footnote)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            .frame(minHeight: 20)
        }
    }
}

