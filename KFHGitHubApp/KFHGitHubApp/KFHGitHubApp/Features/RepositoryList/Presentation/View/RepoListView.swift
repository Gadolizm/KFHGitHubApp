//
//  RepoListView.swift
//  KFHGitHubApp
//
//  Created by Haitham Gado on 27/08/2025.
//


import SwiftUI

struct RepoListView: View {
    @ObservedObject var viewModel: RepoListViewModel
    @State private var selectedRepo: Repository? = nil
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading repositories...")
                } else if let error = viewModel.errorMessage {
                    Text(error).foregroundColor(.red)
                } else {
                    List(viewModel.filteredRepositories) { repo in
                        Button {
                            selectedRepo = repo
                        } label: {
                            VStack(alignment: .leading) {
                                Text(repo.name).font(.headline)
                                if let language = repo.language {
                                    Text(language)
                                        .font(.caption2)
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 4)
                                        .background(Color.blue.opacity(0.1))
                                        .foregroundColor(.blue)
                                        .clipShape(Capsule())
                                }
                                Text(repo.isPrivate ? "Private" : "Public")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                Text("⭐️ \(repo.stargazersCount)")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    .refreshable {
                        await viewModel.fetchRepositories()
                    }
                }
            }
            .navigationTitle("My Repositories")
            .searchable(text: $viewModel.searchText)
            .task {
                await viewModel.fetchRepositories()
            }
            .navigationDestination(item: $selectedRepo) { repo in
                if let username = viewModel.username {
                    let api = GitHubAPI(token: KeychainHelper.shared.getToken() ?? "")
                    let branchRepo = BranchListRepositoryImpl(api: api)
                    let useCase = FetchBranchesUseCase(repository: branchRepo)
                    let branchVM = BranchListViewModel(useCase: useCase, owner: username, repo: repo.name)
                    
                    BranchListView(viewModel: branchVM)
                } else {
                    Text("Fetching user info...")
                }
            }
        }
        .accessibilityIdentifier("repoListScreen")
    }
}
