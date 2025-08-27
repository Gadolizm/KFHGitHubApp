//
//  BranchListRepository.swift
//  KFHGitHubApp
//
//  Created by Haitham Gado on 27/08/2025.
//



import Foundation

protocol BranchListRepository {
    func fetchBranches(owner: String, repo: String) async throws -> [Branch]
}


