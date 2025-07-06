//
// ImagePickerView.swift
// TestTask
//
// Created by Oleg Zakladnyi on 06.07.2025

import SwiftUI

struct ImagePickerView: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Binding var fileName: String
    var sourceType: UIImagePickerController.SourceType = .photoLibrary

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.allowsEditing = true
        picker.sourceType = sourceType
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePickerView

        init(_ parent: ImagePickerView) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            
            if let imageURL = info[.imageURL] as? URL {
                parent.fileName = imageURL.lastPathComponent
            } else {
                parent.fileName = "Selected Photo"
            }
            
            picker.dismiss(animated: true)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }
}

