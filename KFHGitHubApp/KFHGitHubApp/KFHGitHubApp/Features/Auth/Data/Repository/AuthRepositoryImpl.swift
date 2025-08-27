//
//  AuthRepositoryImpl.swift
//  KFHGitHubApp
//
//  Created by Haitham Gado on 27/08/2025.
//


import Foundation

final class AuthRepositoryImpl: AuthRepository {
    private let authService: GitHubAuthService
    private let tokenService: AccessTokenService

    init(
        authService: GitHubAuthService = GitHubAuthService(),
        tokenService: AccessTokenService = AccessTokenService()
    ) {
        self.authService = authService
        self.tokenService = tokenService
    }

    func login() async throws {
        let code = try await withCheckedThrowingContinuation { continuation in
            authService.login { result in
                switch result {
                case .success(let code):
                    continuation.resume(returning: code)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }

        let token = try await tokenService.exchangeCodeForToken(code: code)
        KeychainHelper.shared.saveToken(token)
    }
}
