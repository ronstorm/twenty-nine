//
//  AppCoordinatorTests.swift
//  TwentyNineTests
//
//  Created by Amit Sen on October 29, 2026.
//  © 2026 Coding With Amit. All rights reserved.

import Testing
@testable import TwentyNine

@MainActor
@Suite("AppCoordinator Tests")
struct AppCoordinatorTests {
    @Test("Coordinator starts at the main menu with no game")
    func testInitialState() {
        let coordinator = AppCoordinator()

        #expect(coordinator.path.isEmpty)
        #expect(coordinator.gameViewModel == nil)
    }

    @Test("Starting a game from the main menu pushes the game table")
    func testStartGameFromMainMenu() {
        let coordinator = AppCoordinator()

        coordinator.mainMenuViewModel.startNewGame()

        #expect(coordinator.path == [.game])
        #expect(coordinator.gameViewModel != nil)
    }

    @Test("New games use the coordinator's rule configuration")
    func testStartGameUsesRules() {
        let coordinator = AppCoordinator()
        coordinator.ruleConfiguration = .bangladeshClassic

        coordinator.startNewGame()

        #expect(coordinator.gameViewModel?.state.ruleConfiguration == .bangladeshClassic)
    }

    @Test("Leaving the game returns to the main menu and releases the game")
    func testExitGame() {
        let coordinator = AppCoordinator()
        coordinator.startNewGame()

        coordinator.gameViewModel?.exitGame()

        #expect(coordinator.path.isEmpty)
        #expect(coordinator.gameViewModel == nil)
    }

    @Test("System back navigation also releases the game")
    func testBackNavigationReleasesGame() {
        let coordinator = AppCoordinator()
        coordinator.startNewGame()

        coordinator.path.removeLast()

        #expect(coordinator.gameViewModel == nil)
    }

    @Test("Starting another game replaces the previous one")
    func testStartingAgainCreatesFreshGame() throws {
        let coordinator = AppCoordinator()
        coordinator.startNewGame()
        let first = try #require(coordinator.gameViewModel)
        first.setRule(.jokerTrump, enabled: true)
        coordinator.endGame()

        coordinator.startNewGame()

        let second = try #require(coordinator.gameViewModel)
        #expect(second !== first)
        #expect(second.state.ruleConfiguration.jokerTrumpEnabled == false)
    }
}
