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
    
    @Test("Deal cards distributes cards counter-clockwise from dealer's right")
    func testDealCardsCounterClockwise() throws {
        // Unshuffled deck, so we know exactly which card is dealt when
        let deck = DefaultCardShuffler().createStandardDeck()
        
        let hands = try dealer.dealCards(
            from: deck,
            to: players,
            startingFrom: .north,
            cardsPerPlayer: 4
        )
        
        // Dealer North: West (dealer's right) gets card 0, then South, East, North
        let expectedOrder: [Position] = [.west, .south, .east, .north]
        for (seat, position) in expectedOrder.enumerated() {
            let player = try #require(players.first { $0.position == position })
            let expectedHand = (0..<4).map { round in deck[round * 4 + seat] }
            #expect(hands[player.id] == expectedHand, "Wrong hand for \(position)")
        }
    }
    
    @Test("Deal cards throws error when a seat is empty")
    func testDealCardsMissingSeat() {
        // Four players but two of them sit North, so West is empty
        let players = [
            Player(name: "North", type: .human, position: .north),
            Player(name: "North 2", type: .human, position: .north),
            Player(name: "East", type: .human, position: .east),
            Player(name: "South", type: .human, position: .south)
        ]
        let deck = DefaultCardShuffler().createStandardDeck()
        
        #expect(throws: DealingError.playerNotFound(position: .west)) {
            try dealer.dealCards(from: deck, to: players, startingFrom: .north, cardsPerPlayer: 4)
        }
    }
}

