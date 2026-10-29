//
//  GameAction.swift
//  TwentyNine
//
//  Created by Amit Sen on November 24, 2025.
//  © 2025 Coding With Amit. All rights reserved.

import Foundation

/// All possible actions that can be performed in the game.
///
/// Actions are dispatched from the UI or system and processed by the reducer
/// to update the game state.
indirect enum GameAction: Equatable, Sendable {
    // MARK: - Game Flow
    
    /// Start a new game with the given rule configuration.
    case startNewGame(ruleConfiguration: RuleConfiguration)
    
    /// Deal cards to players (first or second deal).
    case dealCards
    
    /// Advance to the next game phase.
    case nextPhase
    
    /// Cancel the current game and return to setup.
    case cancelGame
    
    // MARK: - Bidding
    
    /// Place a bid with the specified amount (16-28).
    case placeBid(amount: Int, playerPosition: Position)
    
    /// Pass during bidding phase.
    case passBid(playerPosition: Position)
    
    /// Select trump suit (by highest bidder).
    case selectTrump(suit: Suit, indicatorCard: Card)
    
    // MARK: - Card Playing
    
    /// Select a card (for UI highlighting).
    case selectCard(cardId: Card.ID)
    
    /// Deselect all cards.
    case deselectCards
    
    /// Play a card from hand.
    case playCard(cardId: Card.ID, playerPosition: Position)
    
    /// Request to reveal the trump suit.
    case requestTrumpReveal(playerPosition: Position)
    
    // MARK: - Marriage
    
    /// Declare marriage (K+Q of trump).
    case declareMarriage(playerPosition: Position)
    
    // MARK: - Double/Re-Double
    
    /// Double the bid (opponent team challenges).
    case doubleBid(playerPosition: Position)
    
    /// Re-double the bid (bidder counters double).
    case reDoubleBid(playerPosition: Position)
    
    // MARK: - AI
    
    /// Trigger AI to make a decision.
    case aiTurn(playerPosition: Position)
    
    /// AI decision has been made (used internally).
    case aiDecisionMade(action: GameAction)
    
    // MARK: - Scoring
    
    /// Calculate scores for the current round.
    case calculateScore
    
    /// Update game points (red/black 6s) after scoring.
    case updateGamePoints
    
    /// Start a new round (after scoring).
    case startNewRound
    
    // MARK: - UI
    
    /// Show an alert/error message.
    case showError(message: String)
    
    /// Clear the current error message.
    case clearError
    
    /// Set processing state (prevents double-taps).
    case setProcessing(Bool)
    
    // MARK: - Rules
    
    /// Enable or disable a single rule.
    case toggleRule(GameRule, enabled: Bool)
    
    /// Apply a rule preset.
    case applyRulePreset(preset: RulePreset)
    
    // MARK: - Persistence
    
    /// Save the current game state.
    case saveGameState
    
    /// Load a saved game state.
    case loadGameState
    
    /// Delete saved game state.
    case deleteSavedGame
}

/// Rule preset options for quick configuration.
enum RulePreset: String, Codable, Sendable {
    case standard
    case bangladeshClassic
    case advanced
    case beginner
    case custom
}

