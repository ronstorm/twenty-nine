//
//  TeamScore.swift
//  TwentyNine
//
//  Created by Amit Sen on November 24, 2025.
//  © 2025 Coding With Amit. All rights reserved.

import Foundation

/// Represents the score for a team in the TwentyNine game.
///
/// Teams track their game points (using red/black 6s), tricks won,
/// card points collected, and any bonuses (like marriage).
struct TeamScore: Equatable, Codable, Sendable {
    /// The team this score belongs to.
    let team: Team
    
    /// Game points (red 6s = positive, black 6s = negative).
    /// Game ends at +6 (win) or -6 (loss).
    var gamePoints: Int
    
    /// Number of tricks won in the current round.
    var tricksWon: Int
    
    /// Total card points collected in the current round.
    var cardPoints: Int
    
    /// Marriage bonus points (if declared).
    var marriageBonus: Int
    
    /// Creates a new team score.
    /// - Parameters:
    ///   - team: The team this score belongs to
    ///   - gamePoints: Initial game points (defaults to 0)
    ///   - tricksWon: Initial tricks won (defaults to 0)
    ///   - cardPoints: Initial card points (defaults to 0)
    ///   - marriageBonus: Marriage bonus points (defaults to 0)
    init(
        team: Team,
        gamePoints: Int = 0,
        tricksWon: Int = 0,
        cardPoints: Int = 0,
        marriageBonus: Int = 0
    ) {
        self.team = team
        self.gamePoints = gamePoints
        self.tricksWon = tricksWon
        self.cardPoints = cardPoints
        self.marriageBonus = marriageBonus
    }
    
    /// Total points including card points and bonuses.
    var totalPoints: Int {
        cardPoints + marriageBonus
    }
    
    /// Whether the team has won (reached +6 game points).
    var hasWon: Bool {
        gamePoints >= 6
    }
    
    /// Whether the team has lost (reached -6 game points).
    var hasLost: Bool {
        gamePoints <= -6
    }
    
    /// Number of red 6s (positive game points).
    var redSixes: Int {
        max(0, gamePoints)
    }
    
    /// Number of black 6s (negative game points).
    var blackSixes: Int {
        max(0, -gamePoints)
    }
    
    /// Resets round-specific scores (tricks, card points, bonuses).
    mutating func resetRound() {
        tricksWon = 0
        cardPoints = 0
        marriageBonus = 0
    }
}

