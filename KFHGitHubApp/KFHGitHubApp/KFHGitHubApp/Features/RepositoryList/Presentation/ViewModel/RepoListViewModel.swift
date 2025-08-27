//
//  RepoListViewModel.swift
//  KFHGitHubApp
//
//  Created by Haitham Gado on 27/08/2025.
//


import Foundation

@MainActor
final class RepoListViewModel: ObservableObject {
    @Published var repositories: [Repository] = []
    @Published var searchText: String = ""
    @Published var errorMessage: String?
    @Published var isLoading = false
    @Published var username: String?
    
    init(useCase: FetchRepositoriesUseCase) {
        self.fetchRepositoriesUseCase = useCase
    }
    
    var filteredRepositories: [Repository] {
        if searchText.isEmpty {
            return repositories
        } else {
            return repositories.filter {
                $0.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    private let fetchRepositoriesUseCase: FetchRepositoriesUseCase
    

    
    func fetchRepositories() async {
        isLoading = true
        defer {
            isLoading = false
        }
        
        do {
            let repos = try await fetchRepositoriesUseCase.execute()
            repositories = repos
            
            if username == nil,
               let repoImpl = fetchRepositoriesUseCase.repository as? RepositoryListRepositoryImpl {
                let user = try await repoImpl.api.fetchAuthenticatedUser()
                username = user.login
            }
            
        } catch {
            errorMessage = "Failed to load repositories"
        }
    }
}
