//
//  AppDependencies.swift
//  TwentyNine
//
//  Created by Amit Sen on October 29, 2026.
//  © 2026 Coding With Amit. All rights reserved.

import Foundation

/// The services view models depend on, injected through their initializers.
///
/// The coordinator builds view models with `.live`; tests pass a container
/// with stub or seeded implementations instead.
struct AppDependencies: Sendable {
    var cardShuffler: any CardShuffler
    var cardDealer: any CardDealer
    var ruleValidator: any RuleValidator
    var scoreCalculator: any ScoreCalculator

    /// Production implementations of every service.
    static let live = AppDependencies(
        cardShuffler: DefaultCardShuffler(),
        cardDealer: DefaultCardDealer(),
        ruleValidator: DefaultRuleValidator(),
        scoreCalculator: DefaultScoreCalculator()
    )
}
