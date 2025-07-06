//
// ContentView.swift
// TestTask
//
// Created by Oleg Zakladnyi on 05.07.2025

import SwiftUI

struct ContentView: View {
    @State private var selectedIndex: Int = TabsManager.default.tabBarSelectedIndex
   
    private let tabs = [
        (title: "Users", imageName: "Users"),
        (title: "Sign up", imageName: "SignUp")
    ]

    var body: some View {
        VStack(spacing: 0) {
            Group {
                switch selectedIndex {
                case 0: UsersView()
                case 1: SignUpView()
                default: Text("Not found")
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            TabBarView(selectedIndex: $selectedIndex, tabs: tabs)
        }
        .onChange(of: selectedIndex) {
            TabsManager.default.tabBarSelectedIndex = selectedIndex
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    ContentView()
}
