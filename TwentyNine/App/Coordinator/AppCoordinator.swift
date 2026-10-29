//
//  AppCoordinator.swift
//  TwentyNine
//
//  Created by Amit Sen on October 29, 2026.
//  © 2026 Coding With Amit. All rights reserved.

import Foundation
import Observation

/// Screens that can be pushed onto the navigation stack.
///
/// Add a case per new screen (settings, tutorial, ...) and handle it in
/// `AppCoordinatorView.destination(for:)`.
enum AppRoute: Hashable {
    case game
}

/// Owns navigation and builds view models for every screen.
///
/// View models never navigate themselves: they report user intent through
/// callbacks, and the coordinator updates `path`. This keeps screens
/// independent of each other and makes navigation testable without views.
@MainActor
@Observable
final class AppCoordinator {
    // MARK: - Navigation State

    /// The navigation stack, bound to `NavigationStack(path:)`.
    var path: [AppRoute] = [] {
        didSet {
            // The system back button pops `path` directly, so release the game
            // here as well as in `endGame()`.
            if !path.contains(.game) {
                gameViewModel = nil
            }
        }
    }

    /// View model for the root main menu screen.
    @ObservationIgnored private(set) lazy var mainMenuViewModel = MainMenuViewModel { [weak self] in
        self?.startNewGame()
    }

    /// View model for the game in progress, if any.
    private(set) var gameViewModel: GameViewModel?

    /// Rules used for the next new game.
    var ruleConfiguration = RuleConfiguration()

    // MARK: - Dependencies

    @ObservationIgnored private let dependencies: AppDependencies

    // MARK: - Initialization

    init(dependencies: AppDependencies = .live) {
        self.dependencies = dependencies
    }

    // MARK: - Navigation

    /// Creates a fresh game and pushes the game table.
    func startNewGame() {
        gameViewModel = GameViewModel(
            ruleConfiguration: ruleConfiguration,
            dependencies: dependencies,
            onExit: { [weak self] in self?.endGame() }
        )
        path.append(.game)
    }

    /// Ends the current game and returns to the main menu.
    func endGame() {
        popToRoot()
    }

    /// Returns to the main menu.
    func popToRoot() {
        path.removeAll()
    }
}
