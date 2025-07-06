//
// NetworkOverlayManager.swift
// TestTask
//
// Created by Oleg Zakladnyi on 22.06.2025

import SwiftUI
import UIKit

final class NetworkOverlayManager: ObservableObject {
    static let shared = NetworkOverlayManager()

    private var overlayWindow: UIWindow?

    private var currentScene: UIWindowScene? {
        let scenes = UIApplication.shared.connectedScenes.compactMap { $0 as? UIWindowScene }
        
        if let active = scenes.first(where: { $0.activationState == .foregroundActive }) {
            return active
        }
        
        if let inactive = scenes.first(where: { $0.activationState == .foregroundInactive }) {
            return inactive
        }
        
        return scenes.first
    }

    func showOverlay() {
        guard overlayWindow == nil else { return }
        
        guard let windowScene = currentScene else {
            print("❗️No active windowScene found")
            return
        }
        
        let overlayVC = UIHostingController(rootView: NetworkConnectionView())
        overlayVC.modalPresentationStyle = .fullScreen
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = overlayVC
        window.windowLevel = UIWindow.Level.statusBar + 1
        window.makeKeyAndVisible()
        
        overlayWindow = window
    }

    func hideOverlay() {
        overlayWindow?.isHidden = true
        overlayWindow = nil
    }
}
