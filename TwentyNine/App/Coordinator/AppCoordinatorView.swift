//
//  AppCoordinatorView.swift
//  TwentyNine
//
//  Created by Amit Sen on October 29, 2026.
//  © 2026 Coding With Amit. All rights reserved.

import SwiftUI

/// Root navigation container that renders the coordinator's stack.
struct AppCoordinatorView: View {
    @Bindable var coordinator: AppCoordinator

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            MainMenuView(viewModel: coordinator.mainMenuViewModel)
                .navigationDestination(for: AppRoute.self) { route in
                    destination(for: route)
                }
        }
    }

    @ViewBuilder
    private func destination(for route: AppRoute) -> some View {
        switch route {
        case .game:
            if let viewModel = coordinator.gameViewModel {
                GameTableView(viewModel: viewModel)
            }
        }
    }
}

#Preview {
    AppCoordinatorView(coordinator: AppCoordinator())
}
