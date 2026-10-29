//
//  Card.swift
//  TwentyNine
//
//  Created by Amit Sen on November 24, 2025.
//  © 2025 Coding With Amit. All rights reserved.

import Foundation

/// Represents a playing card in the TwentyNine game.
///
/// A card is fully described by its rank and suit. The TwentyNine deck contains
/// each rank/suit combination exactly once, so the pair doubles as the card's
/// identity. This keeps identity deterministic across shuffles, persistence,
/// and tests (a random `UUID` would make two equal cards have different IDs).
struct Card: Identifiable, Hashable, Codable, Sendable {
    let rank: Rank
    let suit: Suit

    /// Stable identifier derived from rank and suit (e.g., "J♠").
    var id: String {
        displayName
    }

    /// Point value of this card in the game.
    /// J=3, 9=2, A=1, 10=1, others=0
    var pointValue: Int {
        rank.pointValue
    }

    /// Display name for the card (e.g., "J♠", "9♥").
    var displayName: String {
        "\(rank.displayName)\(suit.symbol)"
    }

    /// Full description of the card (e.g., "Jack of Spades").
    var fullDescription: String {
        "\(rank.name) of \(suit.displayName)"
    }
}

extension Card: Comparable {
    /// Compares cards first by rank, then by suit.
    /// For TwentyNine, rank comparison uses custom ordering (J > 9 > A > 10 > K > Q > 8 > 7).
    /// Ties are broken by suit declaration order (spades < hearts < diamonds < clubs).
    static func < (lhs: Card, rhs: Card) -> Bool {
        if lhs.rank != rhs.rank {
            return lhs.rank < rhs.rank
        }
        return lhs.suit < rhs.suit
    }
}
