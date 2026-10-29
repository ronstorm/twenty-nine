//
//  RuleConfiguration.swift
//  TwentyNine
//
//  Created by Amit Sen on November 24, 2025.
//  © 2025 Coding With Amit. All rights reserved.

import Foundation

/// Configuration for toggleable game rules.
///
/// This struct contains all configurable rules that can be enabled or disabled
/// to match different regional variations of the TwentyNine game.
/// `RuleConfiguration()` gives the defaults below; the synthesized memberwise
/// initializer lets callers override only the rules they care about.
struct RuleConfiguration: Equatable, Codable, Sendable {
    /// Marriage (Pair) rule - K+Q of trump = ±4 points to bid.
    var marriageEnabled = true

    /// Double rule - Opponents can challenge bid (±2 points).
    var doubleEnabled = true

    /// Re-Double rule - Bidder can counter double (±4 points).
    var reDoubleEnabled = true

    /// Single Hand rule - One player plays alone vs 3.
    var singleHandEnabled = true

    /// 7th Card Trump rule - Trump revealed by 7th card.
    var seventhCardTrumpEnabled = true

    /// Joker Trump rule - Only highest card wins (no regular ranking).
    var jokerTrumpEnabled = false

    /// Reverse Trump rule - 7 highest, J lowest in trump suit.
    var reverseTrumpEnabled = false

    /// All Tricks Bonus rule - +1 if team wins all 8 tricks.
    var allTricksBonusEnabled = true

    /// Half-Point Penalty rule - Extra penalty if < half bid won.
    var halfPointPenaltyEnabled = false

    /// Cancel on 3 Passes rule - Game cancelled if first 3 pass.
    var cancelOn3PassesEnabled = true

    /// Auto-show Trump rule - Reveal trump immediately.
    var autoShowTrumpEnabled = false

    /// Reads or writes a single rule by its type-safe identifier.
    subscript(rule: GameRule) -> Bool {
        get { self[keyPath: rule.keyPath] }
        set { self[keyPath: rule.keyPath] = newValue }
    }
}

// MARK: - Game Rules

/// Type-safe identifier for each toggleable rule in `RuleConfiguration`.
///
/// Used by actions and settings UI instead of string key paths, so a typo
/// becomes a compile error rather than a silently ignored toggle.
enum GameRule: String, CaseIterable, Codable, Sendable {
    case marriage
    case double
    case reDouble
    case singleHand
    case seventhCardTrump
    case jokerTrump
    case reverseTrump
    case allTricksBonus
    case halfPointPenalty
    case cancelOn3Passes
    case autoShowTrump

    fileprivate var keyPath: WritableKeyPath<RuleConfiguration, Bool> {
        switch self {
        case .marriage: \.marriageEnabled
        case .double: \.doubleEnabled
        case .reDouble: \.reDoubleEnabled
        case .singleHand: \.singleHandEnabled
        case .seventhCardTrump: \.seventhCardTrumpEnabled
        case .jokerTrump: \.jokerTrumpEnabled
        case .reverseTrump: \.reverseTrumpEnabled
        case .allTricksBonus: \.allTricksBonusEnabled
        case .halfPointPenalty: \.halfPointPenaltyEnabled
        case .cancelOn3Passes: \.cancelOn3PassesEnabled
        case .autoShowTrump: \.autoShowTrumpEnabled
        }
    }
}

// MARK: - Rule Presets

extension RuleConfiguration {
    /// Standard preset - Marriage only.
    static let standard = RuleConfiguration(
        doubleEnabled: false,
        reDoubleEnabled: false,
        singleHandEnabled: false,
        seventhCardTrumpEnabled: false,
        allTricksBonusEnabled: false
    )

    /// Bangladesh Classic preset - Marriage + Double + Re-Double.
    static let bangladeshClassic = RuleConfiguration(
        singleHandEnabled: false,
        seventhCardTrumpEnabled: false,
        allTricksBonusEnabled: false
    )

    /// Advanced preset - All rules enabled except auto-show trump.
    static let advanced = RuleConfiguration(
        jokerTrumpEnabled: true,
        reverseTrumpEnabled: true,
        halfPointPenaltyEnabled: true
    )

    /// Beginner preset - Marriage + Auto-show Trump.
    static let beginner = RuleConfiguration(
        doubleEnabled: false,
        reDoubleEnabled: false,
        singleHandEnabled: false,
        seventhCardTrumpEnabled: false,
        allTricksBonusEnabled: false,
        autoShowTrumpEnabled: true
    )
}

/// Rule preset options for quick configuration.
enum RulePreset: String, CaseIterable, Codable, Sendable {
    case standard
    case bangladeshClassic
    case advanced
    case beginner
    case custom
}

extension RulePreset {
    /// The rule configuration this preset applies, or nil for `.custom`
    /// (which keeps whatever the player has configured).
    var configuration: RuleConfiguration? {
        switch self {
        case .standard: .standard
        case .bangladeshClassic: .bangladeshClassic
        case .advanced: .advanced
        case .beginner: .beginner
        case .custom: nil
        }
    }
}
