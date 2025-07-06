//
// UsersViewModel.swift
// TestTask
//
// Created by Oleg Zakladnyi on 05.07.2025

import SwiftUI
import Combine

class UsersViewModel: ObservableObject {
    @Published var usersData: UsersModel? = nil
    @Published var isLoading = false
    @Published var alertState: AlertState? = nil
    
    private var cancellables = Set<AnyCancellable>()
    private var resetUsers = false
    
    func getUsers(page: Int = 1, retryCount: Int = 3, delay: TimeInterval = 2) {
        guard NetworkMonitor.shared.isConnected else {
            NetworkMonitor.shared.runWhenConnected {
                self.getUsers(page: page, retryCount: retryCount, delay: delay)
            }
            return
        }
        
        isLoading = true
        
        let requestModel = UsersRequestModel(page: page, count: 6)
        Network.shared.getUsers(requestModel) { [weak self] response in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isLoading = false
                
                switch response {
                case .success(let model):
                    guard model.success else {
                        self.alertState = AlertState(title: "Error", message: "Failed to get users", primaryButtonTitle: "Okay")
                        return
                    }
                    
                    if let oldUsers = self.usersData?.users,
                       let newUsers = model.users {
                        self.usersData?.users = self.resetUsers ? newUsers : oldUsers + newUsers
                        self.resetUsers = false
                    } else {
                        self.usersData = model
                    }
                    
                case .failure(let error):
                    if retryCount > 1 {
                        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                            self.getUsers(page: page, retryCount: retryCount - 1, delay: delay)
                        }
                    } else {
                        self.alertState = AlertState(title: "Network Error", message: error.localizedDescription, primaryButtonTitle: "Okay")
                    }
                }
            }
        }
    }
    
    func reset() {
        resetUsers = true
        getUsers(page: 1)
    }
}

