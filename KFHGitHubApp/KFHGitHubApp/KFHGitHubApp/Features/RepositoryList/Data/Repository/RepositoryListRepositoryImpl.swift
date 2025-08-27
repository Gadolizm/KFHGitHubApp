//
//  RepositoryListRepositoryImpl.swift
//  KFHGitHubApp
//
//  Created by Haitham Gado on 27/08/2025.
//


import Foundation

final class RepositoryListRepositoryImpl: RepositoryListRepository {
    let api: GitHubAPI

    init(api: GitHubAPI) {
        self.api = api
    }

    func fetchRepositories() async throws -> [Repository] {
        return try await api.fetchRepositories()
    }
}
