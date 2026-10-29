//
//  Trick.swift
//  TwentyNine
//
//  Created by Amit Sen on November 24, 2025.
//  © 2025 Coding With Amit. All rights reserved.

import Foundation

/// Represents a trick (round) in the game.
///
/// A trick consists of one card played by each of the 4 players.
/// The trick is won by the player who played the highest card according
/// to the game rules (considering trump suit and lead suit).
struct Trick: Equatable, Codable, Sendable {
    /// Cards played in this trick, keyed by player position.
    let cards: [Position: Card]

    /// Position of the player who led this trick (played first card).
    let leadPosition: Position

    /// Position of the player who won this trick.
    let winnerPosition: Position

    /// Total point value of all cards in this trick.
    ///
    /// Derived from `cards` so the total can't drift from the cards actually played.
    var totalPoints: Int {
        cards.values.reduce(0) { $0 + $1.pointValue }
    }

    /// Returns the card played by a specific position.
    /// - Parameter position: The player position
    /// - Returns: The card played, or nil if not found
    func card(playedBy position: Position) -> Card? {
        cards[position]
    }

    /// Returns the lead card (first card played).
    var leadCard: Card? {
        cards[leadPosition]
    }

    /// Returns the winning card.
    var winningCard: Card? {
        cards[winnerPosition]
    }

    /// Whether this trick is complete (all 4 players have played).
    var isComplete: Bool {
        cards.count == Position.allCases.count
    }
}
