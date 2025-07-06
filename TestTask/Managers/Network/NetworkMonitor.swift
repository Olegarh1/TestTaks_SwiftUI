//
// NetworkMonitor.swift
// TestTask
//
// Created by Oleg Zakladnyi on 22.06.2025

import Network
import Combine
import SwiftUI

final class NetworkMonitor: ObservableObject {
    
    static let shared = NetworkMonitor()
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")
    
    @Published private(set) var isConnected: Bool = false
    
    private var onConnectActions: [() -> Void] = []

    private init() {
        startMonitoring()
    }

    private func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                guard let self = self else { return }
                let wasConnected = self.isConnected
                self.isConnected = path.status == .satisfied
                
                if self.isConnected {
                    NetworkOverlayManager.shared.hideOverlay()
                    
                    if !wasConnected {
                        let actions = self.onConnectActions
                        self.onConnectActions.removeAll()
                        actions.forEach { $0() }
                    }
                } else {
                    NetworkOverlayManager.shared.showOverlay()
                }
            }
        }
        monitor.start(queue: queue)
    }

    /// Виконує дію одразу або зберігає до появи підключення
    func runWhenConnected(_ action: @escaping () -> Void) {
        if isConnected {
            action()
        } else {
            onConnectActions.append(action)
        }
    }
}

