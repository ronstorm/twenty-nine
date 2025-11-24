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
    /// Shuffles a deck of cards using the Fisher-Yates algorithm.
    /// - Parameter deck: The deck to shuffle
    /// - Returns: A new shuffled deck
    func shuffle(_ deck: [Card]) -> [Card]
    
    /// Creates a standard 32-card deck for TwentyNine.
    /// - Returns: An unshuffled deck of 32 cards (7, 8, Q, K, 10, A, 9, J of each suit)
    func createStandardDeck() -> [Card]
}

/// Default implementation of CardShuffler using Fisher-Yates algorithm.
struct DefaultCardShuffler: CardShuffler {
    /// Random number generator for shuffling.
    private let randomGenerator: @Sendable () -> Int
    
    /// Creates a new card shuffler.
    /// - Parameter randomGenerator: Function that returns random integers (defaults to system random)
    init(randomGenerator: @escaping @Sendable () -> Int = { Int.random(in: 0..<Int.max) }) {
        self.randomGenerator = randomGenerator
    }
    
    /// Shuffles a deck of cards using the Fisher-Yates algorithm.
    ///
    /// The Fisher-Yates shuffle algorithm ensures each permutation is equally likely.
    /// Time complexity: O(n) where n is the number of cards.
    ///
    /// - Parameter deck: The deck to shuffle
    /// - Returns: A new shuffled deck
    func shuffle(_ deck: [Card]) -> [Card] {
        var shuffled = deck
        
        // Fisher-Yates shuffle algorithm
        for i in stride(from: shuffled.count - 1, through: 1, by: -1) {
            let j = randomGenerator() % (i + 1)
            shuffled.swapAt(i, j)
        }
        
        return shuffled
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
        var deck: [Card] = []
        
        // Create cards for each suit
        for suit in Suit.allCases {
            // Ranks used in TwentyNine: 7, 8, Q, K, 10, A, 9, J
            let ranks: [Rank] = [.seven, .eight, .queen, .king, .ten, .ace, .nine, .jack]
            
            for rank in ranks {
                deck.append(Card(rank: rank, suit: suit))
            }
        }
        
        return deck
    }
}

