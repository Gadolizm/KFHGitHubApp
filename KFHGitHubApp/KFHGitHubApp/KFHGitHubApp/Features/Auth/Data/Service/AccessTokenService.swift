//
//  AccessTokenService.swift
//  KFHGitHubApp
//
//  Created by Haitham Gado on 27/08/2025.
//


import Foundation


final class AccessTokenService {
    
    private let session: URLSession
    private let clientId: String
    private let clientSecret: String
    
    init(
        session: URLSession = .shared,
        clientId: String = Secrets.githubClientID,
        clientSecret: String = Secrets.githubClientSecret
    ) {
        self.session = session
        self.clientId = clientId
        self.clientSecret = clientSecret
    }
    
    func exchangeCodeForToken(code: String) async throws -> String {
        guard let url = URL(string: "https://github.com/login/oauth/access_token") else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: String] = [
            "client_id": clientId,
            "client_secret": clientSecret,
            "code": code
        ]

        request.httpBody = try JSONEncoder().encode(body)
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }

        guard httpResponse.statusCode == 200 else {
            let errorBody = String(data: data, encoding: .utf8) ?? "No response body"
            print("[AccessTokenService] Error response: \(httpResponse.statusCode) - \(errorBody)")
            throw URLError(.badServerResponse)
        }

        do {
            let decoded = try JSONDecoder().decode(AccessTokenResponse.self, from: data)
            return decoded.access_token
        } catch {
            print("[AccessTokenService] Decoding error: \(error)")
            throw error
        }
    }
}
