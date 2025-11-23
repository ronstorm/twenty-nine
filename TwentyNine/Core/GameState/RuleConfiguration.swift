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
struct RuleConfiguration: Equatable, Codable, Sendable {
    /// Marriage (Pair) rule - K+Q of trump = ±4 points to bid.
    var marriageEnabled: Bool = true
    
    /// Double rule - Opponents can challenge bid (±2 points).
    var doubleEnabled: Bool = true
    
    /// Re-Double rule - Bidder can counter double (±4 points).
    var reDoubleEnabled: Bool = true
    
    /// Single Hand rule - One player plays alone vs 3.
    var singleHandEnabled: Bool = true
    
    /// 7th Card Trump rule - Trump revealed by 7th card.
    var seventhCardTrumpEnabled: Bool = true
    
    /// Joker Trump rule - Only highest card wins (no regular ranking).
    var jokerTrumpEnabled: Bool = false
    
    /// Reverse Trump rule - 7 highest, J lowest in trump suit.
    var reverseTrumpEnabled: Bool = false
    
    /// All Tricks Bonus rule - +1 if team wins all 8 tricks.
    var allTricksBonusEnabled: Bool = true
    
    /// Half-Point Penalty rule - Extra penalty if < half bid won.
    var halfPointPenaltyEnabled: Bool = false
    
    /// Cancel on 3 Passes rule - Game cancelled if first 3 pass.
    var cancelOn3PassesEnabled: Bool = true
    
    /// Auto-show Trump rule - Reveal trump immediately.
    var autoShowTrumpEnabled: Bool = false
    
    /// Creates a default rule configuration.
    init() {}
    
    /// Creates a rule configuration with custom values.
    init(
        marriageEnabled: Bool = true,
        doubleEnabled: Bool = true,
        reDoubleEnabled: Bool = true,
        singleHandEnabled: Bool = true,
        seventhCardTrumpEnabled: Bool = true,
        jokerTrumpEnabled: Bool = false,
        reverseTrumpEnabled: Bool = false,
        allTricksBonusEnabled: Bool = true,
        halfPointPenaltyEnabled: Bool = false,
        cancelOn3PassesEnabled: Bool = true,
        autoShowTrumpEnabled: Bool = false
    ) {
        self.marriageEnabled = marriageEnabled
        self.doubleEnabled = doubleEnabled
        self.reDoubleEnabled = reDoubleEnabled
        self.singleHandEnabled = singleHandEnabled
        self.seventhCardTrumpEnabled = seventhCardTrumpEnabled
        self.jokerTrumpEnabled = jokerTrumpEnabled
        self.reverseTrumpEnabled = reverseTrumpEnabled
        self.allTricksBonusEnabled = allTricksBonusEnabled
        self.halfPointPenaltyEnabled = halfPointPenaltyEnabled
        self.cancelOn3PassesEnabled = cancelOn3PassesEnabled
        self.autoShowTrumpEnabled = autoShowTrumpEnabled
    }
}

// MARK: - Rule Presets

extension RuleConfiguration {
    /// Standard preset - Marriage only.
    static var standard: RuleConfiguration {
        RuleConfiguration(
            marriageEnabled: true,
            doubleEnabled: false,
            reDoubleEnabled: false,
            singleHandEnabled: false,
            seventhCardTrumpEnabled: false,
            jokerTrumpEnabled: false,
            reverseTrumpEnabled: false,
            allTricksBonusEnabled: false,
            halfPointPenaltyEnabled: false,
            cancelOn3PassesEnabled: true,
            autoShowTrumpEnabled: false
        )
    }
    
    /// Bangladesh Classic preset - Marriage + Double + Re-Double.
    static var bangladeshClassic: RuleConfiguration {
        RuleConfiguration(
            marriageEnabled: true,
            doubleEnabled: true,
            reDoubleEnabled: true,
            singleHandEnabled: false,
            seventhCardTrumpEnabled: false,
            jokerTrumpEnabled: false,
            reverseTrumpEnabled: false,
            allTricksBonusEnabled: false,
            halfPointPenaltyEnabled: false,
            cancelOn3PassesEnabled: true,
            autoShowTrumpEnabled: false
        )
    }
    
    /// Advanced preset - All rules enabled.
    static var advanced: RuleConfiguration {
        RuleConfiguration(
            marriageEnabled: true,
            doubleEnabled: true,
            reDoubleEnabled: true,
            singleHandEnabled: true,
            seventhCardTrumpEnabled: true,
            jokerTrumpEnabled: true,
            reverseTrumpEnabled: true,
            allTricksBonusEnabled: true,
            halfPointPenaltyEnabled: true,
            cancelOn3PassesEnabled: true,
            autoShowTrumpEnabled: false
        )
    }
    
    /// Beginner preset - Marriage + Auto-show Trump.
    static var beginner: RuleConfiguration {
        RuleConfiguration(
            marriageEnabled: true,
            doubleEnabled: false,
            reDoubleEnabled: false,
            singleHandEnabled: false,
            seventhCardTrumpEnabled: false,
            jokerTrumpEnabled: false,
            reverseTrumpEnabled: false,
            allTricksBonusEnabled: false,
            halfPointPenaltyEnabled: false,
            cancelOn3PassesEnabled: true,
            autoShowTrumpEnabled: true
        )
    }
}

