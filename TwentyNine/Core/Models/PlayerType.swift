//
//  PlayerType.swift
//  TwentyNine
//
//  Created by Amit Sen on November 24, 2025.
//  © 2025 Coding With Amit. All rights reserved.

import Foundation

/// Represents the type of a player in the game.
enum PlayerType: Equatable, Codable, Sendable {
    case human
    case ai(difficulty: AIDifficulty)
    
    /// Whether this player is controlled by AI.
    var isAI: Bool {
        if case .ai = self {
            return true
        }
        return false
    }
    
    /// Whether this player is human-controlled.
    var isHuman: Bool {
        !isAI
    }
    
    /// Returns the AI difficulty if this is an AI player, nil otherwise.
    var aiDifficulty: AIDifficulty? {
        if case .ai(let difficulty) = self {
            return difficulty
        }
        return nil
    }
}

/// Represents the difficulty level of an AI player.
enum AIDifficulty: String, CaseIterable, Codable, Sendable {
    case easy
    case medium
    case hard
    
    /// Display name for the difficulty level.
    var displayName: String {
        rawValue.capitalized
    }
}

