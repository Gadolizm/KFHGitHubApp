//
//  BranchListRepositoryImpl.swift
//  KFHGitHubApp
//
//  Created by Haitham Gado on 27/08/2025.
//


import Foundation

final class BranchListRepositoryImpl: BranchListRepository {
    private let api: GitHubAPI

    init(api: GitHubAPI) {
        self.api = api
    }

    func fetchBranches(owner: String, repo: String) async throws -> [Branch] {
        return try await api.fetchBranches(owner: owner, repo: repo)
    }
}
