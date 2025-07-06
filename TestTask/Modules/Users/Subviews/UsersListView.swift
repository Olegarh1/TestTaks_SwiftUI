//
// UsersListView.swift
// TestTask
//
// Created by Oleg Zakladnyi on 15.06.2025

import SwiftUI

struct UsersListView: View {
    let users: [UserModel]
    let isLoadingMore: Bool
    let onReachedBottom: () -> Void
    
    @State private var bottomOffset: CGFloat = 0
    @State private var previousOffset: CGFloat = 0
    @State private var showLoader: Bool = false
    
    var body: some View {
        List {
            ForEach(users.indices, id: \.self) { index in
                let user = users[index]
                
                UserRowView(user: user)
                    .listRowSeparator(index == 0 ? .hidden : .visible, edges: .top)
            }
            
            if showLoader {
                HStack {
                    Spacer()
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                        .padding()
                        .clipShape(Circle())
                    Spacer()
                }
                .listRowSeparator(.hidden)
            }
            
            ScrollOffsetReader()
                .frame(height: 0)
                .listRowSeparator(.hidden)
        }
        .coordinateSpace(name: "scroll")
        .onChange(of: isLoadingMore) { newValue, _ in
            if newValue {
                withAnimation {
                    showLoader = false
                }
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation {
                        showLoader = false
                    }
                }
            }
        }

        .onPreferenceChange(ScrollOffsetPreferenceKey.self) { newValue in
                    previousOffset = bottomOffset
                    bottomOffset = newValue

                    let screenHeight = UIScreen.main.bounds.height
                    let distanceToBottom = screenHeight - bottomOffset

                    if previousOffset > bottomOffset, distanceToBottom == screenHeight {
                        showLoader = true
                        onReachedBottom()
                    }
                }
        .listStyle(.plain)
        .scrollIndicators(.hidden)
    }
}

struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}


struct ScrollOffsetReader: View {
    var body: some View {
        GeometryReader { geometry in
            Color.clear
                .preference(key: ScrollOffsetPreferenceKey.self,
                            value: geometry.frame(in: .global).minY)
        }
        .frame(height: 0)
    }
}
