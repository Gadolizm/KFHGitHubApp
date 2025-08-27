//
//  LoginUseCase.swift
//  KFHGitHubApp
//
//  Created by Haitham Gado on 27/08/2025.
//


struct LoginUseCase {
    private let repository: AuthRepository

    init(repository: AuthRepository) {
        self.repository = repository
    }

    func execute() async throws {
        try await repository.login()
    }
}
