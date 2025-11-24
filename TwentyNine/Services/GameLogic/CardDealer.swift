//
//  CardDealer.swift
//  TwentyNine
//
//  Created by Amit Sen on November 24, 2025.
//  © 2025 Coding With Amit. All rights reserved.

import Foundation

/// Protocol for card dealing service.
///
/// Handles the distribution of cards to players in counter-clockwise order.
protocol CardDealer: Sendable {
    /// Deals cards to players starting from a given position.
    ///
    /// Cards are dealt counter-clockwise: if dealer is North, dealing order is:
    /// West → South → East → North → West → ...
    ///
    /// - Parameters:
    ///   - deck: The deck to deal from
    ///   - players: Array of players (must be 4 players)
    ///   - dealerPosition: Position of the dealer
    ///   - cardsPerPlayer: Number of cards to deal to each player
    /// - Returns: Dictionary mapping player IDs to their dealt cards
    /// - Throws: `DealingError` if dealing fails
    func dealCards(
        from deck: [Card],
        to players: [Player],
        startingFrom dealerPosition: Position,
        cardsPerPlayer: Int
    ) throws -> [UUID: [Card]]
    
    /// Deals the first 4 cards to each player (before bidding).
    /// - Parameters:
    ///   - deck: The deck to deal from
    ///   - players: Array of players
    ///   - dealerPosition: Position of the dealer
    /// - Returns: Dictionary mapping player IDs to their first 4 cards, and remaining deck
    /// - Throws: `DealingError` if dealing fails
    func dealFirstCards(
        from deck: [Card],
        to players: [Player],
        startingFrom dealerPosition: Position
    ) throws -> (hands: [UUID: [Card]], remainingDeck: [Card])
    
    /// Deals the remaining 4 cards to each player (after trump selection).
    /// - Parameters:
    ///   - deck: The remaining deck after first deal
    ///   - players: Array of players
    ///   - dealerPosition: Position of the dealer
    /// - Returns: Dictionary mapping player IDs to their complete hands (8 cards total)
    /// - Throws: `DealingError` if dealing fails
    func dealSecondCards(
        from deck: [Card],
        to players: [Player],
        existingHands: [UUID: [Card]],
        startingFrom dealerPosition: Position
    ) throws -> [UUID: [Card]]
}

/// Errors that can occur during card dealing.
enum DealingError: Error, Sendable {
    case invalidPlayerCount(expected: Int, actual: Int)
    case insufficientCards(needed: Int, available: Int)
    case playerNotFound(position: Position)
    case invalidDealerPosition
}

/// Default implementation of CardDealer.
struct DefaultCardDealer: CardDealer {
    /// Deals cards to players starting from a given position.
    func dealCards(
        from deck: [Card],
        to players: [Player],
        startingFrom dealerPosition: Position,
        cardsPerPlayer: Int
    ) throws -> [UUID: [Card]] {
        // Validate player count
        guard players.count == 4 else {
            throw DealingError.invalidPlayerCount(expected: 4, actual: players.count)
        }
        
        // Validate sufficient cards
        let totalCardsNeeded = players.count * cardsPerPlayer
        guard deck.count >= totalCardsNeeded else {
            throw DealingError.insufficientCards(needed: totalCardsNeeded, available: deck.count)
        }
        
        // Validate dealer position exists
        guard players.contains(where: { $0.position == dealerPosition }) else {
            throw DealingError.playerNotFound(position: dealerPosition)
        }
        
        // Create position order starting from dealer's right (counter-clockwise)
        // If dealer is North, order is: East → South → West → North
        var positionOrder: [Position] = []
        var currentPosition = dealerPosition.nextPosition // Start from dealer's right
        
        for _ in 0..<4 {
            positionOrder.append(currentPosition)
            currentPosition = currentPosition.nextPosition
        }
        
        // Deal cards counter-clockwise
        var hands: [UUID: [Card]] = [:]
        var deckIndex = 0
        
        // Deal cards in rounds (one card per player per round)
        for _ in 0..<cardsPerPlayer {
            for position in positionOrder {
                guard let player = players.first(where: { $0.position == position }) else {
                    throw DealingError.playerNotFound(position: position)
                }
                
                if hands[player.id] == nil {
                    hands[player.id] = []
                }
                
                guard deckIndex < deck.count else {
                    throw DealingError.insufficientCards(needed: totalCardsNeeded, available: deckIndex)
                }
                
                hands[player.id]?.append(deck[deckIndex])
                deckIndex += 1
            }
        }
        
        return hands
    }
    
    /// Deals the first 4 cards to each player.
    func dealFirstCards(
        from deck: [Card],
        to players: [Player],
        startingFrom dealerPosition: Position
    ) throws -> (hands: [UUID: [Card]], remainingDeck: [Card]) {
        let hands = try dealCards(
            from: deck,
            to: players,
            startingFrom: dealerPosition,
            cardsPerPlayer: 4
        )
        
        let cardsDealt = players.count * 4
        let remainingDeck = Array(deck.dropFirst(cardsDealt))
        
        return (hands, remainingDeck)
    }
    
    /// Deals the remaining 4 cards to each player.
    func dealSecondCards(
        from deck: [Card],
        to players: [Player],
        existingHands: [UUID: [Card]],
        startingFrom dealerPosition: Position
    ) throws -> [UUID: [Card]] {
        let additionalHands = try dealCards(
            from: deck,
            to: players,
            startingFrom: dealerPosition,
            cardsPerPlayer: 4
        )
        
        // Combine existing hands with new cards
        var completeHands: [UUID: [Card]] = [:]
        for player in players {
            let existing = existingHands[player.id] ?? []
            let additional = additionalHands[player.id] ?? []
            completeHands[player.id] = existing + additional
        }
        
        return completeHands
    }
}

