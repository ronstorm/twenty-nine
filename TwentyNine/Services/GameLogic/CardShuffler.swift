//
//  CardShuffler.swift
//  TwentyNine
//
//  Created by Amit Sen on November 24, 2025.
//  © 2025 Coding With Amit. All rights reserved.

import Foundation

/// Protocol for card shuffling service.
///
/// Allows for dependency injection and testing.
protocol CardShuffler: Sendable {
    /// Shuffles a deck of cards using the supplied random number generator.
    ///
    /// Pass a seeded generator to get a reproducible order (e.g., in tests or replays).
    ///
    /// - Parameters:
    ///   - deck: The deck to shuffle
    ///   - generator: The source of randomness
    /// - Returns: A new shuffled deck
    func shuffle(_ deck: [Card], using generator: inout some RandomNumberGenerator) -> [Card]

    /// Creates a standard 32-card deck for TwentyNine.
    /// - Returns: An unshuffled deck of 32 cards (7, 8, Q, K, 10, A, 9, J of each suit)
    func createStandardDeck() -> [Card]
}

extension CardShuffler {
    /// Shuffles a deck of cards using the system's cryptographically secure generator.
    /// - Parameter deck: The deck to shuffle
    /// - Returns: A new shuffled deck
    func shuffle(_ deck: [Card]) -> [Card] {
        var generator = SystemRandomNumberGenerator()
        return shuffle(deck, using: &generator)
    }
}

/// Default implementation of CardShuffler.
struct DefaultCardShuffler: CardShuffler {
    /// Shuffles a deck of cards using the Fisher-Yates algorithm.
    ///
    /// Delegates to the standard library, whose `shuffled(using:)` is an unbiased
    /// Fisher-Yates shuffle (each permutation is equally likely). A hand-rolled
    /// `random() % n` version introduces modulo bias.
    /// Time complexity: O(n) where n is the number of cards.
    func shuffle(_ deck: [Card], using generator: inout some RandomNumberGenerator) -> [Card] {
        deck.shuffled(using: &generator)
    }

    /// Creates a standard 32-card deck for TwentyNine.
    ///
    /// The deck consists of:
    /// - Ranks: 7, 8, Q, K, 10, A, 9, J (8 ranks)
    /// - Suits: Spades, Hearts, Diamonds, Clubs (4 suits)
    /// - Total: 32 cards
    ///
    /// - Returns: An unshuffled deck of 32 cards
    func createStandardDeck() -> [Card] {
        Suit.allCases.flatMap { suit in
            Rank.allCases.map { rank in Card(rank: rank, suit: suit) }
        }
    }
}
