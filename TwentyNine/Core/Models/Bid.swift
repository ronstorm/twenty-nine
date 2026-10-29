//
//  Bid.swift
//  TwentyNine
//
//  Created by Amit Sen on November 24, 2025.
//  © 2025 Coding With Amit. All rights reserved.

import Foundation

/// Represents a bid made during the bidding phase.
///
/// Bids range from 16 to 28, representing the number of card points
/// a player believes their team can collect. Players can also pass.
struct Bid: Equatable, Codable, Sendable {
    /// The allowed bid amounts. Single source of truth for bidding and scoring rules.
    static let validRange: ClosedRange<Int> = 16...28

    /// The position of the player who made this bid.
    let playerPosition: Position

    /// The bid amount (16-28), or nil if the player passed.
    let amount: Int?

    /// Timestamp when the bid was made.
    let timestamp: Date

    /// Creates a new bid.
    /// - Parameters:
    ///   - playerPosition: Position of the player making the bid
    ///   - amount: Bid amount (16-28), or nil for pass
    ///   - timestamp: When the bid was made (defaults to now)
    init(playerPosition: Position, amount: Int?, timestamp: Date = Date()) {
        self.playerPosition = playerPosition
        self.amount = amount
        self.timestamp = timestamp
    }

    /// Whether this is a pass (no bid amount).
    var isPass: Bool {
        amount == nil
    }

    /// Whether this is an actual bid (not a pass).
    var isBid: Bool {
        amount != nil
    }

    /// Validates that the bid amount is within the allowed range (16-28).
    /// - Parameter amount: The bid amount to validate
    /// - Returns: True if the amount is valid
    static func isValidAmount(_ amount: Int) -> Bool {
        validRange.contains(amount)
    }
}
