//
// SignUpViewController.swift
// TestTask
//
// Created by Oleg Zakladnyi on 15.06.2025

import SwiftUI
import PhotosUI


struct SignUpView: View {
    // MARK: - Models / States
    @StateObject private var nameField = TextFieldViewModel(type: .username)
    @StateObject private var emailField = TextFieldViewModel(type: .email)
    @StateObject private var phoneField = TextFieldViewModel(type: .phone)
    
    @State private var cameraText = ""
    @State private var imageFileName: String = "Upload your photo"
   
    var isPhotoValid: Bool {
        selectedImage != nil
    }
    
    @State private var selectedPositionId: Int?
    @State private var showPositionError = false
    
    @State private var showPhotoSourceAlert = false
    @State private var showingCameraPicker = false
    @State private var showingImagePicker = false
    
    @State private var selectedImage: UIImage?
    @State private var showPhotoError = false
    @StateObject private var viewModel = SignUpViewModel()
    
    private var isFormDirty: Bool {
        return !nameField.text.isEmpty ||
               !emailField.text.isEmpty ||
               !phoneField.text.isEmpty ||
               selectedPositionId != nil ||
               selectedImage != nil
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                CustomNavigationBar(title: "Working with POST request")
                
                VStack(spacing: 16) {
                    ValidatedTextField(viewModel: nameField, placeholder: "Your name")
                    ValidatedTextField(viewModel: emailField, placeholder: "Email")
                    ValidatedTextField(viewModel: phoneField, placeholder: "Phone")
                    
                    if viewModel.positions.isEmpty {
                        ProgressView("Loading...")
                    } else {
                        PositionSelector(selectedPositionID: $selectedPositionId,
                                         positions: viewModel.positions,
                                         showError: showPositionError)
                    }
                    
                    PhotoUploadView(
                        selectedImage: $selectedImage,
                        showImagePicker: $showingImagePicker,
                        showError: .constant(!isPhotoValid && showPhotoError),
                        fileName: $imageFileName,
                        uploadAction: {
                            presentPhotoSourceAlert()
                        }
                    )
                    
                    DefaultButton(title: "Sign up",
                                  isLoading: viewModel.isLoading,
                                  action: submitSignUpForm,
                                  backgroundColor: isFormDirty ? Color.yellow : Color.gray,
                                  foregroundColor: isFormDirty ? .black : .black.opacity(0.5))
                    .disabled(!isFormDirty || viewModel.isLoading)
                    
                }
                .padding()
            }
            .scrollIndicators(.hidden)
            .onAppear(perform: getPositions)
            .contentShape(Rectangle())
            .onTapGesture {
                UIApplication.shared.endEditing()
            }
            .modifier(AlertViewModifier(alertState: $viewModel.alertState))
            .modifier(PhotoSourceAlertModifier(isPresented: $showPhotoSourceAlert,
                                               cameraHandler: {
                showingCameraPicker = true
            },
                                               galleryHandler: {
                showingImagePicker = true
            }))
            .sheet(isPresented: $showingImagePicker) {
                ImagePickerView(image: $selectedImage, fileName: $imageFileName)
            }
            .sheet(isPresented: $showingCameraPicker) {
                ImagePickerView(image: $selectedImage, fileName: $imageFileName, sourceType: .camera)
            }
            .fullScreenCover(isPresented: $viewModel.showRegistrationResult) {
                RegistrationResultView(
                    success: viewModel.registrationSuccess,
                    message: viewModel.registrationMessage
                )
            }
        }
    }
    
    // MARK: - Methods
    private func getPositions() {
        viewModel.getPositions()
    }
    
    private func presentPhotoSourceAlert() {
        showPhotoSourceAlert = true
    }
    
    private func submitSignUpForm() {
//        let isValidFields = [nameField.validate(),
//            emailField.validate(),
//            phoneField.validate()].allSatisfy { $0 }
//
//        let isPositionValid = selectedPositionId != nil
//        let isPhotoValid = selectedImage != nil
//
//        showPhotoError = !isPhotoValid
//        showPositionError = !isPositionValid
//
//        guard isValidFields, isPositionValid, isPhotoValid else {
//            return
//        }

        showPhotoError = false
        showPositionError = false

        let model = SignUpRequestModel(
            name: nameField.text,
            email: emailField.text.lowercased(),
            phone: phoneField.text,
            position_id: selectedPositionId ?? 1,
            photo: "profile.jpg"
        )

        viewModel.generateToken(model, image: selectedImage)
    }
}
