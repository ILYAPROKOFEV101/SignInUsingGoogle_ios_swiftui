//
//  Home.swift
//  SignInUsingGoogle
//
//  Created by Swee Kwang Chua on 12/5/22.
//

import SwiftUI
import GoogleSignIn
import SDWebImageSwiftUI // Используйте эту библиотеку для загрузки изображений из URL

struct Home: View {
    @State private var userName: String = ""
    @State private var userProfileImageURL: URL? = nil

    var body: some View {
        VStack {
            if let imageURL = userProfileImageURL {
                WebImage(url: imageURL)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                    .padding()
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.gray)
                    .padding()
            }

            Text(userName.isEmpty ? "User" : userName)
                .font(.title)
                .padding()

            Button(action: {
                signOut()
            }) {
                Text("Sign Out")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(10)
            }
            .padding()
        }
        .onAppear {
            fetchUserInfo()
        }
    }

    // Функция для получения информации о пользователе
    func fetchUserInfo() {
        let userInfo = FirebAuth.share.getCurrentUserInfo()

        if let name = userInfo.name {
            userName = name
        }

        if let profileImageURL = userInfo.profileImageURL {
            userProfileImageURL = profileImageURL
        }
    }

    // Функция для обработки выхода из системы
    func signOut() {
        FirebAuth.share.signOut { error in
            if let error = error {
                // Обработка ошибки при выходе
                print("Failed to sign out: \(error.localizedDescription)")
            } else {
                // Успешный выход
                print("Successfully signed out")
                // Обновите UI или перейдите на экран входа
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
