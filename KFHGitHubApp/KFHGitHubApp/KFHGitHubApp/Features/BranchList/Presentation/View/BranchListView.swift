//
//  BranchListView.swift
//  KFHGitHubApp
//
//  Created by Haitham Gado on 27/08/2025.
//


import SwiftUI

struct BranchListView: View {
    @StateObject var viewModel: BranchListViewModel

    var body: some View {
        List {
            if viewModel.isLoading {
                ProgressView("Loading branches...")
            } else if let error = viewModel.errorMessage {
                Text(error).foregroundColor(.red)
            } else {
                ForEach(viewModel.branches) { branch in
                    HStack {
                        Text(branch.name)
                            .font(.body)

                        if branch.protected {
                            Text("🛡 Protected")
                                .font(.caption)
                                .foregroundColor(.green)
                                .padding(.leading, 8)
                        }
                    }
                }
            }
        }
        .navigationTitle("Branches")
        .task {
            await viewModel.fetchBranches()
        }
    }
}
