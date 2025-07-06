//
// NoUsersView.swift
// TestTask
//
// Created by Oleg Zakladnyi on 15.06.2025

import SwiftUI

struct NoUsersView: View {
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            VStack(spacing: 24) {
                Image("usersCircled")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                
                Text("There are no users yet")
                    .font(.setFont(.nunitoRegular, size: 20))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
            }
        }
    }
}
