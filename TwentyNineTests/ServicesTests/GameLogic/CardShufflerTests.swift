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
        let ranks: [Rank] = [.seven, .eight, .queen, .king, .ten, .ace, .nine, .jack]
        for rank in ranks {
            let rankCards = deck.filter { $0.rank == rank }
            #expect(rankCards.count == 4)
        }
    }
    
    @Test("Shuffle changes card order")
    func testShuffleChangesOrder() {
        let originalDeck = shuffler.createStandardDeck()
        let shuffledDeck = shuffler.shuffle(originalDeck)
        
        // Very unlikely that shuffle produces same order (1 in 32! chance)
        // But possible, so we'll check multiple times
        var differentOrder = false
        for i in 0..<originalDeck.count {
            if originalDeck[i].id != shuffledDeck[i].id {
                differentOrder = true
                break
            }
        }
        
        // If same order, shuffle again (should be different)
        if !differentOrder {
            let reshuffled = shuffler.shuffle(originalDeck)
            differentOrder = originalDeck[0].id != reshuffled[0].id
        }
        
        #expect(differentOrder)
    }
    
    @Test("Shuffle preserves all cards")
    func testShufflePreservesCards() {
        let originalDeck = shuffler.createStandardDeck()
        let shuffledDeck = shuffler.shuffle(originalDeck)
        
        #expect(shuffledDeck.count == originalDeck.count)
        
        // Check all cards are present (by rank and suit combination)
        let originalCardSet = Set(originalDeck.map { "\($0.rank.displayName)\($0.suit.symbol)" })
        let shuffledCardSet = Set(shuffledDeck.map { "\($0.rank.displayName)\($0.suit.symbol)" })
        
        #expect(originalCardSet == shuffledCardSet)
    }
}

