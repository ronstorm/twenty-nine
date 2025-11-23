//
//  GamePhase.swift
//  TwentyNine
//
//  Created by Amit Sen on November 24, 2025.
//  © 2025 Coding With Amit. All rights reserved.

import Foundation

/// Represents the current phase of the game.
///
/// The game progresses through these phases in order:
/// Setup → Deal First Cards → Bidding → Trump Selection → Deal Second Cards → Playing Tricks → Scoring → Game Over
enum GamePhase: Equatable, Codable, Sendable {
    /// Initial setup phase - configuring players and rules.
    case setup
    
    /// First dealing phase - dealing 4 cards to each player.
    case dealingFirstCards
    
    /// Bidding phase - players bid 16-28 or pass.
    case bidding
    
    /// Trump selection phase - highest bidder selects trump suit.
    case trumpSelection
    
    /// Second dealing phase - dealing remaining 4 cards to each player.
    case dealingSecondCards
    
    /// Trick-taking phase - playing 8 tricks.
    case playingTricks
    
    /// Scoring phase - calculating points and updating game score.
    case scoringRound
    
    /// Game over - a team has reached +6 (win) or -6 (loss).
    case gameOver(winner: Team)
    
    /// Display name for the phase.
    var displayName: String {
        switch self {
        case .setup: return "Setup"
        case .dealingFirstCards: return "Dealing First Cards"
        case .bidding: return "Bidding"
        case .trumpSelection: return "Trump Selection"
        case .dealingSecondCards: return "Dealing Second Cards"
        case .playingTricks: return "Playing Tricks"
        case .scoringRound: return "Scoring"
        case .gameOver(let winner): return "Game Over - \(winner.displayName) Wins"
        }
    }
    
    /// Whether the game is in an active playing phase.
    var isActivePlay: Bool {
        switch self {
        case .playingTricks, .bidding, .trumpSelection:
            return true
        default:
            return false
        }
    }
    
    /// Whether the game has ended.
    var isGameOver: Bool {
        if case .gameOver = self {
            return true
        }
        return false
    }
}

