//
// UsersView.swift
// TestTask
//
// Created by Oleg Zakladnyi on 15.06.2025

import SwiftUI
import Combine

struct UsersView: View {
    @StateObject private var viewModel = UsersViewModel()
    
    @State private var currentPage = 1
    
    var body: some View {
        VStack(spacing: 0) {
            CustomNavigationBar(title: "Working with GET request")
            
            Group {
                if let users = viewModel.usersData?.users, !users.isEmpty {
                    UsersListView(users: users,
                                  isLoadingMore: viewModel.isLoading,
                                  onReachedBottom: {
                        if let totalPages = viewModel.usersData?.pages,
                           currentPage < totalPages {
                            currentPage += 1
                            viewModel.getUsers(page: currentPage)
                        }
                    })
                } else {
                    NoUsersView()
                        .onAppear {
                            viewModel.getUsers()
                        }
                }
            }
        }
        .modifier(AlertViewModifier(alertState: $viewModel.alertState))
        .onReceive(NotificationCenter.default.publisher(for: .registrationSuccess)) { _ in
            viewModel.reset()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
