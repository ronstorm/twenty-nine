//
//  TableModelTests.swift
//  TwentyNineTests
//
//  Created by Amit Sen on October 29, 2026.
//  © 2026 Coding With Amit. All rights reserved.

import Testing
@testable import TwentyNine

@Suite("Position, Team & Player Tests")
struct TableModelTests {
    @Test("Turn order is counter-clockwise: North → West → South → East")
    func testCounterClockwiseOrder() {
        #expect(Position.north.nextPosition == .west)
        #expect(Position.west.nextPosition == .south)
        #expect(Position.south.nextPosition == .east)
        #expect(Position.east.nextPosition == .north)
    }

    @Test("Previous position undoes next position", arguments: Position.allCases)
    func testPreviousIsInverseOfNext(position: Position) {
        #expect(position.nextPosition.previousPosition == position)
    }

    @Test("Partners sit opposite and share a team", arguments: Position.allCases)
    func testPartners(position: Position) {
        #expect(position.partnerPosition.partnerPosition == position)
        #expect(Team.team(for: position) == Team.team(for: position.partnerPosition))
        #expect(Team.team(for: position).positions.contains(position))
    }

    @Test("Opponent of opponent is the same team")
    func testOpponents() {
        #expect(Team.northSouth.opponent == .eastWest)
        #expect(Team.eastWest.opponent.opponent == .eastWest)
    }

    @Test("Player team is derived from position")
    func testPlayerTeam() {
        let player = Player(name: "East", type: .ai(difficulty: .hard), position: .east)
        #expect(player.team == .eastWest)
        #expect(player.isAI)
        #expect(player.partnerPosition == .west)
    }
}
