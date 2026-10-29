//
//  GameViewModelTests.swift
//  TwentyNineTests
//
//  Created by Amit Sen on October 29, 2026.
//  © 2026 Coding With Amit. All rights reserved.

import Testing
@testable import TwentyNine

@MainActor
@Suite("GameViewModel Tests")
struct GameViewModelTests {
    @Test("New view model starts in setup with the given rules")
    func testInitialState() {
        let viewModel = GameViewModel(ruleConfiguration: .beginner)

        #expect(viewModel.state.gamePhase == .setup)
        #expect(viewModel.state.ruleConfiguration == .beginner)
        #expect(viewModel.selectedCardIDs.isEmpty)
        #expect(viewModel.errorMessage == nil)
    }

    @Test("Setting a rule updates the rule configuration")
    func testSetRule() {
        let viewModel = GameViewModel()
        #expect(viewModel.state.ruleConfiguration.jokerTrumpEnabled == false)

        viewModel.setRule(.jokerTrump, enabled: true)

        #expect(viewModel.state.ruleConfiguration.jokerTrumpEnabled)
    }

    @Test("Applying a preset replaces the configuration; custom keeps it")
    func testApplyPreset() {
        let viewModel = GameViewModel()

        viewModel.applyPreset(.beginner)
        #expect(viewModel.state.ruleConfiguration == .beginner)

        viewModel.applyPreset(.custom)
        #expect(viewModel.state.ruleConfiguration == .beginner)
    }

    @Test("Selecting and deselecting cards tracks stable card IDs")
    func testCardSelection() {
        let viewModel = GameViewModel()
        let card = Card(rank: .jack, suit: .spades)

        viewModel.selectCard(card.id)
        #expect(viewModel.selectedCardIDs == [card.id])

        viewModel.deselectAllCards()
        #expect(viewModel.selectedCardIDs.isEmpty)
    }

    @Test("Selecting trump records the suit and indicator card")
    func testSelectTrump() {
        let viewModel = GameViewModel()
        let indicator = Card(rank: .seven, suit: .hearts)

        viewModel.selectTrump(.hearts, indicatorCard: indicator)

        #expect(viewModel.state.trumpSuit == .hearts)
        #expect(viewModel.state.trumpIndicatorCard == indicator)
        #expect(viewModel.state.trumpRevealed == false)

        viewModel.requestTrumpReveal(by: .east)
        #expect(viewModel.state.trumpRevealed)
    }

    @Test("Clearing an error removes the message")
    func testClearError() {
        let viewModel = GameViewModel()
        viewModel.errorMessage = "Invalid bid"

        viewModel.clearError()

        #expect(viewModel.errorMessage == nil)
    }

    @Test("Exiting the game notifies the coordinator")
    func testExitGame() {
        var didExit = false
        let viewModel = GameViewModel(onExit: { didExit = true })

        viewModel.exitGame()

        #expect(didExit)
    }
}
