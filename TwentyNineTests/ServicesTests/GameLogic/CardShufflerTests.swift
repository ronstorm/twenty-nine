//
//  CardShufflerTests.swift
//  TwentyNineTests
//
//  Created by Amit Sen on November 24, 2025.
//  © 2025 Coding With Amit. All rights reserved.

import Testing
@testable import TwentyNine

@Suite("CardShuffler Tests")
struct CardShufflerTests {
    var shuffler: CardShuffler {
        DefaultCardShuffler()
    }
    
    @Test("Create standard deck returns 32 cards")
    func testCreateStandardDeck() {
        let deck = shuffler.createStandardDeck()
        #expect(deck.count == 32)
    }
    
    @Test("Standard deck contains all ranks and suits")
    func testStandardDeckContainsAllCards() {
        let deck = shuffler.createStandardDeck()
        
        // Check each suit has 8 cards
        for suit in Suit.allCases {
            let suitCards = deck.filter { $0.suit == suit }
            #expect(suitCards.count == 8)
        }
        
        // Check each rank appears 4 times
        for rank in Rank.allCases {
            let rankCards = deck.filter { $0.rank == rank }
            #expect(rankCards.count == 4)
        }
    }
    
    @Test("Shuffle changes card order")
    func testShuffleChangesOrder() {
        var generator = SeededRandomNumberGenerator(seed: 29)
        let originalDeck = shuffler.createStandardDeck()
        let shuffledDeck = shuffler.shuffle(originalDeck, using: &generator)
        
        #expect(shuffledDeck != originalDeck)
    }
    
    @Test("Shuffle with the same seed is reproducible")
    func testShuffleIsReproducibleWithSeed() {
        let deck = shuffler.createStandardDeck()
        var first = SeededRandomNumberGenerator(seed: 42)
        var second = SeededRandomNumberGenerator(seed: 42)
        
        #expect(shuffler.shuffle(deck, using: &first) == shuffler.shuffle(deck, using: &second))
    }
    
    @Test("Shuffle preserves all cards")
    func testShufflePreservesCards() {
        let originalDeck = shuffler.createStandardDeck()
        let shuffledDeck = shuffler.shuffle(originalDeck)
        
        #expect(shuffledDeck.count == originalDeck.count)
        
        #expect(Set(originalDeck) == Set(shuffledDeck))
    }
}

