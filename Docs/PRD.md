# Product Requirements Document: TwentyNine Card Game

**Version:** 1.0  
**Last Updated:** November 22, 2025  
**Author:** Coding With Amit

---

## 1. Product Overview

### 1.1 Vision
Create an authentic, visually stunning digital version of the popular South Asian card game "TwentyNine" (29) that preserves the traditional gameplay while offering modern features like configurable rules, smooth animations, and intelligent AI opponents.

### 1.2 Purpose
- Bring the beloved TwentyNine card game to digital platforms
- Make the game accessible to players worldwide
- Preserve cultural gaming traditions through technology
- Provide a learning tool for new players
- Offer flexibility with configurable rules to match regional variations

### 1.3 Target Audience
- **Primary**: South Asian diaspora (Bangladesh, India, Pakistan)
- **Secondary**: Card game enthusiasts globally
- **Age Range**: 12+ (card game players)
- **Technical Level**: All levels (casual to serious gamers)

### 1.4 Success Criteria
- Authentic gameplay that matches physical card game experience
- Smooth, performant animations at 60fps
- AI opponents that provide challenging gameplay
- Rule configurations that cover major regional variations
- Intuitive UI that newcomers can understand

---

## 2. Technical Architecture

### 2.1 State Management
**Framework**: [TCAKit](https://github.com/ronstorm/tca-kit) - Lightweight TCA implementation

**Why TCAKit?**
- SwiftUI-first architecture
- Built-in async/await support
- Lightweight with no external dependencies
- Clear separation of concerns (State, Actions, Reducers, Effects)
- Excellent testing support with TestStore
- Dependency injection system

### 2.2 UI Framework
**Primary**: SwiftUI

**Supported Platforms**:
- iOS 17.0+
- iPadOS 17.0+
- macOS 14.0+ (Sonoma)
- tvOS 17.0+
- visionOS 1.0+

### 2.3 Animation Architecture

#### Heavy Animations (Core Animation, Metal, Core Graphics)
Use for performance-critical animations:
- **Card dealing** - Fast, smooth distribution of 32 cards
- **Card flipping** - 3D rotation effects with realistic physics
- **Card sliding/throwing** - Complex motion paths and trajectories
- **Trump reveal animation** - Dramatic card flip with particle effects
- **Trick collection** - Cards flying to winner's pile with scaling/rotation
- **Score counter animations** - Smooth number transitions and celebrations
- **Victory/Defeat sequences** - Full-screen particle effects and transitions

**Technologies**:
- **Core Animation**: Layer-based animations, CATransform3D for card flips
- **Metal**: GPU-accelerated particle systems for celebrations, confetti, sparkles
- **Core Graphics**: Custom card rendering, shadows, gradients

#### Simple Animations (SwiftUI)
Use for lightweight UI feedback:
- **Button press states** - Scale, opacity changes
- **Menu transitions** - Fade in/out, slide transitions
- **Highlight effects** - Glow on selected cards
- **Badge/notification pop-ups** - Scale and fade
- **Settings panel slides** - Standard SwiftUI transitions
- **Text updates** - Number changes, score updates

### 2.4 Architecture Layers

```
┌─────────────────────────────────────┐
│         SwiftUI Views               │
│  (UI Layer - Declarative)           │
└──────────┬──────────────────────────┘
           │
┌──────────▼──────────────────────────┐
│      TCAKit Store                   │
│  (State Management Layer)           │
│  • State: Game state model          │
│  • Actions: User & system events    │
│  • Reducers: State transitions      │
│  • Effects: Async operations        │
└──────────┬──────────────────────────┘
           │
┌──────────▼──────────────────────────┐
│      Business Logic Layer           │
│  • Game rules engine                │
│  • AI decision making               │
│  • Validation logic                 │
│  • Score calculation                │
└──────────┬──────────────────────────┘
           │
┌──────────▼──────────────────────────┐
│      Animation Layer                │
│  • Core Animation controllers       │
│  • Metal renderer (particles)       │
│  • Core Graphics helpers            │
└─────────────────────────────────────┘
```

---

## 3. Core Features (MVP)

### 3.1 Game Setup & Configuration

#### 3.1.1 Main Menu
- **Start New Game**
- **Continue Game** (if saved state exists)
- **Game Settings** (rule configuration)
- **Tutorial** (learn to play)
- **About** (credits, version)

#### 3.1.2 Player Configuration
- 4 players total (fixed partnerships)
- Player types:
  - **Human** - Local player
  - **AI (Easy)** - Beginner-level AI
  - **AI (Medium)** - Intermediate AI
  - **AI (Hard)** - Advanced AI with card counting
- Team setup: Opposite players are partners (North-South, East-West)
- Player names (optional customization)

#### 3.1.3 Rule Configuration System
**Core Rules** (always active):
- 32-card deck (7, 8, Q, K, 10, A, 9, J per suit)
- Card ranking: J > 9 > A > 10 > K > Q > 8 > 7
- Point values: J=3, 9=2, A=1, 10=1 (total 28 points)
- Counter-clockwise play
- Must follow suit if possible
- Bidding range: 16-28
- Trump selection via 2-5 cards
- Game ends at +6 or -6 points

**Configurable Rules** (toggleable):

| Rule | Default | Description |
|------|---------|-------------|
| **Marriage (Pair)** | ON | K+Q of trump = ±4 points to bid |
| **Double** | ON | Opponents can challenge bid (±2 points) |
| **Re-Double** | ON | Bidder can counter double (±4 points) |
| **Single Hand** | ON | One player plays alone vs 3 |
| **7th Card Trump** | ON | Trump revealed by 7th card |
| **Joker Trump** | OFF | Only highest card wins |
| **Reverse Trump** | OFF | 7 highest, J lowest in trump |
| **All Tricks Bonus** | ON | +1 if team wins all 8 tricks |
| **Half-Point Penalty** | OFF | Extra penalty if < half bid won |
| **Cancel on 3 Passes** | ON | Game cancelled if first 3 pass |
| **Auto-show Trump** | OFF | Reveal trump immediately |

**Rule Presets**:
- **Standard** - Marriage only
- **Bangladesh Classic** - Marriage + Double + Re-Double
- **Advanced** - All rules enabled
- **Beginner** - Marriage + Auto-show Trump
- **Custom** - User-defined combination

### 3.2 Game Flow

#### 3.2.1 Dealing Phase
1. Dealer shuffles deck (shuffle animation)
2. Deal 4 cards to each player (counter-clockwise)
3. Cards fly smoothly to player positions with stagger delay
4. Human player can view their cards immediately
5. Wait state for player to review hand

#### 3.2.2 Bidding Phase
**UI Elements**:
- Current highest bid display
- Player turn indicator (rotating highlight)
- Bid options: 16-28 or Pass
- Bid history log (who bid what)

**Logic**:
- Starts with player to dealer's right
- Must bid higher than current bid OR match if you placed it
- Continues until 3 consecutive passes
- Highest bidder wins and selects trump
- AI uses strategy based on:
  - Point cards in hand (J, 9, A, 10)
  - Suit distribution
  - Partner's bids
  - Difficulty level

**Cancel Conditions** (if enabled):
- First 3 players pass without any bid
- No trump cards in team (rare validation)
- All Jacks in one hand (optional rule)

#### 3.2.3 Trump Selection
**UI**:
- Bidder sees 4 trump indicator cards (2♠, 3♥, 4♦, 5♣)
- Select one to set trump suit
- Card placed face-down in center
- Animation: Card slides to table center with flip-down

**Logic**:
- Trump hidden from other players initially
- Can be revealed when:
  - Player can't follow suit and asks to reveal
  - Auto-reveal rule is enabled
  - 7th card rule triggers

#### 3.2.4 Card Distribution (Second Deal)
- Deal remaining 4 cards to each player
- Each player now has 8 cards total
- Cards dealt counter-clockwise with animation

#### 3.2.5 Trick-Taking Phase
**Play Structure**:
- 8 tricks total
- Player to dealer's right leads first trick
- Must follow suit if possible
- If can't follow: may ask to reveal trump
- If trump revealed and player has trump: must play trump
- Highest trump wins, or highest card of lead suit

**UI Elements**:
- **Card Table**: 4 positions (N, S, E, W)
- **Played Cards Area**: Center of table
- **Current Trick**: Shows 4 cards being played
- **Trick Count**: "Trick 3 of 8"
- **Lead Suit Indicator**: Shows current suit to follow
- **Trump Status**: Hidden/Revealed with suit icon
- **Player Highlight**: Whose turn it is
- **Valid Card Highlighting**: Legal plays glow slightly

**Animations**:
- Card slides from hand to table (Core Animation)
- 3D flip if playing face-up card
- Card stacks slightly offset when multiple played
- Winner's cards fly to their trick pile
- Smooth scaling and rotation during collection

**Marriage Declaration**:
- If player has K+Q of trump (after trump revealed)
- "Declare Marriage?" popup appears
- Bid adjusts by ±4 points
- Visual celebration (sparkles, badge)

#### 3.2.6 Scoring Phase
**Calculation**:
1. Count card points for bidding team
2. Apply marriage adjustments
3. Check if bid met/exceeded
4. Award +1 or -1 game point
5. Update red/black 6 counter

**UI**:
- Score summary card appears
- Shows:
  - Team points collected
  - Original bid
  - Adjusted bid (if marriage)
  - Result: Success/Failure
  - Game points awarded
- Celebration animation if bid met
- Defeat animation if failed
- Red/Black 6 counter updates visually

**Victory Condition**:
- First team to reach +6 (6 red) wins
- First team to reach -6 (6 black) loses
- Victory screen with confetti (Metal particle system)

---

## 4. Game Modes

### 4.1 Single Player vs AI (MVP)
- Human + 3 AI opponents
- Choose AI difficulty per opponent
- AI plays both teams (2 AI vs Human + AI partner)

### 4.2 Local Multiplayer - Pass & Play (MVP)
- 4 human players
- Pass device after each turn
- Screen hides cards when passing

### 4.3 Tutorial Mode (MVP)
- Interactive step-by-step guide
- Explains each phase with highlighting
- Practice bidding
- Practice trick-taking
- Shows legal moves
- Explains scoring

### 4.4 Practice Mode (Post-MVP)
- Play specific scenarios
- Practice bidding with different hands
- Practice trump timing
- No score tracking

### 4.5 Online Multiplayer (Post-MVP - Future)
- Real-time multiplayer via Game Center / CloudKit
- Matchmaking system
- Friend invitations
- Chat/Emotes
- Leaderboards

---

## 5. User Interface & Experience

### 5.1 Visual Design Principles
- **Authentic**: Feels like a real card table
- **Clear**: Always know what's happening
- **Responsive**: Immediate feedback on all actions
- **Beautiful**: Polished animations and transitions
- **Accessible**: Readable fonts, color-blind friendly

### 5.2 Screen Layouts

#### 5.2.1 Main Menu
```
┌──────────────────────────────────┐
│                                  │
│         TwentyNine                │
│         [Card Icon]               │
│                                  │
│     [Start New Game]             │
│     [Continue]                   │
│     [Tutorial]                   │
│     [Settings]                   │
│     [About]                      │
│                                  │
└──────────────────────────────────┘
```

#### 5.2.2 Game Table (Main Game View)
```
┌──────────────────────────────────┐
│  [Settings]  Trick 3/8  [Menu]   │
│                                  │
│         [Opponent Cards]         │
│              North               │
│                                  │
│  West    [Played Cards]   East   │
│  [Cards]  [Trump:?]    [Cards]   │
│                                  │
│              South               │
│        [Your Hand Cards]         │
│                                  │
│  Score: R-3 | B-0  Bid: 22       │
└──────────────────────────────────┘
```

#### 5.2.3 Bidding Panel
```
┌──────────────────────────────────┐
│      Your Turn to Bid            │
│                                  │
│  Current Bid: 20 (by East)       │
│                                  │
│  [16][17][18][19][20]            │
│  [21][22][23][24][25]            │
│  [26][27][28]                    │
│                                  │
│         [Pass]                   │
│                                  │
│  History: West:16, North:Pass    │
│          East:20                 │
└──────────────────────────────────┘
```

### 5.3 Card Design
- **Front**: Traditional playing card design
  - Large rank (7, 8, Q, K, 10, A, 9, J)
  - Suit symbols (♠ ♥ ♦ ♣)
  - Corner pips
  - Optional: Custom illustrated face cards
- **Back**: Geometric pattern or custom design
- **Size**: Scales based on screen size
- **Shadow**: Subtle shadow for depth
- **Selected State**: Slight raise + glow

### 5.4 Animation Specifications

#### Core Animation (Heavy)
| Animation | Technique | Duration | Easing |
|-----------|-----------|----------|--------|
| Card Deal | CAKeyframeAnimation | 0.3s per card | ease-out |
| Card Flip | CATransform3D rotation | 0.4s | ease-in-out |
| Card Throw | CABasicAnimation + path | 0.5s | ease-in |
| Trick Collect | CAAnimationGroup | 0.6s | ease-in |
| Trump Reveal | 3D flip + scale | 0.8s | spring |

#### Metal (Particles)
| Effect | Use Case | Particle Count |
|--------|----------|----------------|
| Sparkles | Marriage declaration | 50-100 |
| Confetti | Victory screen | 200-500 |
| Card Trail | Fast deal | 10-20 per card |
| Glow Aura | Selected card | Continuous |
| Explosion | All tricks bonus | 100-200 |

#### SwiftUI (Simple)
| Animation | Technique | Duration |
|-----------|-----------|----------|
| Button Press | .scaleEffect | 0.1s |
| Menu Slide | .slide transition | 0.3s |
| Text Update | .contentTransition | 0.2s |
| Badge Pop | .scale + .opacity | 0.25s |
| Highlight | .opacity | 0.15s |

### 5.5 Audio Design (Post-MVP)
- Card shuffle sound
- Card flip sound
- Card slide/throw sound
- Bid selection click
- Trump reveal sound (dramatic)
- Marriage declaration sound
- Victory fanfare
- Defeat sound
- Background ambient music (toggleable)

---

## 6. State Management with TCAKit

### 6.1 Core State Structure

```swift
struct GameState: Equatable {
    // Players
    var players: [Player]
    var currentPlayerIndex: Int
    var dealerIndex: Int
    
    // Game Phase
    var gamePhase: GamePhase
    
    // Cards
    var deck: [Card]
    var playerHands: [PlayerID: [Card]]
    var currentTrick: [PlayerID: Card]
    var tricks: [PlayerID: [Trick]]
    
    // Bidding
    var bids: [Bid]
    var currentBid: Int?
    var biddingTeam: Team?
    var trumpSuit: Suit?
    var trumpRevealed: Bool
    
    // Rules
    var ruleConfiguration: RuleConfiguration
    
    // Scoring
    var teamAScore: TeamScore
    var teamBScore: TeamScore
    var gamePoints: [Team: Int] // Red/Black 6 counter
    
    // UI State
    var selectedCards: Set<Card>
    var animationQueue: [GameAnimation]
    var showingAlert: AlertType?
    var isProcessing: Bool
}

enum GamePhase: Equatable {
    case setup
    case dealingFirstCards
    case bidding
    case trumpSelection
    case dealingSecondCards
    case playingTricks
    case scoringRound
    case gameOver(winner: Team)
}

struct RuleConfiguration: Equatable {
    var marriageEnabled: Bool = true
    var doubleEnabled: Bool = false
    var reDoubleEnabled: Bool = false
    var singleHandEnabled: Bool = false
    var seventhCardTrumpEnabled: Bool = false
    var jokerTrumpEnabled: Bool = false
    var reverseTrumpEnabled: Bool = false
    var allTricksBonusEnabled: Bool = false
    var halfPointPenaltyEnabled: Bool = false
    var cancelOn3PassesEnabled: Bool = true
    var autoShowTrumpEnabled: Bool = false
}
```

### 6.2 Actions

```swift
enum GameAction: Equatable {
    // Game Flow
    case startNewGame(ruleConfig: RuleConfiguration)
    case dealCards
    case nextPhase
    
    // Bidding
    case placeBid(amount: Int)
    case passBid
    case selectTrump(suit: Suit)
    
    // Playing
    case selectCard(Card)
    case playCard(Card)
    case requestTrumpReveal
    case declareMarriage
    
    // AI
    case aiTurn
    case aiDecisionMade(AIDecision)
    
    // Scoring
    case calculateScore
    case updateGamePoints
    
    // UI
    case showAlert(AlertType)
    case dismissAlert
    case toggleRuleSetting(keyPath: WritableKeyPath<RuleConfiguration, Bool>)
    
    // Animation
    case animationCompleted(GameAnimation)
    case processNextAnimation
    
    // System
    case saveGameState
    case loadGameState
}
```

### 6.3 Dependencies

```swift
struct GameDependencies {
    var cardShuffler: CardShuffler
    var aiEngine: AIEngine
    var ruleValidator: RuleValidator
    var scoreCalculator: ScoreCalculator
    var animationController: AnimationController
    var persistenceService: PersistenceService
    var soundManager: SoundManager
}

// Extend TCAKit Dependencies
extension Dependencies {
    var cardShuffler: CardShuffler {
        get { self[CardShufflerKey.self] }
        set { self[CardShufflerKey.self] = newValue }
    }
    
    var aiEngine: AIEngine {
        get { self[AIEngineKey.self] }
        set { self[AIEngineKey.self] = newValue }
    }
    
    // ... other dependencies
}
```

### 6.4 Reducer Structure

```swift
func gameReducer(
    state: inout GameState,
    action: GameAction,
    dependencies: Dependencies
) -> Effect<GameAction> {
    switch action {
    case .startNewGame(let config):
        state = GameState(ruleConfiguration: config)
        return .send(.dealCards)
        
    case .dealCards:
        let shuffled = dependencies.cardShuffler.shuffle()
        state.deck = shuffled
        // Deal 4 cards to each player
        state.gamePhase = .bidding
        return .none
        
    case .placeBid(let amount):
        guard dependencies.ruleValidator.isValidBid(amount, current: state.currentBid) else {
            return .send(.showAlert(.invalidBid))
        }
        state.bids.append(Bid(player: state.currentPlayerIndex, amount: amount))
        state.currentBid = amount
        return .send(.nextPhase)
        
    case .playCard(let card):
        // Validate move
        guard dependencies.ruleValidator.canPlayCard(card, state: state) else {
            return .send(.showAlert(.invalidPlay))
        }
        
        // Play card
        state.currentTrick[state.currentPlayerIndex] = card
        state.playerHands[state.currentPlayerIndex]?.remove(card)
        
        // Check if trick complete
        if state.currentTrick.count == 4 {
            return .send(.calculateScore)
        }
        
        return .send(.aiTurn)
        
    case .aiTurn:
        return .run { send in
            let decision = await dependencies.aiEngine.makeDecision(state: state)
            await send(.aiDecisionMade(decision))
        }
        
    // ... other cases
        
    default:
        return .none
    }
}
```

---

## 7. AI Strategy

### 7.1 AI Difficulty Levels

#### Easy AI
- **Bidding**: Bids based only on point cards in hand
- **Trump Selection**: Random suit with most point cards
- **Play Strategy**: 
  - Plays highest card if winning
  - Plays lowest card if losing
  - No card counting
  - No partner awareness

#### Medium AI
- **Bidding**: 
  - Considers suit distribution
  - Adjusts for long suits
  - Basic probability
- **Trump Selection**: Strongest suit by points + length
- **Play Strategy**:
  - Remembers trump status
  - Tracks high cards played
  - Basic partner support (doesn't override partner's win)
  - Tries to win tricks with points

#### Hard AI
- **Bidding**:
  - Advanced probability calculations
  - Considers partner's bids
  - Adjusts for game score situation
- **Trump Selection**: Optimal suit based on:
  - Point potential
  - Void suits (can trump more)
  - Marriage potential
- **Play Strategy**:
  - Full card counting (tracks all 32 cards)
  - Infers opponent hands from bids
  - Strategic trump timing
  - Partner coordination:
    - Gives partner point cards
    - Protects partner's high cards
  - Endgame planning (knows exact remaining cards)

### 7.2 AI Decision Trees

**Bidding Decision**:
```
1. Count point cards in hand
2. Evaluate suit strength (length + points)
3. Calculate win probability
4. If probability > threshold[difficulty]:
   - Bid = estimated_points + confidence_buffer
5. Else:
   - Pass
```

**Trump Selection**:
```
1. For each suit:
   - Count point cards
   - Count trump-able cards in other suits
   - Check for Marriage
2. Score each suit
3. Select highest scoring suit
```

**Play Decision**:
```
1. Identify legal plays (follow suit rule)
2. If leading:
   - Play low from long suit (preserve high cards)
   - Or play point card to collect
3. If following:
   - If partner winning: play lowest legal card
   - If opponent winning:
     - Try to beat with minimal card
     - Or dump lowest card
4. Trump decision:
   - Trump if trick has 3+ points
   - Don't trump partner's winner
```

---

## 8. User Stories & Flows

### 8.1 Critical User Stories

**As a new player:**
- I want to learn the rules through an interactive tutorial
- I want clear visual indicators of what actions are legal
- I want explanations of why certain moves are invalid
- I want to play against easy AI to practice

**As an experienced player:**
- I want to configure rules to match my regional variation
- I want challenging AI opponents
- I want fast, smooth gameplay without lag
- I want to track my win/loss statistics

**As a cultural enthusiast:**
- I want authentic card designs
- I want traditional rule variants
- I want to share the game with friends
- I want the game to feel like playing in person

### 8.2 Key User Flows

#### Flow 1: First Time User
```
1. Open app → Main menu
2. Tap "Tutorial"
3. Step-by-step interactive guide:
   - Card rankings explanation
   - Bidding practice
   - Trump reveal practice
   - Play 1 complete game with hints
4. Tutorial complete → Encouraged to play vs Easy AI
5. Start first real game
```

#### Flow 2: Quick Game
```
1. Open app → Main menu
2. Tap "Start New Game"
3. Quick setup screen:
   - Select opponents (3 AI) with difficulty
   - Choose rule preset or Custom
4. Confirm → Game starts immediately
5. Play through game phases
6. View results
7. Options: Play Again / Return to Menu
```

#### Flow 3: Custom Rules Game
```
1. Main menu → Settings
2. Configure rules:
   - Toggle each rule on/off
   - Preview what each rule does
   - Save as custom preset
3. Back → Start New Game
4. Select "Custom" preset
5. Game uses configured rules
```

---

## 9. Data Models

### 9.1 Core Models

```swift
struct Card: Identifiable, Equatable, Hashable {
    let id: UUID
    let rank: Rank
    let suit: Suit
    
    var pointValue: Int {
        switch rank {
        case .jack: return 3
        case .nine: return 2
        case .ace: return 1
        case .ten: return 1
        default: return 0
        }
    }
}

enum Rank: Int, CaseIterable {
    case seven = 7
    case eight = 8
    case queen = 9
    case king = 10
    case ten = 11
    case ace = 12
    case nine = 13
    case jack = 14
    
    // Rank value is based on power, not face value
}

enum Suit: String, CaseIterable {
    case spades, hearts, diamonds, clubs
    
    var symbol: String {
        switch self {
        case .spades: return "♠"
        case .hearts: return "♥"
        case .diamonds: return "♦"
        case .clubs: return "♣"
        }
    }
}

struct Player: Identifiable, Equatable {
    let id: UUID
    let name: String
    let type: PlayerType
    let position: Position
    var team: Team
}

enum PlayerType: Equatable {
    case human
    case ai(difficulty: AIDifficulty)
}

enum AIDifficulty: String, CaseIterable {
    case easy, medium, hard
}

enum Position: String, CaseIterable {
    case north, east, south, west
}

enum Team: String {
    case northSouth // Team A
    case eastWest   // Team B
}

struct Bid: Equatable {
    let player: Int
    let amount: Int
    let timestamp: Date
}

struct Trick: Equatable {
    let cards: [PlayerID: Card]
    let winner: PlayerID
    let points: Int
}

struct TeamScore: Equatable {
    var points: Int = 0
    var tricksWon: Int = 0
    var marriageBonus: Int = 0
}
```

---

## 10. Technical Requirements

### 10.1 Performance
- **Frame Rate**: Maintain 60fps during all animations
- **Launch Time**: < 2 seconds to main menu
- **Game Start**: < 1 second from "Start" to dealt cards
- **AI Response**: < 1 second for easy/medium, < 2 seconds for hard
- **Memory**: < 150MB RAM during active gameplay
- **Battery**: < 5% battery drain per 30-minute game session

### 10.2 Testing Strategy

#### Unit Tests
- Game rule validation
- Score calculation
- AI decision logic
- Card shuffling
- Bid validation
- TCAKit reducers (using TestStore)

#### Integration Tests
- Complete game flow (setup → game over)
- Rule configuration changes
- State persistence
- AI vs AI games

#### UI Tests
- Navigation flows
- Button interactions
- Card selection
- Animation completion

#### Manual Testing
- Accessibility (VoiceOver, Dynamic Type)
- Different screen sizes (iPhone SE → iPad Pro)
- Dark mode
- Orientation changes (iPad)
- Interruptions (phone calls, backgrounding)

### 10.3 Accessibility
- **VoiceOver**: Full support for blind players
  - Card descriptions ("Jack of Spades")
  - Game phase announcements
  - Score updates
  - Turn indicators
- **Dynamic Type**: Text scales appropriately
- **Reduce Motion**: Disable animations if system setting enabled
- **Color Blind Support**: Suit symbols + colors, high contrast mode
- **Haptics**: Tactile feedback for important events (iOS/iPadOS)

### 10.4 Localization (Post-MVP)
- **Phase 1**: English
- **Phase 2**: Bengali, Hindi, Urdu
- **Phase 3**: Additional languages based on demand

### 10.5 Data Persistence
- **Game State**: Save/restore in-progress games
- **Settings**: Rule preferences, player names
- **Statistics**: Win/loss records, games played
- **Storage**: UserDefaults for settings, FileManager for game states

---

## 11. Development Phases

### Phase 1: Foundation (MVP Core)
**Goal**: Playable basic game
- [ ] Project setup + TCAKit integration
- [ ] Core data models
- [ ] Basic UI layouts (main menu, game table)
- [ ] Card rendering
- [ ] Deal animation (Core Animation)
- [ ] Game state machine
- [ ] Standard rules implementation
- [ ] Basic AI (Easy level)
- [ ] Bidding UI and logic
- [ ] Trick-taking logic
- [ ] Score calculation
- [ ] Victory/defeat screen

**Deliverable**: Single player vs 3 Easy AI opponents with standard rules

### Phase 2: Polish & Animation
**Goal**: Production-quality feel
- [ ] Advanced animations (Core Animation for all card movements)
- [ ] Metal particle systems (victory, marriage, celebrations)
- [ ] Card flip 3D animations
- [ ] Smooth trick collection
- [ ] Trump reveal animation
- [ ] UI polish (shadows, gradients, spacing)
- [ ] Sound effects
- [ ] Haptic feedback

**Deliverable**: Visually stunning game experience

### Phase 3: Advanced Features
**Goal**: Full feature set
- [ ] Medium & Hard AI
- [ ] Rule configuration system
- [ ] Rule presets
- [ ] Tutorial mode
- [ ] Pass & play multiplayer
- [ ] Game statistics
- [ ] Settings screen
- [ ] About screen
- [ ] Dark mode support

**Deliverable**: Feature-complete game ready for beta

### Phase 4: Testing & Optimization
**Goal**: Production ready
- [ ] Comprehensive test suite
- [ ] Performance optimization
- [ ] Memory leak fixes
- [ ] Bug fixes
- [ ] Accessibility improvements
- [ ] Multi-device testing
- [ ] Beta testing with users

**Deliverable**: Stable, tested app ready for release

### Phase 5: Post-Launch (Future)
- [ ] Online multiplayer
- [ ] Leaderboards
- [ ] Achievements
- [ ] Daily challenges
- [ ] Customizable card designs
- [ ] Alternative themes
- [ ] Localization
- [ ] watchOS companion app
- [ ] Widget support

---

## 12. Success Metrics

### 12.1 Technical Metrics
- **Crash Rate**: < 0.1%
- **Frame Rate**: 60fps 95%+ of the time
- **Load Times**: Meet performance requirements
- **Memory Usage**: No memory leaks

### 12.2 User Engagement Metrics (Post-Launch)
- **Daily Active Users (DAU)**
- **Average Session Length**: Target 15-30 minutes
- **Retention Rate**: D1, D7, D30
- **Games Completed**: % of started games that finish
- **Feature Usage**: Which rules are most popular

### 12.3 Quality Metrics
- **App Store Rating**: Target 4.5+ stars
- **User Reviews**: Positive sentiment
- **Bug Reports**: < 5 per 1000 users
- **Support Requests**: Minimal confusion about rules

---

## 13. Risks & Mitigation

### 13.1 Technical Risks

| Risk | Impact | Likelihood | Mitigation |
|------|--------|------------|------------|
| Animation performance issues | High | Medium | Profile early, use Metal for heavy effects, optimize Core Animation layers |
| TCAKit learning curve | Medium | High | Study examples, start simple, refactor as needed |
| AI too difficult/easy | High | Medium | Extensive playtesting, adjustable difficulty parameters |
| Complex rule interactions | High | Medium | Comprehensive unit tests, rule validation layer |
| State management complexity | High | Medium | Strict TCAKit patterns, small reducers, clear actions |

### 13.2 Product Risks

| Risk | Impact | Likelihood | Mitigation |
|------|--------|------------|------------|
| Rules don't match regional variations | High | Medium | Research multiple sources, make rules configurable |
| UI too complex for newcomers | High | Medium | Tutorial mode, progressive disclosure, user testing |
| Game too slow (animations) | Medium | Low | Skip animation buttons, fast mode option |
| Lack of replayability | High | Medium | Strong AI, rule variations, statistics tracking |

### 13.3 Schedule Risks

| Risk | Impact | Likelihood | Mitigation |
|------|--------|------------|------------|
| Animation takes longer than expected | Medium | High | Start animations early, prioritize core gameplay |
| AI development complexity | High | Medium | Start with simple AI, iterate based on playtesting |
| Rule edge cases | Medium | High | Reference implementation from physical game |
| Testing takes too long | Medium | Medium | Automated tests, focus on critical paths |

---

## 14. Open Questions

1. **Card Design**: Use traditional playing cards or custom illustrated cards?
2. **Monetization**: Free app, one-time purchase, or freemium? (Not in scope for MVP)
3. **Analytics**: Which analytics platform? (Consider privacy)
4. **Cloud Save**: iCloud sync for game state? (Post-MVP)
5. **Social Features**: Share results, challenges? (Post-MVP)
6. **Name Localization**: Keep "TwentyNine" or use "২৯" in Bengali markets?

---

## 15. References

### 15.1 Technical Documentation
- [TCAKit Documentation](https://github.com/ronstorm/tca-kit)
- [Core Animation Programming Guide](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CoreAnimation_guide/)
- [Metal Programming Guide](https://developer.apple.com/metal/)
- [Core Graphics Documentation](https://developer.apple.com/documentation/coregraphics)

### 15.2 Game Rules
- [game-rule.md](game-rule.md) - Complete gameplay rules

### 15.3 Design Inspiration
- Traditional playing cards
- Solitaire (iOS)
- Card game apps with polished animations

---

## 16. Appendix

### 16.1 Glossary

| Term | Definition |
|------|------------|
| **Trick** | One round where each player plays one card |
| **Trump** | The suit selected by the bidder that beats all other suits |
| **Marriage/Pair** | King and Queen of trump suit held by one player |
| **Bid** | Promise to collect a certain number of points |
| **Follow Suit** | Must play a card of the same suit as the lead card |
| **Counter-clockwise** | Direction of play (right to left from dealer's perspective) |

### 16.2 Abbreviations

- **TCA**: The Composable Architecture
- **AI**: Artificial Intelligence
- **UI**: User Interface
- **UX**: User Experience
- **MVP**: Minimum Viable Product
- **PRD**: Product Requirements Document
- **FPS**: Frames Per Second
- **GPU**: Graphics Processing Unit

---

**Document End**

*This PRD is a living document and will be updated as development progresses and requirements evolve.*

