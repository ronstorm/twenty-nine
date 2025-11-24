//
//  Position.swift
//  TwentyNine
//
//  Created by Amit Sen on November 24, 2025.
//  © 2025 Coding With Amit. All rights reserved.

import Foundation

/// Represents a player's position at the card table.
///
/// In TwentyNine, there are 4 fixed positions arranged around the table:
/// - North (top)
/// - East (right)
/// - South (bottom)
/// - West (left)
enum Position: String, CaseIterable, Codable, Sendable {
    case north
    case east
    case south
    case west
    
    /// Display name for the position.
    var displayName: String {
        rawValue.capitalized
    }
    
    /// Returns the next position in counter-clockwise order.
    /// Used for determining turn order in the game.
    var nextPosition: Position {
        switch self {
        case .north: return .west
        case .east: return .north
        case .south: return .east
        case .west: return .south
        }
    }
    
    /// Returns the previous position in counter-clockwise order.
    var previousPosition: Position {
        switch self {
        case .north: return .east
        case .east: return .south
        case .south: return .west
        case .west: return .north
        }
    }
    
    /// Returns the partner position (opposite side of table).
    var partnerPosition: Position {
        switch self {
        case .north: return .south
        case .east: return .west
        case .south: return .north
        case .west: return .east
        }
    }
}

