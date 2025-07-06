//
// SignUpViewModel.swift
// TestTask
//
// Created by Oleg Zakladnyi on 06.07.2025

import SwiftUI

class SignUpViewModel: ObservableObject {
    @Published var positions: [Position] = []
    @Published var selectedPositionID: Int? = nil
    @Published var alertState: AlertState? = nil
    @Published var isLoading: Bool = false
    
    @Published var showRegistrationResult = false
    @Published var registrationSuccess = false
    @Published var registrationMessage = ""
    
    func getPositions(retryCount: Int = 3, delay: TimeInterval = 2) {
        guard NetworkMonitor.shared.isConnected else {
            NetworkMonitor.shared.runWhenConnected {
                self.getPositions(retryCount: retryCount, delay: delay)
            }
            return
        }
        
        Network.shared.getPositions { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let model):
                    guard let positions = model.positions, model.success,
                          let firstID = positions.first?.id else {
                        self.alertState = AlertState(title: "Error",
                                                     message: model.message ?? "No position enabled",
                                                     primaryButtonTitle: "OK")
                        return
                    }
                    self.positions = positions
                    self.selectedPositionID = firstID
                    
                case .failure(let error):
                    if retryCount > 1 {
                        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                            self.getPositions(retryCount: retryCount - 1, delay: delay)
                        }
                    } else {
                        self.alertState = AlertState(title: "Network Error", message: error.localizedDescription, primaryButtonTitle: "OK" )
                    }
                }
            }
        }
    }
    
    func generateToken(_ model: SignUpRequestModel, image: UIImage?) {
        showLoader(true)
        
        Network.shared.generateToken { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let token):
                    guard token.success else {
                        self.showLoader(false)
                        self.alertState = AlertState(title: "Error", message: "Failed to get user token", primaryButtonTitle: "OK")
                        return
                    }
                    self.registUser(model, token: token.token, image: image)
                case .failure(let error):
                    self.showLoader(false)
                    self.alertState = AlertState(title: "Error", message: error.localizedDescription, primaryButtonTitle: "OK")
                }
            }
        }
    }
    
    func registUser(_ model: SignUpRequestModel, token: String?, image: UIImage?) {
        guard let token = token else {
            alertState = AlertState(title: "Error", message: "Wrong token", primaryButtonTitle: "OK")
            self.showLoader(false)
            return
        }
        
        guard let image = image else {
            alertState = AlertState(title: "Error", message: "Wrong image", primaryButtonTitle: "OK")
            self.showLoader(false)
            return
        }
        
        Network.shared.signUpUser(model, image: image, token: token) { response in
            print("response is \(response)")
            DispatchQueue.main.async {
                self.showLoader(false)
                switch response {
                case .success(let model):
                    var message = model.message ?? ""
                    if let fails = model.fails {
                        message = fails.flatMap { $0.value }.joined(separator: "\n")
                    }
                    self.registrationSuccess = model.success
                    self.registrationMessage = message
                    self.showRegistrationResult = true
                    
                case .failure(let error):
                    self.alertState = AlertState(title: "Error", message: error.localizedDescription, primaryButtonTitle: "OK")
                }
            }
        }
    }
    
    private func showLoader(_ show: Bool) {
        DispatchQueue.main.async {
            self.isLoading = show
        }
    }
}

