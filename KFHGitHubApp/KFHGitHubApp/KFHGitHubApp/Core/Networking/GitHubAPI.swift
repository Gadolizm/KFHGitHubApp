//
//  GitHubAPI.swift
//  KFHGitHubApp
//
//  Created by Haitham Gado on 27/08/2025.
//

import Foundation


final class GitHubAPI {
    private let token: String
    private let baseURL = URL(string: "https://api.github.com")!

    init(token: String) {
        self.token = token
    }

    func fetchRepositories() async throws -> [Repository] {
        let url = baseURL.appendingPathComponent("user/repos")
        var request = URLRequest(url: url)
        request.setValue("token \(token)", forHTTPHeaderField: "Authorization")

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        return try JSONDecoder().decode([Repository].self, from: data)
    }

    func fetchBranches(owner: String, repo: String) async throws -> [Branch] {
        let url = baseURL
            .appendingPathComponent("repos")
            .appendingPathComponent(owner)
            .appendingPathComponent(repo)
            .appendingPathComponent("branches")

        var request = URLRequest(url: url)
        request.setValue("token \(token)", forHTTPHeaderField: "Authorization")

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        return try JSONDecoder().decode([Branch].self, from: data)
    }
}

extension GitHubAPI {
    func fetchAuthenticatedUser() async throws -> GitHubUser {
        let url = baseURL.appendingPathComponent("user")
        var request = URLRequest(url: url)
        request.setValue("token \(token)", forHTTPHeaderField: "Authorization")

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        return try JSONDecoder().decode(GitHubUser.self, from: data)
    }
}
