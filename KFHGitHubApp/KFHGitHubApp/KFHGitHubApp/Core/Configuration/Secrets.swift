//
//  Secrets.swift
//  KFHGitHubApp
//
//  Created by Haitham Gado on 27/08/2025.
//


import Foundation

enum Secrets {
    static var githubClientID: String {
        Bundle.main.infoDictionary?["GITHUB_CLIENT_ID"] as? String ?? ""
    }

    static var githubClientSecret: String {
        Bundle.main.infoDictionary?["GITHUB_CLIENT_SECRET"] as? String ?? ""
    }
}