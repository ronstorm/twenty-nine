//
//  RuleValidatorTests.swift
//  TwentyNineTests
//
//  Created by Amit Sen on November 24, 2025.
//  © 2025 Coding With Amit. All rights reserved.

import Testing
@testable import TwentyNine

@Suite("RuleValidator Tests")
struct RuleValidatorTests {
    var validator: RuleValidator {
        DefaultRuleValidator()
    }
    
    @Test("Valid bid within range")
    func testValidBid() {
        #expect(validator.isValidBid(16, currentHighestBid: nil, previousBidderPosition: nil, bidderPosition: .north))
        #expect(validator.isValidBid(20, currentHighestBid: nil, previousBidderPosition: nil, bidderPosition: .north))
        #expect(validator.isValidBid(28, currentHighestBid: nil, previousBidderPosition: nil, bidderPosition: .north))
    }
    
    @Test("Invalid bid below minimum")
    func testInvalidBidBelowMinimum() {
        #expect(!validator.isValidBid(15, currentHighestBid: nil, previousBidderPosition: nil, bidderPosition: .north))
    }
    
    @Test("Invalid bid above maximum")
    func testInvalidBidAboveMaximum() {
        #expect(!validator.isValidBid(29, currentHighestBid: nil, previousBidderPosition: nil, bidderPosition: .north))
    }
    
    @Test("Bid must be higher than current bid")
    func testBidMustBeHigher() {
        #expect(validator.isValidBid(20, currentHighestBid: 18, previousBidderPosition: .east, bidderPosition: .north))
        #expect(!validator.isValidBid(17, currentHighestBid: 18, previousBidderPosition: .east, bidderPosition: .north))
    }
    
    @Test("Can match own bid")
    func testCanMatchOwnBid() {
        #expect(validator.isValidBid(18, currentHighestBid: 18, previousBidderPosition: .north, bidderPosition: .north))
    }
    
    @Test("Cannot match opponent's bid")
    func testCannotMatchOpponentBid() {
        #expect(!validator.isValidBid(18, currentHighestBid: 18, previousBidderPosition: .east, bidderPosition: .north))
    }
    
    @Test("Can play card if following suit")
    func testCanPlayCardFollowingSuit() {
        let hand = [
            Card(rank: .ace, suit: .spades),
            Card(rank: .king, suit: .hearts),
            Card(rank: .queen, suit: .spades)
        ]
        let leadCard = Card(rank: .jack, suit: .spades)
        let currentTrick: [Position: Card] = [.north: leadCard]
        
        #expect(validator.canPlayCard(
            Card(rank: .ace, suit: .spades),
            from: hand,
            in: currentTrick,
            leadCard: leadCard,
            trumpSuit: nil,
            trumpRevealed: false
        ))
    }
    
    @Test("Must follow suit if possible")
    func testMustFollowSuit() {
        let hand = [
            Card(rank: .ace, suit: .spades),
            Card(rank: .king, suit: .hearts)
        ]
        let leadCard = Card(rank: .jack, suit: .spades)
        let currentTrick: [Position: Card] = [.north: leadCard]
        
        // Cannot play hearts when have spades
        #expect(!validator.canPlayCard(
            Card(rank: .king, suit: .hearts),
            from: hand,
            in: currentTrick,
            leadCard: leadCard,
            trumpSuit: nil,
            trumpRevealed: false
        ))
    }
    
    @Test("Can play any card if cannot follow suit")
    func testCanPlayAnyCardIfCannotFollowSuit() {
        let hand = [
            Card(rank: .ace, suit: .hearts),
            Card(rank: .king, suit: .diamonds)
        ]
        let leadCard = Card(rank: .jack, suit: .spades)
        let currentTrick: [Position: Card] = [.north: leadCard]
        
        // Can play any card since don't have spades
        #expect(validator.canPlayCard(
            Card(rank: .ace, suit: .hearts),
            from: hand,
            in: currentTrick,
            leadCard: leadCard,
            trumpSuit: nil,
            trumpRevealed: false
        ))
    }
    
    @Test("Must play trump if revealed and have trump")
    func testMustPlayTrumpIfRevealed() {
        let hand = [
            Card(rank: .ace, suit: .hearts),
            Card(rank: .king, suit: .spades) // Trump
        ]
        let leadCard = Card(rank: .jack, suit: .diamonds)
        let currentTrick: [Position: Card] = [.north: leadCard]
        
        // Cannot play hearts when trump is revealed and have trump
        #expect(!validator.canPlayCard(
            Card(rank: .ace, suit: .hearts),
            from: hand,
            in: currentTrick,
            leadCard: leadCard,
            trumpSuit: .spades,
            trumpRevealed: true
        ))
        
        // Must play trump
        #expect(validator.canPlayCard(
            Card(rank: .king, suit: .spades),
            from: hand,
            in: currentTrick,
            leadCard: leadCard,
            trumpSuit: .spades,
            trumpRevealed: true
        ))
    }
    
    @Test("Can declare marriage with K+Q of trump")
    func testCanDeclareMarriage() {
        let hand = [
            Card(rank: .king, suit: .spades),
            Card(rank: .queen, suit: .spades),
            Card(rank: .ace, suit: .hearts)
        ]
        
        #expect(validator.canDeclareMarriage(
            playerHand: hand,
            trumpSuit: .spades,
            trumpRevealed: true
        ))
    }
    
    @Test("Cannot declare marriage before trump revealed")
    func testCannotDeclareMarriageBeforeTrumpRevealed() {
        let hand = [
            Card(rank: .king, suit: .spades),
            Card(rank: .queen, suit: .spades)
        ]
        
        #expect(!validator.canDeclareMarriage(
            playerHand: hand,
            trumpSuit: .spades,
            trumpRevealed: false
        ))
    }
    
    @Test("Should cancel game on 3 passes with no bids")
    func testShouldCancelGameOn3Passes() {
        #expect(validator.shouldCancelGame(
            consecutivePasses: 3,
            totalBids: 0,
            cancelOn3PassesEnabled: true
        ))
    }
    
    @Test("Should not cancel game if bids were made")
    func testShouldNotCancelGameIfBidsMade() {
        #expect(!validator.shouldCancelGame(
            consecutivePasses: 3,
            totalBids: 1,
            cancelOn3PassesEnabled: true
        ))
    }
}

