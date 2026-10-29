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

extension Suit: Comparable {
    /// Orders suits by declaration order (spades < hearts < diamonds < clubs).
    ///
    /// Comparing `rawValue` strings would sort alphabetically instead, which
    /// reverses this order.
    static func < (lhs: Suit, rhs: Suit) -> Bool {
        sortIndex(of: lhs) < sortIndex(of: rhs)
    }

    private static func sortIndex(of suit: Suit) -> Int {
        allCases.firstIndex(of: suit) ?? 0
    }
}

