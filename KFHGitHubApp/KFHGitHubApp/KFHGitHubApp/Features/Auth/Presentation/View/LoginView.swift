//
//  LoginView.swift
//  KFHGitHubApp
//
//  Created by Haitham Gado on 27/08/2025.
//

import SwiftUI


struct LoginView: View {
    @StateObject private var viewModel = AuthViewModel()
    @Binding var isAuthenticated: Bool

    var body: some View {
        VStack(spacing: 16) {
            Text("Login with GitHub")
                .font(.title)

            Button("Login") {
                Task {
                    await viewModel.login()
                    if viewModel.isLoggedIn {
                        isAuthenticated = true
                    }
                }
            }
            .accessibilityIdentifier("loginButton")
            .buttonStyle(.borderedProminent)

            if let error = viewModel.loginError {
                Text(error)
                    .foregroundColor(.red)
            }
        }
        .padding()
    }
}
