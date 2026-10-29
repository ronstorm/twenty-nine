//
//  GameStateTests.swift
//  TwentyNineTests
//
//  Created by Amit Sen on October 29, 2026.
//  © 2026 Coding With Amit. All rights reserved.

import Foundation
import Testing
@testable import TwentyNine

@Suite("GameState Tests")
struct GameStateTests {
    @Test("New game is not over")
    func testNewGameNotOver() {
        #expect(!GameState().isGameOver)
    }

    @Test("Game is over at or beyond ±6 game points", arguments: [6, 7, 8, -6, -7, -8])
    func testGameOverThresholds(points: Int) {
        // A re-doubled round moves points by 4, so 4 → 8 must still end the game
        let state = GameState(northSouthScore: TeamScore(team: .northSouth, gamePoints: points))
        #expect(state.isGameOver)
    }

    @Test("Game is not over inside ±5 game points", arguments: [-5, 0, 5])
    func testGameNotOverInsideThresholds(points: Int) {
        let state = GameState(eastWestScore: TeamScore(team: .eastWest, gamePoints: points))
        #expect(!state.isGameOver)
    }

    @Test("Game points are read from the team score")
    func testGamePointsSingleSourceOfTruth() {
        var state = GameState()
        state.eastWestScore.gamePoints = 3
        #expect(state.gamePoints(for: .eastWest) == 3)
        #expect(state.gamePoints(for: .northSouth) == 0)
    }

    @Test("Trick total points are derived from its cards")
    func testTrickTotalPoints() {
        let trick = Trick(
            cards: [
                .north: Card(rank: .jack, suit: .spades),
                .west: Card(rank: .nine, suit: .spades),
                .south: Card(rank: .seven, suit: .spades),
                .east: Card(rank: .ace, suit: .hearts)
            ],
            leadPosition: .north,
            winnerPosition: .north
        )
        #expect(trick.totalPoints == 6)
        #expect(trick.isComplete)
    }

    @Test("Game state survives a JSON round trip")
    func testCodableRoundTrip() throws {
        let players = Position.allCases.map { Player(name: $0.displayName, type: .human, position: $0) }
        let state = GameState(
            players: players,
            deck: DefaultCardShuffler().createStandardDeck(),
            trumpSuit: .hearts,
            ruleConfiguration: .bangladeshClassic,
            northSouthScore: TeamScore(team: .northSouth, gamePoints: 2)
        )

        let decoded = try JSONDecoder().decode(GameState.self, from: JSONEncoder().encode(state))
        #expect(decoded == state)
    }
}
