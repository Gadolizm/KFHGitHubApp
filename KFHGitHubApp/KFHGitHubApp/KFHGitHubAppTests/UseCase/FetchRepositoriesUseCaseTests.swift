//
//  FetchRepositoriesUseCaseTests.swift
//  KFHGitHubApp
//
//  Created by Haitham Gado on 27/08/2025.
//


import XCTest
@testable import KFHGitHubApp

final class FetchRepositoriesUseCaseTests: XCTestCase {

    func testExecute_ReturnsRepositories() async throws {
        let dummyRepos = [
            Repository(id: 1, name: "Repo1", isPrivate: false, stargazersCount: 42, updatedAt: "2023-01-01T00:00:00Z", language: "Swift"),
            Repository(id: 2, name: "Repo2", isPrivate: true, stargazersCount: 0, updatedAt: "2023-01-02T00:00:00Z", language: "Kotlin")
        ]
        let mockRepo = RepositoryListRepositoryMock(repos: dummyRepos)
        let useCase = FetchRepositoriesUseCase(repository: mockRepo)

        let result = try await useCase.execute()

        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(result.first?.name, "Repo1")
    }
}

final class RepositoryListRepositoryMock: RepositoryListRepository {
    let repos: [Repository]

    init(repos: [Repository]) {
        self.repos = repos
    }

    func fetchRepositories() async throws -> [Repository] {
        return repos
    }
}
