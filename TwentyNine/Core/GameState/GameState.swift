//
//  GameState.swift
//  TwentyNine
//
//  Created by Amit Sen on November 24, 2025.
//  © 2025 Coding With Amit. All rights reserved.

import Foundation

/// Comprehensive game state for the TwentyNine card game.
///
/// This struct contains all state information needed to represent a game in progress,
/// including players, cards, bidding, tricks, scoring, and UI state.
struct GameState: Equatable, Codable, Sendable {
    // MARK: - Players
    
    /// All players in the game (4 players).
    var players: [Player]
    
    /// Index of the current player whose turn it is.
    var currentPlayerIndex: Int
    
    /// Index of the dealer for the current round.
    var dealerIndex: Int
    
    // MARK: - Game Phase
    
    /// Current phase of the game.
    var gamePhase: GamePhase
    
    // MARK: - Cards
    
    /// The deck of 32 cards (before dealing).
    var deck: [Card]
    
    /// Cards held by each player, keyed by player ID.
    var playerHands: [UUID: [Card]]
    
    /// Cards currently played in the current trick, keyed by position.
    var currentTrick: [Position: Card]
    
    /// Completed tricks, keyed by winning player position.
    var completedTricks: [Trick]
    
    /// Current trick number (1-8).
    var currentTrickNumber: Int
    
    // MARK: - Bidding
    
    /// History of all bids made during bidding phase.
    var bids: [Bid]
    
    /// Current highest bid amount (16-28), or nil if no bid yet.
    var currentHighestBid: Int?
    
    /// Position of the player who made the current highest bid.
    var highestBidderPosition: Position?
    
    /// Number of consecutive passes in bidding.
    var consecutivePasses: Int
    
    // MARK: - Trump
    
    /// The selected trump suit, or nil if not yet selected.
    var trumpSuit: Suit?
    
    /// Whether the trump suit has been revealed to all players.
    var trumpRevealed: Bool
    
    /// The trump indicator card used (2-5 of trump suit).
    var trumpIndicatorCard: Card?
    
    // MARK: - Marriage
    
    /// Whether marriage has been declared by bidder's team.
    var marriageDeclaredByBidder: Bool
    
    /// Whether marriage has been declared by opponent team.
    var marriageDeclaredByOpponent: Bool
    
    /// Adjusted bid amount after marriage declarations.
    var adjustedBid: Int?
    
    // MARK: - Double/Re-Double
    
    /// Whether the bid has been doubled.
    var isDoubled: Bool
    
    /// Whether the bid has been re-doubled.
    var isReDoubled: Bool
    
    // MARK: - Rules
    
    /// Rule configuration for this game.
    var ruleConfiguration: RuleConfiguration
    
    // MARK: - Scoring
    
    /// Score for North-South team.
    var northSouthScore: TeamScore
    
    /// Score for East-West team.
    var eastWestScore: TeamScore
    
    /// Game points (red/black 6s) for each team.
    var gamePoints: [Team: Int]
    
    // MARK: - UI State
    
    /// Currently selected cards (for card selection UI).
    var selectedCards: Set<UUID>
    
    /// Whether the game is currently processing an action (prevents double-taps).
    var isProcessing: Bool
    
    /// Error message to display, if any.
    var errorMessage: String?
    
    // MARK: - Initialization
    
    /// Creates a new game state with default values.
    init(
        players: [Player] = [],
        currentPlayerIndex: Int = 0,
        dealerIndex: Int = 0,
        gamePhase: GamePhase = .setup,
        deck: [Card] = [],
        playerHands: [UUID: [Card]] = [:],
        currentTrick: [Position: Card] = [:],
        completedTricks: [Trick] = [],
        currentTrickNumber: Int = 1,
        bids: [Bid] = [],
        currentHighestBid: Int? = nil,
        highestBidderPosition: Position? = nil,
        consecutivePasses: Int = 0,
        trumpSuit: Suit? = nil,
        trumpRevealed: Bool = false,
        trumpIndicatorCard: Card? = nil,
        marriageDeclaredByBidder: Bool = false,
        marriageDeclaredByOpponent: Bool = false,
        adjustedBid: Int? = nil,
        isDoubled: Bool = false,
        isReDoubled: Bool = false,
        ruleConfiguration: RuleConfiguration = RuleConfiguration(),
        northSouthScore: TeamScore = TeamScore(team: .northSouth),
        eastWestScore: TeamScore = TeamScore(team: .eastWest),
        gamePoints: [Team: Int] = [.northSouth: 0, .eastWest: 0],
        selectedCards: Set<UUID> = [],
        isProcessing: Bool = false,
        errorMessage: String? = nil
    ) {
        self.players = players
        self.currentPlayerIndex = currentPlayerIndex
        self.dealerIndex = dealerIndex
        self.gamePhase = gamePhase
        self.deck = deck
        self.playerHands = playerHands
        self.currentTrick = currentTrick
        self.completedTricks = completedTricks
        self.currentTrickNumber = currentTrickNumber
        self.bids = bids
        self.currentHighestBid = currentHighestBid
        self.highestBidderPosition = highestBidderPosition
        self.consecutivePasses = consecutivePasses
        self.trumpSuit = trumpSuit
        self.trumpRevealed = trumpRevealed
        self.trumpIndicatorCard = trumpIndicatorCard
        self.marriageDeclaredByBidder = marriageDeclaredByBidder
        self.marriageDeclaredByOpponent = marriageDeclaredByOpponent
        self.adjustedBid = adjustedBid
        self.isDoubled = isDoubled
        self.isReDoubled = isReDoubled
        self.ruleConfiguration = ruleConfiguration
        self.northSouthScore = northSouthScore
        self.eastWestScore = eastWestScore
        self.gamePoints = gamePoints
        self.selectedCards = selectedCards
        self.isProcessing = isProcessing
        self.errorMessage = errorMessage
    }
    
    // MARK: - Computed Properties
    
    /// Returns the current player.
    var currentPlayer: Player? {
        guard currentPlayerIndex < players.count else { return nil }
        return players[currentPlayerIndex]
    }
    
    /// Returns the dealer player.
    var dealer: Player? {
        guard dealerIndex < players.count else { return nil }
        return players[dealerIndex]
    }
    
    /// Returns the highest bidder player.
    var highestBidder: Player? {
        guard let position = highestBidderPosition else { return nil }
        return players.first { $0.position == position }
    }
    
    /// Returns the team score for a given team.
    func score(for team: Team) -> TeamScore {
        switch team {
        case .northSouth: return northSouthScore
        case .eastWest: return eastWestScore
        }
    }
    
    /// Returns the game points for a given team.
    func gamePoints(for team: Team) -> Int {
        gamePoints[team] ?? 0
    }
    
    /// Whether the game has ended (a team reached +6 or -6).
    var isGameOver: Bool {
        gamePhase.isGameOver || 
        gamePoints[.northSouth] == 6 || 
        gamePoints[.northSouth] == -6 ||
        gamePoints[.eastWest] == 6 || 
        gamePoints[.eastWest] == -6
    }
}

