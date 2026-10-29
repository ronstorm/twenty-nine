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
    /// Cards are dealt counter-clockwise, starting with the player on the dealer's
    /// right: if dealer is North, dealing order is West → South → East → North → West → ...
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
    ///   - existingHands: Each player's first 4 cards
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
enum DealingError: Error, Equatable, Sendable {
    case invalidPlayerCount(expected: Int, actual: Int)
    case insufficientCards(needed: Int, available: Int)
    case playerNotFound(position: Position)
}

/// Default implementation of CardDealer.
struct DefaultCardDealer: CardDealer {
    /// Number of players at a TwentyNine table.
    private let playerCount = Position.allCases.count

    /// Cards dealt to each player in each of the two deals.
    private let cardsPerDeal = 4

    /// Deals cards to players starting from a given position.
    func dealCards(
        from deck: [Card],
        to players: [Player],
        startingFrom dealerPosition: Position,
        cardsPerPlayer: Int
    ) throws -> [UUID: [Card]] {
        guard players.count == playerCount else {
            throw DealingError.invalidPlayerCount(expected: playerCount, actual: players.count)
        }

        let totalCardsNeeded = players.count * cardsPerPlayer
        guard deck.count >= totalCardsNeeded else {
            throw DealingError.insufficientCards(needed: totalCardsNeeded, available: deck.count)
        }

        // Resolve every seat up front so a missing seat fails before any card is dealt.
        let playersByPosition = Dictionary(players.map { ($0.position, $0) }, uniquingKeysWith: { first, _ in first })
        var dealOrder: [Player] = []
        var position = dealerPosition.nextPosition // Dealer's right
        for _ in 0..<playerCount {
            guard let player = playersByPosition[position] else {
                throw DealingError.playerNotFound(position: position)
            }
            dealOrder.append(player)
            position = position.nextPosition
        }

        // Deal one card per player per round, like a physical deal.
        var hands: [UUID: [Card]] = [:]
        for (index, card) in deck.prefix(totalCardsNeeded).enumerated() {
            hands[dealOrder[index % playerCount].id, default: []].append(card)
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
            cardsPerPlayer: cardsPerDeal
        )

        let remainingDeck = Array(deck.dropFirst(players.count * cardsPerDeal))

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
            cardsPerPlayer: cardsPerDeal
        )

        var completeHands: [UUID: [Card]] = [:]
        for player in players {
            completeHands[player.id] = existingHands[player.id, default: []] + additionalHands[player.id, default: []]
        }
        return completeHands
    }
}
