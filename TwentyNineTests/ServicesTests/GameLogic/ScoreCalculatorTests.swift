//
//  ScoreCalculatorTests.swift
//  TwentyNineTests
//
//  Created by Amit Sen on November 24, 2025.
//  © 2025 Coding With Amit. All rights reserved.

import Testing
@testable import TwentyNine

@Suite("ScoreCalculator Tests")
struct ScoreCalculatorTests {
    var calculator: ScoreCalculator {
        DefaultScoreCalculator()
    }
    
    @Test("Calculate card points correctly")
    func testCalculateCardPoints() {
        let cards = [
            Card(rank: .jack, suit: .spades),    // 3 points
            Card(rank: .nine, suit: .hearts),    // 2 points
            Card(rank: .ace, suit: .diamonds),   // 1 point
            Card(rank: .ten, suit: .clubs),       // 1 point
            Card(rank: .king, suit: .spades),     // 0 points
            Card(rank: .seven, suit: .hearts)     // 0 points
        ]
        
        let points = calculator.calculateCardPoints(from: cards)
        #expect(points == 7) // 3 + 2 + 1 + 1 + 0 + 0
    }
    
    @Test("Calculate trick points")
    func testCalculateTrickPoints() {
        let trick = Trick(
            cards: [
                .north: Card(rank: .jack, suit: .spades),   // 3 points
                .east: Card(rank: .nine, suit: .hearts),   // 2 points
                .south: Card(rank: .ace, suit: .diamonds), // 1 point
                .west: Card(rank: .ten, suit: .clubs)      // 1 point
            ],
            leadPosition: .north,
            winnerPosition: .north,
            totalPoints: 7
        )
        
        let points = calculator.calculateTrickPoints(trick)
        #expect(points == 7)
    }
    
    @Test("Calculate team score with marriage bonus")
    func testCalculateTeamScore() {
        let tricks = [
            Trick(
                cards: [
                    .north: Card(rank: .jack, suit: .spades),   // 3 points
                    .east: Card(rank: .king, suit: .hearts),    // 0 points
                    .south: Card(rank: .ace, suit: .diamonds),  // 1 point
                    .west: Card(rank: .ten, suit: .clubs)        // 1 point
                ],
                leadPosition: .north,
                winnerPosition: .north,
                totalPoints: 5  // 3 + 0 + 1 + 1 = 5
            )
        ]
        
        let score = calculator.calculateTeamScore(tricks: tricks, marriageBonus: 4)
        #expect(score == 9) // 5 trick points + 4 marriage bonus
    }
    
    @Test("Calculate adjusted bid with bidder marriage")
    func testCalculateAdjustedBidBidderMarriage() {
        let adjusted = calculator.calculateAdjustedBid(
            originalBid: 20,
            marriageDeclaredByBidder: true,
            marriageDeclaredByOpponent: false
        )
        
        #expect(adjusted == 16) // 20 - 4 = 16
    }
    
    @Test("Calculate adjusted bid with opponent marriage")
    func testCalculateAdjustedBidOpponentMarriage() {
        let adjusted = calculator.calculateAdjustedBid(
            originalBid: 20,
            marriageDeclaredByBidder: false,
            marriageDeclaredByOpponent: true
        )
        
        #expect(adjusted == 24) // 20 + 4 = 24
    }
    
    @Test("Calculate adjusted bid clamped to minimum")
    func testCalculateAdjustedBidClampedToMinimum() {
        let adjusted = calculator.calculateAdjustedBid(
            originalBid: 16,
            marriageDeclaredByBidder: true,
            marriageDeclaredByOpponent: false
        )
        
        #expect(adjusted == 16) // 16 - 4 = 12, but clamped to 16
    }
    
    @Test("Calculate adjusted bid clamped to maximum")
    func testCalculateAdjustedBidClampedToMaximum() {
        let adjusted = calculator.calculateAdjustedBid(
            originalBid: 28,
            marriageDeclaredByBidder: false,
            marriageDeclaredByOpponent: true
        )
        
        #expect(adjusted == 28) // 28 + 4 = 32, but clamped to 28
    }
    
    @Test("Bidding team wins if score meets bid")
    func testDidBiddingTeamWin() {
        #expect(calculator.didBiddingTeamWin(teamScore: 20, adjustedBid: 20))
        #expect(calculator.didBiddingTeamWin(teamScore: 25, adjustedBid: 20))
        #expect(!calculator.didBiddingTeamWin(teamScore: 19, adjustedBid: 20))
    }
    
    @Test("Calculate game points change for win")
    func testCalculateGamePointsChangeWin() {
        let change = calculator.calculateGamePointsChange(
            biddingTeamWon: true,
            isDoubled: false,
            isReDoubled: false,
            allTricksBonusEnabled: false,
            allTricksWon: false
        )
        
        #expect(change == 1)
    }
    
    @Test("Calculate game points change for loss")
    func testCalculateGamePointsChangeLoss() {
        let change = calculator.calculateGamePointsChange(
            biddingTeamWon: false,
            isDoubled: false,
            isReDoubled: false,
            allTricksBonusEnabled: false,
            allTricksWon: false
        )
        
        #expect(change == -1)
    }
    
    @Test("Calculate game points change with double")
    func testCalculateGamePointsChangeWithDouble() {
        let winChange = calculator.calculateGamePointsChange(
            biddingTeamWon: true,
            isDoubled: true,
            isReDoubled: false,
            allTricksBonusEnabled: false,
            allTricksWon: false
        )
        #expect(winChange == 2) // 1 * 2
        
        let lossChange = calculator.calculateGamePointsChange(
            biddingTeamWon: false,
            isDoubled: true,
            isReDoubled: false,
            allTricksBonusEnabled: false,
            allTricksWon: false
        )
        #expect(lossChange == -2) // -1 * 2
    }
    
    @Test("Calculate game points change with re-double")
    func testCalculateGamePointsChangeWithReDouble() {
        let winChange = calculator.calculateGamePointsChange(
            biddingTeamWon: true,
            isDoubled: false,
            isReDoubled: true,
            allTricksBonusEnabled: false,
            allTricksWon: false
        )
        #expect(winChange == 4) // 1 * 4
        
        let lossChange = calculator.calculateGamePointsChange(
            biddingTeamWon: false,
            isDoubled: false,
            isReDoubled: true,
            allTricksBonusEnabled: false,
            allTricksWon: false
        )
        #expect(lossChange == -4) // -1 * 4
    }
    
    @Test("Calculate game points change with all tricks bonus")
    func testCalculateGamePointsChangeWithAllTricksBonus() {
        let change = calculator.calculateGamePointsChange(
            biddingTeamWon: true,
            isDoubled: false,
            isReDoubled: false,
            allTricksBonusEnabled: true,
            allTricksWon: true
        )
        
        #expect(change == 2) // 1 + 1 bonus
    }
}

