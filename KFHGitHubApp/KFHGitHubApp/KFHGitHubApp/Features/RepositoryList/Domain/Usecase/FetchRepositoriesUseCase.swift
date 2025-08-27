//
//  FetchRepositoriesUseCase.swift
//  KFHGitHubApp
//
//  Created by Haitham Gado on 27/08/2025.
//


struct FetchRepositoriesUseCase {
    let repository: RepositoryListRepository

    init(repository: RepositoryListRepository) {
        self.repository = repository
    }

    func execute() async throws -> [Repository] {
        return try await repository.fetchRepositories()
    }
}
