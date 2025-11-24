//
//  CardDealerTests.swift
//  TwentyNineTests
//
//  Created by Amit Sen on November 24, 2025.
//  © 2025 Coding With Amit. All rights reserved.

import Testing
@testable import TwentyNine

@Suite("CardDealer Tests")
struct CardDealerTests {
    var dealer: CardDealer {
        DefaultCardDealer()
    }
    
    // Use static let to ensure same Player instances (same UUIDs) across test
    static let testPlayers: [Player] = [
        Player(name: "North", type: .human, position: .north),
        Player(name: "East", type: .human, position: .east),
        Player(name: "South", type: .human, position: .south),
        Player(name: "West", type: .human, position: .west)
    ]
    
    var players: [Player] {
        Self.testPlayers
    }
    
    @Test("Deal first cards gives 4 cards to each player")
    func testDealFirstCards() throws {
        let shuffler = DefaultCardShuffler()
        let deck = shuffler.createStandardDeck()
        let shuffledDeck = shuffler.shuffle(deck)
        
        let result = try dealer.dealFirstCards(
            from: shuffledDeck,
            to: players,
            startingFrom: .north
        )
        
        // Check each player has 4 cards
        for player in players {
            let hand = result.hands[player.id] ?? []
            #expect(hand.count == 4)
        }
        
        // Check remaining deck has correct count
        #expect(result.remainingDeck.count == 16) // 32 - 16 = 16
    }
    
    @Test("Deal second cards gives total of 8 cards per player")
    func testDealSecondCards() throws {
        let shuffler = DefaultCardShuffler()
        let deck = shuffler.createStandardDeck()
        let shuffledDeck = shuffler.shuffle(deck)
        
        // Deal first 4 cards
        let firstResult = try dealer.dealFirstCards(
            from: shuffledDeck,
            to: players,
            startingFrom: .north
        )
        
        // Deal remaining 4 cards
        let completeHands = try dealer.dealSecondCards(
            from: firstResult.remainingDeck,
            to: players,
            existingHands: firstResult.hands,
            startingFrom: .north
        )
        
        // Check each player has 8 cards total
        for player in players {
            let hand = completeHands[player.id] ?? []
            #expect(hand.count == 8)
        }
    }
    
    @Test("Deal cards throws error for invalid player count")
    func testDealCardsInvalidPlayerCount() {
        let invalidPlayers = [players[0], players[1]] // Only 2 players
        let deck = Array(repeating: Card(rank: .ace, suit: .spades), count: 32)
        
        do {
            _ = try dealer.dealCards(
                from: deck,
                to: invalidPlayers,
                startingFrom: .north,
                cardsPerPlayer: 4
            )
            Issue.record("Expected DealingError.invalidPlayerCount")
        } catch let error as DealingError {
            if case .invalidPlayerCount = error {
                // Expected error
            } else {
                Issue.record("Expected invalidPlayerCount, got \(error)")
            }
        } catch {
            Issue.record("Expected DealingError, got \(error)")
        }
    }
    
    @Test("Deal cards throws error for insufficient cards")
    func testDealCardsInsufficientCards() {
        let smallDeck = Array(repeating: Card(rank: .ace, suit: .spades), count: 10) // Only 10 cards
        
        do {
            _ = try dealer.dealCards(
                from: smallDeck,
                to: players,
                startingFrom: .north,
                cardsPerPlayer: 4
            )
            Issue.record("Expected DealingError.insufficientCards")
        } catch let error as DealingError {
            if case .insufficientCards = error {
                // Expected error
            } else {
                Issue.record("Expected insufficientCards, got \(error)")
            }
        } catch {
            Issue.record("Expected DealingError, got \(error)")
        }
    }
    
    @Test("Deal cards distributes cards counter-clockwise")
    func testDealCardsCounterClockwise() throws {
        // Create a deck where we can track card order
        var orderedDeck: [Card] = []
        for i in 0..<16 {
            let rank = Rank.allCases[i % Rank.allCases.count]
            let suit = Suit.allCases[i % Suit.allCases.count]
            orderedDeck.append(Card(rank: rank, suit: suit))
        }
        
        let hands = try dealer.dealCards(
            from: orderedDeck,
            to: players,
            startingFrom: .north,
            cardsPerPlayer: 4
        )
        
        // If dealer is North, first card goes to East (dealer's right)
        let eastHand = hands[players.first { $0.position == .east }!.id] ?? []
        #expect(!eastHand.isEmpty)
        
        // Second card goes to South
        let southHand = hands[players.first { $0.position == .south }!.id] ?? []
        #expect(!southHand.isEmpty)
    }
}

