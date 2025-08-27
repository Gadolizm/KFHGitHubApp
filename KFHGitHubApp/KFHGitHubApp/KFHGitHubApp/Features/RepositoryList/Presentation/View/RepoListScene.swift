//
//  RepoListScene.swift
//  KFHGitHubApp
//
//  Created by Haitham Gado on 27/08/2025.
//


import SwiftUI

struct RepoListScene: View {
    @StateObject private var viewModel: RepoListViewModel

    init(useCase: FetchRepositoriesUseCase) {
        _viewModel = StateObject(wrappedValue: RepoListViewModel(useCase: useCase))
    }

    var body: some View {
        NavigationStack {
            RepoListView(viewModel: viewModel)
        }
    }
}
