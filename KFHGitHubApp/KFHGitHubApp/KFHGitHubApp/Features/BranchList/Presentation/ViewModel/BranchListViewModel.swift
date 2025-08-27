//
//  BranchListViewModel.swift
//  KFHGitHubApp
//
//  Created by Haitham Gado on 27/08/2025.
//



import Foundation

@MainActor
final class BranchListViewModel: ObservableObject {
    @Published var branches: [Branch] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let fetchBranchesUseCase: FetchBranchesUseCase
    private let owner: String
    private let repo: String

    init(useCase: FetchBranchesUseCase, owner: String, repo: String) {
        self.fetchBranchesUseCase = useCase
        self.owner = owner
        self.repo = repo
    }

    func fetchBranches() async {
        isLoading = true
        defer { isLoading = false }

        do {
            branches = try await fetchBranchesUseCase.execute(owner: owner, repo: repo)
        } catch {
            errorMessage = "Failed to load branches"
        }
    }
}
