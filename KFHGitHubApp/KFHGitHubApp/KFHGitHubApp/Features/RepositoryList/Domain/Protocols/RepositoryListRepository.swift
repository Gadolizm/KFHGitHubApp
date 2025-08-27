//
//  RepositoryListRepository.swift
//  KFHGitHubApp
//
//  Created by Haitham Gado on 27/08/2025.
//


// FetchRepositoriesUseCase.swift
// Use case for fetching repositories

import Foundation

protocol RepositoryListRepository {
    func fetchRepositories() async throws -> [Repository]
}
