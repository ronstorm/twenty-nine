//
//  Card.swift
//  TwentyNine
//
//  Created by Amit Sen on November 24, 2025.
//  © 2025 Coding With Amit. All rights reserved.

import Foundation

/// Represents a playing card in the TwentyNine game.
///
/// A card consists of a rank and suit. Cards are identifiable and can be
/// compared for equality and hashing. Cards are also sendable for use in
/// concurrent contexts.
struct Card: Identifiable, Codable, Sendable {
    let id: UUID
    let rank: Rank
    let suit: Suit
    
    /// Creates a new card with the specified rank and suit.
    /// - Parameters:
    ///   - rank: The rank of the card
    ///   - suit: The suit of the card
    init(rank: Rank, suit: Suit) {
        self.id = UUID()
        self.rank = rank
        self.suit = suit
    }
    
    /// Creates a card with a specific ID (useful for testing or persistence).
    /// - Parameters:
    ///   - id: The unique identifier for the card
    ///   - rank: The rank of the card
    ///   - suit: The suit of the card
    init(id: UUID, rank: Rank, suit: Suit) {
        self.id = id
        self.rank = rank
        self.suit = suit
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
        "\(rank.displayName) of \(suit.displayName)"
    }
}

extension Card: Equatable {
    /// Compares cards by rank and suit only (ignoring UUID).
    /// Two cards are equal if they have the same rank and suit.
    static func == (lhs: Card, rhs: Card) -> Bool {
        lhs.rank == rhs.rank && lhs.suit == rhs.suit
    }
}

extension Card: Hashable {
    /// Hash based on rank and suit only (ignoring UUID).
    func hash(into hasher: inout Hasher) {
        hasher.combine(rank)
        hasher.combine(suit)
    }
}

extension Card: Comparable {
    /// Compares cards first by rank, then by suit.
    /// For TwentyNine, rank comparison uses custom ordering (J > 9 > A > 10 > K > Q > 8 > 7).
    static func < (lhs: Card, rhs: Card) -> Bool {
        if lhs.rank != rhs.rank {
            return lhs.rank < rhs.rank
        }
        // If ranks are equal, compare by suit (spades < hearts < diamonds < clubs)
        return lhs.suit.rawValue < rhs.suit.rawValue
    }
}

