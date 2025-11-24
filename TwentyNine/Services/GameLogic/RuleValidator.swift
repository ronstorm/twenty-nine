//
//  RuleValidator.swift
//  TwentyNine
//
//  Created by Amit Sen on November 24, 2025.
//  © 2025 Coding With Amit. All rights reserved.

import Foundation

/// Protocol for game rule validation service.
///
/// Validates moves, bids, and other game actions according to TwentyNine rules.
protocol RuleValidator: Sendable {
    /// Validates if a bid is legal.
    /// - Parameters:
    ///   - bid: The bid amount (16-28)
    ///   - currentHighestBid: The current highest bid, or nil if no bid yet
    ///   - previousBidderPosition: Position of player who made the current highest bid
    ///   - bidderPosition: Position of player making the new bid
    /// - Returns: True if the bid is valid
    func isValidBid(
        _ bid: Int,
        currentHighestBid: Int?,
        previousBidderPosition: Position?,
        bidderPosition: Position
    ) -> Bool
    
    /// Validates if a card can be played.
    /// - Parameters:
    ///   - card: The card to play
    ///   - playerHand: The player's current hand
    ///   - currentTrick: Cards already played in the current trick
    ///   - leadCard: The card that led the trick
    ///   - trumpSuit: The trump suit, or nil if not revealed
    ///   - trumpRevealed: Whether trump has been revealed
    /// - Returns: True if the card can be played
    func canPlayCard(
        _ card: Card,
        from playerHand: [Card],
        in currentTrick: [Position: Card],
        leadCard: Card?,
        trumpSuit: Suit?,
        trumpRevealed: Bool
    ) -> Bool
    
    /// Validates if a player can declare marriage.
    /// - Parameters:
    ///   - playerHand: The player's current hand
    ///   - trumpSuit: The trump suit
    ///   - trumpRevealed: Whether trump has been revealed
    /// - Returns: True if marriage can be declared
    func canDeclareMarriage(
        playerHand: [Card],
        trumpSuit: Suit?,
        trumpRevealed: Bool
    ) -> Bool
    
    /// Validates if the game should be cancelled based on bidding rules.
    /// - Parameters:
    ///   - consecutivePasses: Number of consecutive passes
    ///   - totalBids: Total number of bids made
    ///   - cancelOn3PassesEnabled: Whether cancel on 3 passes rule is enabled
    /// - Returns: True if game should be cancelled
    func shouldCancelGame(
        consecutivePasses: Int,
        totalBids: Int,
        cancelOn3PassesEnabled: Bool
    ) -> Bool
}

/// Default implementation of RuleValidator.
struct DefaultRuleValidator: RuleValidator {
    /// Minimum bid amount.
    private let minBid = 16
    
    /// Maximum bid amount.
    private let maxBid = 28
    
    /// Validates if a bid is legal.
    func isValidBid(
        _ bid: Int,
        currentHighestBid: Int?,
        previousBidderPosition: Position?,
        bidderPosition: Position
    ) -> Bool {
        // Check bid is within valid range
        guard bid >= minBid && bid <= maxBid else {
            return false
        }
        
        // If no current bid, any valid bid is allowed
        guard let currentHighest = currentHighestBid else {
            return true
        }
        
        // Must bid higher than current bid
        // OR match the current bid if you were the one who placed it
        if bid > currentHighest {
            return true
        }
        
        if bid == currentHighest {
            // Can match your own bid
            return previousBidderPosition == bidderPosition
        }
        
        return false
    }
    
    /// Validates if a card can be played.
    func canPlayCard(
        _ card: Card,
        from playerHand: [Card],
        in currentTrick: [Position: Card],
        leadCard: Card?,
        trumpSuit: Suit?,
        trumpRevealed: Bool
    ) -> Bool {
        // Card must be in player's hand
        guard playerHand.contains(card) else {
            return false
        }
        
        // If no lead card, this is the first card of the trick (always valid)
        guard let lead = leadCard else {
            return true
        }
        
        let leadSuit = lead.suit
        
        // Check if player has cards of the lead suit
        let hasLeadSuit = playerHand.contains { $0.suit == leadSuit }
        
        // If player has cards of the lead suit, must follow suit
        if hasLeadSuit {
            return card.suit == leadSuit
        }
        
        // Player doesn't have lead suit
        // If trump is revealed and player has trump cards, must play trump
        if trumpRevealed, let trump = trumpSuit {
            let hasTrump = playerHand.contains { $0.suit == trump }
            if hasTrump {
                return card.suit == trump
            }
        }
        
        // Can play any card if can't follow suit
        return true
    }
    
    /// Validates if a player can declare marriage.
    func canDeclareMarriage(
        playerHand: [Card],
        trumpSuit: Suit?,
        trumpRevealed: Bool
    ) -> Bool {
        // Marriage can only be declared after trump is revealed
        guard trumpRevealed, let trump = trumpSuit else {
            return false
        }
        
        // Check if player has both King and Queen of trump suit
        let hasKing = playerHand.contains { $0.rank == .king && $0.suit == trump }
        let hasQueen = playerHand.contains { $0.rank == .queen && $0.suit == trump }
        
        return hasKing && hasQueen
    }
    
    /// Validates if the game should be cancelled.
    func shouldCancelGame(
        consecutivePasses: Int,
        totalBids: Int,
        cancelOn3PassesEnabled: Bool
    ) -> Bool {
        // If cancel on 3 passes is enabled and first 3 players passed without any bid
        if cancelOn3PassesEnabled && consecutivePasses >= 3 && totalBids == 0 {
            return true
        }
        
        return false
    }
}

