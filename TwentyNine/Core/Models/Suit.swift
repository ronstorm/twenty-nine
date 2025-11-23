//
//  Suit.swift
//  TwentyNine
//
//  Created by Amit Sen on November 24, 2025.
//  © 2025 Coding With Amit. All rights reserved.

import Foundation

/// Represents the suit of a card.
enum Suit: String, CaseIterable, Codable, Sendable {
    case spades
    case hearts
    case diamonds
    case clubs
    
    /// Unicode symbol for the suit.
    var symbol: String {
        switch self {
        case .spades: return "♠"
        case .hearts: return "♥"
        case .diamonds: return "♦"
        case .clubs: return "♣"
        }
    }
    
    /// Display name for the suit.
    var displayName: String {
        rawValue.capitalized
    }
    
    /// Whether this suit is red (hearts or diamonds).
    var isRed: Bool {
        self == .hearts || self == .diamonds
    }
    
    /// Whether this suit is black (spades or clubs).
    var isBlack: Bool {
        self == .spades || self == .clubs
    }
}

