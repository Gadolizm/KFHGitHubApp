//
//  Branch.swift
//  KFHGitHubApp
//
//  Created by Haitham Gado on 27/08/2025.
//


import Foundation

struct Branch: Decodable, Identifiable {
    var id: String { name } // Use name as unique ID
    let name: String
    let protected: Bool
}
