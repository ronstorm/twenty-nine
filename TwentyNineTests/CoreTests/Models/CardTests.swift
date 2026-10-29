//
//  CardTests.swift
//  TwentyNineTests
//
//  Created by Amit Sen on November 24, 2025.
//  © 2025 Coding With Amit. All rights reserved.

import Testing
@testable import TwentyNine

@Suite("Card Tests")
struct CardTests {
    @Test("Point values follow TwentyNine scoring (J=3, 9=2, A=1, 10=1)")
    func testPointValues() {
        let expected: [Rank: Int] = [
            .jack: 3, .nine: 2, .ace: 1, .ten: 1,
            .king: 0, .queen: 0, .eight: 0, .seven: 0
        ]
        for rank in Rank.allCases {
            #expect(Card(rank: rank, suit: .spades).pointValue == expected[rank])
        }
    }

    @Test("A full deck is worth 28 points")
    func testDeckTotalPoints() {
        let deck = DefaultCardShuffler().createStandardDeck()
        #expect(deck.reduce(0) { $0 + $1.pointValue } == 28)
    }

    @Test("Ranks order J > 9 > A > 10 > K > Q > 8 > 7")
    func testRankOrdering() {
        let highToLow: [Rank] = [.jack, .nine, .ace, .ten, .king, .queen, .eight, .seven]
        #expect(Rank.allCases.sorted(by: >) == highToLow)
    }

    @Test("Cards with equal rank sort by suit declaration order")
    func testSuitTieBreak() {
        let cards = Suit.allCases.reversed().map { Card(rank: .ace, suit: $0) }
        #expect(cards.sorted().map(\.suit) == [.spades, .hearts, .diamonds, .clubs])
    }

    @Test("Card identity is stable for the same rank and suit")
    func testStableIdentity() {
        let first = Card(rank: .jack, suit: .spades)
        let second = Card(rank: .jack, suit: .spades)
        #expect(first == second)
        #expect(first.id == second.id)
        #expect(first.id != Card(rank: .jack, suit: .hearts).id)
    }

    @Test("Standard deck has 32 unique card IDs")
    func testDeckIDsAreUnique() {
        let deck = DefaultCardShuffler().createStandardDeck()
        #expect(Set(deck.map(\.id)).count == 32)
    }

    @Test("Display name and description")
    func testDisplayText() {
        let card = Card(rank: .jack, suit: .spades)
        #expect(card.displayName == "J♠")
        #expect(card.fullDescription == "Jack of Spades")
    }
}
