//
//  GameFeatureTests.swift
//  TwentyNineTests
//
//  Created by Amit Sen on October 29, 2026.
//  © 2026 Coding With Amit. All rights reserved.

import TCAKit
import Testing
@testable import TwentyNine

@Suite("GameFeature Reducer Tests")
struct GameFeatureTests {
    @Test("Toggle rule updates the rule configuration")
    func testToggleRule() async {
        var state = GameFeatureState()
        #expect(state.gameState.ruleConfiguration.jokerTrumpEnabled == false)

        let effect = gameFeatureReducer(state: &state, action: .gameAction(.toggleRule(.jokerTrump, enabled: true)))

        #expect(state.gameState.ruleConfiguration.jokerTrumpEnabled)
        #expect(await effect.run() == nil)
    }

    @Test("Applying a preset replaces the configuration; custom keeps it")
    func testApplyRulePreset() {
        var state = GameFeatureState()

        _ = gameFeatureReducer(state: &state, action: .gameAction(.applyRulePreset(preset: .beginner)))
        #expect(state.gameState.ruleConfiguration == .beginner)

        _ = gameFeatureReducer(state: &state, action: .gameAction(.applyRulePreset(preset: .custom)))
        #expect(state.gameState.ruleConfiguration == .beginner)
    }

    @Test("Selecting and deselecting cards tracks stable card IDs")
    func testCardSelection() {
        var state = GameFeatureState()
        let card = Card(rank: .jack, suit: .spades)

        _ = gameFeatureReducer(state: &state, action: .gameAction(.selectCard(cardId: card.id)))
        #expect(state.gameState.selectedCards == [card.id])

        _ = gameFeatureReducer(state: &state, action: .gameAction(.deselectCards))
        #expect(state.gameState.selectedCards.isEmpty)
    }
}
