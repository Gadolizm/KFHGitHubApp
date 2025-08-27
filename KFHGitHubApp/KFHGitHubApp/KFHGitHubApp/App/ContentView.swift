//
//  ContentView.swift
//  KFHGitHubApp
//
//  Created by Haitham Gado on 27/08/2025.
//
import SwiftUI

struct ContentView: View {
    @State private var isAuthenticated: Bool = false
    
    var body: some View {
        NavigationStack {
            Group {
                if isAuthenticated {
                    authenticatedView()
                        .accessibilityIdentifier("repoListScreen")
                } else {
                    LoginView(isAuthenticated: $isAuthenticated)
                }
            }
            .toolbar {
                if isAuthenticated {
                    Button("Logout", role: .destructive) {
                        logout()
                    }
                }
            }
        }
        .onAppear {
            checkAuth()
        }
    }
    
    @ViewBuilder
    private func authenticatedView() -> some View {
        let token = KeychainHelper.shared.getToken() ?? ""
        let api = GitHubAPI(token: token)
        let repo = RepositoryListRepositoryImpl(api: api)
        let useCase = FetchRepositoriesUseCase(repository: repo)
        
        RepoListScene(useCase: useCase)
    }
    
    
    private func logout() {
        KeychainHelper.shared.clearToken()
        isAuthenticated = false
    }
    
    private func checkAuth() {
        #if DEBUG
        if ProcessInfo.processInfo.environment["mock_token"] == "true" {
            KeychainHelper.shared.saveToken("mock_token")
        }
        #endif
        
        isAuthenticated = KeychainHelper.shared.getToken() != nil
    }
}
