//
//  AccessTokenResponse.swift
//  KFHGitHubApp
//
//  Created by Haitham Gado on 27/08/2025.
//


struct AccessTokenResponse: Decodable {
    let access_token: String
    let token_type: String
    let scope: String
}