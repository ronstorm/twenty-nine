//
//  Team.swift
//  TwentyNine
//
//  Created by Amit Sen on November 24, 2025.
//  © 2025 Coding With Amit. All rights reserved.

import Foundation

/// Represents a team in the TwentyNine game.
///
/// In TwentyNine, players are organized into two fixed partnerships:
/// - North-South: Players at north and south positions
/// - East-West: Players at east and west positions
enum Team: String, Codable, Sendable {
    case northSouth
    case eastWest
    
    /// Display name for the team.
    var displayName: String {
        switch self {
        case .northSouth: return "North-South"
        case .eastWest: return "East-West"
        }
    }
    
    /// Returns the opposing team.
    var opponent: Team {
        switch self {
        case .northSouth: return .eastWest
        case .eastWest: return .northSouth
        }
    }
    
    /// Returns the team for a given position.
    /// - Parameter position: The player position
    /// - Returns: The team that position belongs to
    static func team(for position: Position) -> Team {
        switch position {
        case .north, .south: return .northSouth
        case .east, .west: return .eastWest
        }
    }
    
    /// Returns all positions that belong to this team.
    var positions: [Position] {
        switch self {
        case .northSouth: return [.north, .south]
        case .eastWest: return [.east, .west]
        }
    }
}

