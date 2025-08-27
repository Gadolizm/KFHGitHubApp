//
//  RepoListViewModelTests.swift
//  KFHGitHubApp
//
//  Created by Haitham Gado on 27/08/2025.
//


import XCTest
@testable import KFHGitHubApp

final class RepoListViewModelTests: XCTestCase {

    func testSearchFiltersRepositories() async {
        let repos = [
            Repository(id: 1, name: "iOSApp", isPrivate: false, stargazersCount: 3, updatedAt: "", language: "Swift"),
            Repository(id: 2, name: "AndroidApp", isPrivate: false, stargazersCount: 1, updatedAt: "", language: "Kotlin")
        ]
        let mockRepo = RepositoryListRepositoryMock(repos: repos)
        let useCase = FetchRepositoriesUseCase(repository: mockRepo)
        let viewModel = await RepoListViewModel(useCase: useCase)

        await viewModel.fetchRepositories()

        // Interact with MainActor-isolated properties
        await MainActor.run {
            viewModel.searchText = "iOS"
            XCTAssertEqual(viewModel.filteredRepositories.count, 1)
            XCTAssertEqual(viewModel.filteredRepositories.first?.name, "iOSApp")
        }
    }
}
