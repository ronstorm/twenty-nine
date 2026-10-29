//
//  Rank.swift
//  TwentyNine
//
//  Created by Amit Sen on November 24, 2025.
//  © 2025 Coding With Amit. All rights reserved.

import Foundation

/// Represents the rank of a card in the TwentyNine game.
///
/// Card ranking (from high to low): J > 9 > A > 10 > K > Q > 8 > 7
/// This is different from standard card games where Ace is typically highest.
enum Rank: Int, CaseIterable, Codable, Sendable, Comparable {
    case seven = 7
    case eight = 8
    case queen = 9
    case king = 10
    case ten = 11
    case ace = 12
    case nine = 13
    case jack = 14
    
    /// Custom comparison for TwentyNine card ranking.
    /// Higher raw value means higher rank in the game.
    static func < (lhs: Rank, rhs: Rank) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
    
    /// Display name for the rank.
    var displayName: String {
        switch self {
        case .seven: return "7"
        case .eight: return "8"
        case .queen: return "Q"
        case .king: return "K"
        case .ten: return "10"
        case .ace: return "A"
        case .nine: return "9"
        case .jack: return "J"
        }
    }
    
    /// Spoken name for the rank (e.g., "Jack"), for descriptions and VoiceOver.
    var name: String {
        switch self {
        case .seven: return "Seven"
        case .eight: return "Eight"
        case .queen: return "Queen"
        case .king: return "King"
        case .ten: return "Ten"
        case .ace: return "Ace"
        case .nine: return "Nine"
        case .jack: return "Jack"
        }
    }
    
    /// Point value for this rank in the game.
    /// J=3, 9=2, A=1, 10=1, others=0
    var pointValue: Int {
        switch self {
        case .jack: return 3
        case .nine: return 2
        case .ace: return 1
        case .ten: return 1
        default: return 0
        }
    }
}

