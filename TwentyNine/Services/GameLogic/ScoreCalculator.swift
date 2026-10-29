//
//  ScoreCalculator.swift
//  TwentyNine
//
//  Created by Amit Sen on November 24, 2025.
//  © 2025 Coding With Amit. All rights reserved.

import Foundation

/// Protocol for score calculation service.
///
/// Calculates card points, team scores, and game points according to TwentyNine rules.
protocol ScoreCalculator: Sendable {
    /// Calculates total points from a collection of cards.
    /// - Parameter cards: Cards to count points for
    /// - Returns: Total point value
    func calculateCardPoints(from cards: [Card]) -> Int
    
    /// Calculates points for a trick.
    /// - Parameter trick: The trick to calculate points for
    /// - Returns: Total points in the trick
    func calculateTrickPoints(_ trick: Trick) -> Int
    
    /// Calculates team score for a round.
    /// - Parameters:
    ///   - tricks: Tricks won by the team
    ///   - marriageBonus: Marriage bonus points (if declared)
    /// - Returns: Total team score for the round
    func calculateTeamScore(
        tricks: [Trick],
        marriageBonus: Int
    ) -> Int
    
    /// Calculates adjusted bid after marriage declarations.
    /// - Parameters:
    ///   - originalBid: The original bid amount
    ///   - marriageDeclaredByBidder: Whether bidder's team declared marriage
    ///   - marriageDeclaredByOpponent: Whether opponent team declared marriage
    /// - Returns: Adjusted bid amount (clamped to 16-28)
    func calculateAdjustedBid(
        originalBid: Int,
        marriageDeclaredByBidder: Bool,
        marriageDeclaredByOpponent: Bool
    ) -> Int
    
    /// Determines if bidding team won the round.
    /// - Parameters:
    ///   - teamScore: Score achieved by bidding team
    ///   - adjustedBid: The adjusted bid amount
    /// - Returns: True if team reached or exceeded their bid
    func didBiddingTeamWin(teamScore: Int, adjustedBid: Int) -> Bool
    
    /// Calculates game points change for a round.
    /// - Parameters:
    ///   - biddingTeamWon: Whether bidding team won
    ///   - isDoubled: Whether bid was doubled
    ///   - isReDoubled: Whether bid was re-doubled
    ///   - allTricksBonusEnabled: Whether all tricks bonus rule is enabled
    ///   - allTricksWon: Whether bidding team won all 8 tricks
    /// - Returns: Game points change (+1 for win, -1 for loss, adjusted for double/re-double)
    func calculateGamePointsChange(
        biddingTeamWon: Bool,
        isDoubled: Bool,
        isReDoubled: Bool,
        allTricksBonusEnabled: Bool,
        allTricksWon: Bool
    ) -> Int
}

/// Default implementation of ScoreCalculator.
struct DefaultScoreCalculator: ScoreCalculator {
    /// Marriage bonus/penalty points.
    private let marriagePoints = 4
    
    /// Calculates total points from a collection of cards.
    func calculateCardPoints(from cards: [Card]) -> Int {
        cards.reduce(0) { $0 + $1.pointValue }
    }
    
    /// Calculates points for a trick.
    func calculateTrickPoints(_ trick: Trick) -> Int {
        trick.totalPoints
    }
    
    /// Calculates team score for a round.
    func calculateTeamScore(
        tricks: [Trick],
        marriageBonus: Int
    ) -> Int {
        let trickPoints = tricks.reduce(0) { $0 + calculateTrickPoints($1) }
        return trickPoints + marriageBonus
    }
    
    /// Calculates adjusted bid after marriage declarations.
    func calculateAdjustedBid(
        originalBid: Int,
        marriageDeclaredByBidder: Bool,
        marriageDeclaredByOpponent: Bool
    ) -> Int {
        var adjusted = originalBid
        
        // Bidder's team marriage reduces bid by 4
        if marriageDeclaredByBidder {
            adjusted -= marriagePoints
        }
        
        // Opponent team marriage increases bid by 4
        if marriageDeclaredByOpponent {
            adjusted += marriagePoints
        }
        
        // Clamp to valid bid range
        return adjusted.clamped(to: Bid.validRange)
    }
    
    /// Determines if bidding team won the round.
    func didBiddingTeamWin(teamScore: Int, adjustedBid: Int) -> Bool {
        teamScore >= adjustedBid
    }
    
    /// Calculates game points change for a round.
    func calculateGamePointsChange(
        biddingTeamWon: Bool,
        isDoubled: Bool,
        isReDoubled: Bool,
        allTricksBonusEnabled: Bool,
        allTricksWon: Bool
    ) -> Int {
        var pointsChange: Int
        
        if biddingTeamWon {
            pointsChange = 1
            
            // All tricks bonus adds +1
            if allTricksBonusEnabled && allTricksWon {
                pointsChange += 1
            }
        } else {
            pointsChange = -1
        }
        
        // Apply double/re-double multipliers
        if isReDoubled {
            pointsChange *= 4
        } else if isDoubled {
            pointsChange *= 2
        }
        
        return pointsChange
    }
}

// MARK: - Helpers

private extension Comparable {
    func clamped(to range: ClosedRange<Self>) -> Self {
        min(max(self, range.lowerBound), range.upperBound)
    }
}
