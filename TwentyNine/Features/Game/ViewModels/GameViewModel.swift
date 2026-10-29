//
//  GameViewModel.swift
//  TwentyNine
//
//  Created by Amit Sen on October 29, 2026.
//  © 2026 Coding With Amit. All rights reserved.

import Foundation
import Observation

/// Presentation logic for a single game of TwentyNine.
///
/// The view model owns the `GameState`, applies player intents through the
/// game-logic services, and exposes UI-only state to `GameTableView`.
/// It knows nothing about navigation: leaving the game is reported through
/// `onExit`, and the coordinator decides where to go next.
@MainActor
@Observable
final class GameViewModel {
    // MARK: - State

    /// The domain state of the game in progress.
    private(set) var state: GameState

    /// Cards the human player has highlighted in their hand.
    private(set) var selectedCardIDs: Set<Card.ID> = []

    /// Whether an intent is being processed (prevents double-taps).
    private(set) var isProcessing = false

    /// Error message to display, if any. Settable so an alert binding can dismiss it.
    var errorMessage: String?

    // MARK: - Dependencies

    @ObservationIgnored private let dependencies: AppDependencies
    @ObservationIgnored private let onExit: @MainActor () -> Void

    // MARK: - Initialization

    /// Creates a view model for a new game.
    /// - Parameters:
    ///   - ruleConfiguration: Rules for this game
    ///   - dependencies: Game-logic services
    ///   - onExit: Called when the player leaves the game
    init(
        ruleConfiguration: RuleConfiguration = RuleConfiguration(),
        dependencies: AppDependencies = .live,
        onExit: @escaping @MainActor () -> Void = {}
    ) {
        self.state = GameState(ruleConfiguration: ruleConfiguration)
        self.dependencies = dependencies
        self.onExit = onExit
    }

    // MARK: - Game Flow

    /// Starts a new game with the given rule configuration.
    func startNewGame(with ruleConfiguration: RuleConfiguration) {
        // TODO: Implement in Stage 2.5 (reset players, deal first cards)
        state.ruleConfiguration = ruleConfiguration
        state.gamePhase = .setup
    }

    /// Deals cards to players (first or second deal).
    func dealCards() {
        // TODO: Implement in Stage 2.5
    }

    /// Advances to the next game phase.
    func advancePhase() {
        // TODO: Implement in Stage 2.5
    }

    /// Cancels the current round and returns to setup.
    func cancelGame() {
        state.gamePhase = .setup
    }

    /// Starts a new round after scoring.
    func startNewRound() {
        // TODO: Implement in Stage 2.5
    }

    /// Leaves the game; the coordinator decides where to navigate.
    func exitGame() {
        onExit()
    }

    // MARK: - Bidding

    /// Places a bid (16-28) for the given player.
    func placeBid(_ amount: Int, from position: Position) {
        // TODO: Implement in Stage 2.3
    }

    /// Passes during the bidding phase.
    func passBid(from position: Position) {
        // TODO: Implement in Stage 2.3
    }

    /// Selects the trump suit (by highest bidder).
    func selectTrump(_ suit: Suit, indicatorCard: Card) {
        // TODO: Validate bidder and phase in Stage 2.4
        state.trumpSuit = suit
        state.trumpIndicatorCard = indicatorCard
    }

    // MARK: - Card Playing

    /// Highlights a card in the player's hand.
    func selectCard(_ cardID: Card.ID) {
        selectedCardIDs.insert(cardID)
    }

    /// Clears all highlighted cards.
    func deselectAllCards() {
        selectedCardIDs.removeAll()
    }

    /// Plays a card from the given player's hand.
    func playCard(_ cardID: Card.ID, from position: Position) {
        // TODO: Implement in Stage 2.6
    }

    /// Reveals the trump suit at a player's request.
    func requestTrumpReveal(by position: Position) {
        // TODO: Enforce must-play-trump for the requester in Stage 2.6 (BUG-004)
        state.trumpRevealed = true
    }

    // MARK: - Marriage & Double

    /// Declares marriage (K+Q of trump).
    func declareMarriage(by position: Position) {
        // TODO: Implement in Stage 5.2
    }

    /// Doubles the bid (opponent team challenges).
    func doubleBid(by position: Position) {
        // TODO: Validate team and rule in Stage 5.3
        state.isDoubled = true
    }

    /// Re-doubles the bid (bidder counters double).
    func reDoubleBid(by position: Position) {
        // TODO: Validate team and rule in Stage 5.3
        state.isReDoubled = true
    }

    // MARK: - AI

    /// Lets an AI player take its turn.
    func performAITurn(for position: Position) async {
        // TODO: Implement in Stage 3.1
    }

    // MARK: - Scoring

    /// Calculates scores for the current round.
    func calculateScore() {
        // TODO: Implement in Stage 2.6
    }

    /// Updates game points (red/black 6s) after scoring.
    func updateGamePoints() {
        // TODO: Implement in Stage 2.6
    }

    // MARK: - Rules

    /// Enables or disables a single rule.
    func setRule(_ rule: GameRule, enabled: Bool) {
        state.ruleConfiguration[rule] = enabled
    }

    /// Applies a rule preset; `.custom` keeps the current configuration.
    func applyPreset(_ preset: RulePreset) {
        if let configuration = preset.configuration {
            state.ruleConfiguration = configuration
        }
    }

    // MARK: - Errors

    /// Clears the current error message.
    func clearError() {
        errorMessage = nil
    }

    // MARK: - Persistence

    /// Saves the current game state.
    func saveGame() {
        // TODO: Implement in Stage 8.1
    }

    /// Loads a saved game state.
    func loadGame() {
        // TODO: Implement in Stage 8.1
    }

    /// Deletes the saved game state.
    func deleteSavedGame() {
        // TODO: Implement in Stage 8.1
    }
}
