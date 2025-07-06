//
// UserRowView.swift
// TestTask
//
// Created by Oleg Zakladnyi on 06.07.2025

import SwiftUI

struct UserRowView: View {
    let user: UserModel
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            AsyncImage(url: URL(string: user.photo ?? "")) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 50, height: 50)
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                case .failure:
                    Image(systemName: "person.fill")
                        .resizable()
                        .foregroundColor(.gray)
                        .frame(width: 50, height: 50)
                @unknown default:
                    EmptyView()
                }
            }

            VStack(alignment: .leading, spacing: 4) {
                if let name = user.name {
                    Text(name)
                        .font(.custom("Nunito-Regular", size: 18))
                }
                if let position = user.position {
                    Text(position)
                        .font(.custom("Nunito-Regular", size: 14))
                        .foregroundColor(.black.opacity(0.6))
                        .padding(.bottom, 4)
                }
                if let email = user.email {
                    Text(email)
                        .font(.custom("Nunito-Regular", size: 14))
                }
                if let phone = user.phone {
                    Text(phone)
                        .font(.custom("Nunito-Regular", size: 14))
                }
            }
        }
        .padding(.vertical, 12)
    }
}
