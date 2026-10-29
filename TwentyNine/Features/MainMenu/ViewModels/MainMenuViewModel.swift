//
//  MainMenuViewModel.swift
//  TwentyNine
//
//  Created by Amit Sen on October 29, 2026.
//  © 2026 Coding With Amit. All rights reserved.

import Foundation
import Observation

/// Presentation logic for the main menu.
///
/// Menu choices are reported to the coordinator through callbacks, so the
/// menu never constructs or pushes other screens itself.
@MainActor
@Observable
final class MainMenuViewModel {
    @ObservationIgnored private let onStartGame: @MainActor () -> Void

    /// Creates the main menu view model.
    /// - Parameter onStartGame: Called when the player starts a new game
    init(onStartGame: @escaping @MainActor () -> Void) {
        self.onStartGame = onStartGame
    }

    /// Starts a new game.
    func startNewGame() {
        onStartGame()
    }
}
