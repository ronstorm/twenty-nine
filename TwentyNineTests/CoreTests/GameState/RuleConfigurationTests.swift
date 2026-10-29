//
//  RuleConfigurationTests.swift
//  TwentyNineTests
//
//  Created by Amit Sen on October 29, 2026.
//  © 2026 Coding With Amit. All rights reserved.

import Testing
@testable import TwentyNine

@Suite("RuleConfiguration Tests")
struct RuleConfigurationTests {
    @Test("Each rule toggles only its own setting", arguments: GameRule.allCases)
    func testSubscriptTogglesSingleRule(rule: GameRule) {
        var configuration = RuleConfiguration()
        let original = configuration[rule]

        configuration[rule] = !original

        #expect(configuration[rule] == !original)
        for other in GameRule.allCases where other != rule {
            #expect(configuration[other] == RuleConfiguration()[other])
        }
    }

    @Test("Standard preset enables marriage and cancel-on-3-passes only")
    func testStandardPreset() {
        let enabled = GameRule.allCases.filter { RuleConfiguration.standard[$0] }
        #expect(enabled == [.marriage, .cancelOn3Passes])
    }

    @Test("Bangladesh Classic preset adds double and re-double")
    func testBangladeshClassicPreset() {
        let enabled = GameRule.allCases.filter { RuleConfiguration.bangladeshClassic[$0] }
        #expect(enabled == [.marriage, .double, .reDouble, .cancelOn3Passes])
    }

    @Test("Advanced preset enables everything except auto-show trump")
    func testAdvancedPreset() {
        let disabled = GameRule.allCases.filter { !RuleConfiguration.advanced[$0] }
        #expect(disabled == [.autoShowTrump])
    }

    @Test("Beginner preset enables marriage, cancel-on-3-passes and auto-show trump")
    func testBeginnerPreset() {
        let enabled = GameRule.allCases.filter { RuleConfiguration.beginner[$0] }
        #expect(enabled == [.marriage, .cancelOn3Passes, .autoShowTrump])
    }

    @Test("Custom preset has no fixed configuration")
    func testCustomPreset() {
        #expect(RulePreset.custom.configuration == nil)
        #expect(RulePreset.standard.configuration == .standard)
    }
}
