//
//  Repository.swift
//  KFHGitHubApp
//
//  Created by Haitham Gado on 27/08/2025.
//


import Foundation

struct Repository: Identifiable, Decodable, Hashable {
    let id: Int
    let name: String
    let isPrivate: Bool
    let stargazersCount: Int
    let updatedAt: String
    let language: String?

    enum CodingKeys: String, CodingKey {
        case id, name, language
        case isPrivate = "private"
        case stargazersCount = "stargazers_count"
        case updatedAt = "updated_at"
    }
}
