//
//  FetchBranchesUseCase.swift
//  KFHGitHubApp
//
//  Created by Haitham Gado on 27/08/2025.
//


struct FetchBranchesUseCase {
    private let repository: BranchListRepository

    init(repository: BranchListRepository) {
        self.repository = repository
    }

    func execute(owner: String, repo: String) async throws -> [Branch] {
        return try await repository.fetchBranches(owner: owner, repo: repo)
    }
}