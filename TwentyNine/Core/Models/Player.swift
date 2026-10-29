//
//  Player.swift
//  TwentyNine
//
//  Created by Amit Sen on November 24, 2025.
//  © 2025 Coding With Amit. All rights reserved.

import Foundation

/// Represents a player in the TwentyNine game.
///
/// Each player has a unique identifier, name, type (human or AI), position at the table,
/// and belongs to a team. Players are identifiable and equatable for use in game state.
struct Player: Identifiable, Equatable, Codable, Sendable {
    let id: UUID
    let name: String
    let type: PlayerType
    let position: Position

    /// Creates a new player.
    /// - Parameters:
    ///   - id: Unique identifier for the player
    ///   - name: Display name for the player
    ///   - type: Type of player (human or AI)
    ///   - position: Position at the table
    init(id: UUID = UUID(), name: String, type: PlayerType, position: Position) {
        self.id = id
        self.name = name
        self.type = type
        self.position = position
    }

    /// The team this player belongs to, derived from their seat.
    ///
    /// Computed rather than stored so it can never disagree with `position`
    /// (e.g., after decoding a hand-edited save file).
    var team: Team {
        Team.team(for: position)
    }

    /// Whether this player is controlled by AI.
    var isAI: Bool {
        type.isAI
    }
    
    /// Whether this player is human-controlled.
    var isHuman: Bool {
        type.isHuman
    }
    
    /// Returns the partner position for this player.
    var partnerPosition: Position {
        position.partnerPosition
    }
}

