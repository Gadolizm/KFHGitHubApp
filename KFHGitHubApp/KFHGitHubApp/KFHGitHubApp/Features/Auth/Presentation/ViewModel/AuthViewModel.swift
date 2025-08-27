//
//  AuthViewModel.swift
//  KFHGitHubApp
//
//  Created by Haitham Gado on 27/08/2025.
//

import Combine


@MainActor
final class AuthViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var loginError: String?

    private let loginUseCase: LoginUseCase

    init(useCase: LoginUseCase = LoginUseCase(repository: AuthRepositoryImpl())) {
        self.loginUseCase = useCase
    }

    func login() async {
        do {
            try await loginUseCase.execute()
            isLoggedIn = true
        } catch {
            loginError = error.localizedDescription
            print("[AuthViewModel] Login error: \(error)")
        }
    }
}
