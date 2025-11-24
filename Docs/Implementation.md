# Implementation Plan for TwentyNine Card Game

**Version:** 1.0  
**Created:** November 23, 2025  
**Status:** Planning Phase  
**Reference:** [PRD.md](../PRD.md)

---

## Table of Contents
1. [Feature Analysis](#feature-analysis)
2. [Recommended Tech Stack](#recommended-tech-stack)
3. [Implementation Stages](#implementation-stages)
4. [Resource Links](#resource-links)
5. [Development Guidelines](#development-guidelines)

---

## Feature Analysis

### Identified Features

#### Core Game Mechanics
1. **Card System** - 32-card deck with custom ranking (J > 9 > A > 10 > K > Q > 8 > 7)
2. **Dealing System** - Counter-clockwise distribution, two-phase dealing (4 cards, then 4 more)
3. **Bidding System** - Range 16-28, pass mechanism, bid validation
4. **Trump Selection** - Secret trump selection via 2-5 indicator cards
5. **Trick-Taking Logic** - Follow suit rules, trump mechanics, winner determination
6. **Scoring System** - Point calculation, marriage adjustments, red/black 6 counter
7. **Game Phases** - Setup → Deal → Bid → Trump → Deal → Play → Score → Victory

#### UI/UX Features
8. **Main Menu** - Navigation, game start, continue, settings, tutorial, about
9. **Game Table View** - 4-player layout (N/S/E/W), card display, status indicators
10. **Bidding Interface** - Bid buttons 16-28, pass button, bid history
11. **Card Animations** - Dealing, flipping, throwing, trick collection
12. **Visual Feedback** - Card selection, valid moves highlighting, turn indicators
13. **Score Display** - Real-time score tracking, victory/defeat animations

#### Configuration & Rules
14. **Rule Configuration System** - 11 toggleable rules with presets
15. **Rule Presets** - Standard, Bangladesh Classic, Advanced, Beginner, Custom
16. **Marriage Rule** - K+Q of trump detection and bid adjustment
17. **Double/Re-Double** - Bid challenge mechanics
18. **Single Hand Mode** - 1 vs 3 gameplay variant
19. **7th Card Trump** - Alternative trump reveal mechanism
20. **Special Rules** - Joker Trump, Reverse Trump, All Tricks Bonus, Half-Point Penalty

#### AI System
21. **Easy AI** - Basic decision making, point-card focused
22. **Medium AI** - Suit distribution awareness, basic partner support
23. **Hard AI** - Full card counting, strategic play, partner coordination
24. **AI Bidding Logic** - Difficulty-based probability calculations
25. **AI Trump Selection** - Optimal suit selection algorithms
26. **AI Play Strategy** - Context-aware card playing decisions

#### Animation & Graphics
27. **Core Animation Layer** - Card dealing, flipping, sliding animations
28. **Metal Particle Systems** - Confetti, sparkles, celebration effects
29. **Core Graphics** - Custom card rendering, shadows, gradients
30. **SwiftUI Animations** - Button states, menu transitions, badges

#### Game Modes
31. **Single Player Mode** - Human + 3 AI opponents
32. **Pass & Play Mode** - 4 human players, turn-based
33. **Tutorial Mode** - Interactive learning system
34. **Practice Mode** - Scenario-based practice (Post-MVP)

#### State Management
35. **TCAKit Integration** - Store, reducers, effects, dependencies
36. **Game State Model** - Comprehensive state structure
37. **Action System** - User actions, AI actions, system actions
38. **Effect Handling** - Async operations, animation coordination

#### Data & Persistence
39. **Game State Persistence** - Save/restore in-progress games
40. **Settings Storage** - Rule preferences, player names
41. **Statistics Tracking** - Win/loss records, games played (Post-MVP)

#### Accessibility & Polish
42. **VoiceOver Support** - Full screen reader accessibility
43. **Dynamic Type** - Scalable text
44. **Reduce Motion** - Animation alternatives
45. **Color Blind Support** - High contrast, symbol emphasis
46. **Haptic Feedback** - Tactile responses
47. **Sound Effects** - Audio feedback (Post-MVP)
48. **Dark Mode** - Theme support

#### Testing & Quality
49. **Unit Tests** - Game logic, rules, calculations
50. **Integration Tests** - Full game flows, state management
51. **UI Tests** - Navigation, interactions
52. **TestStore Testing** - TCAKit reducer testing

### Feature Categorization

#### Must-Have Features (MVP Core)
**Priority:** Highest - Required for playable game

- ✅ Card System (Feature #1)
- ✅ Dealing System (Feature #2)
- ✅ Bidding System (Feature #3)
- ✅ Trump Selection (Feature #4)
- ✅ Trick-Taking Logic (Feature #5)
- ✅ Scoring System (Feature #6)
- ✅ Game Phases (Feature #7)
- ✅ Main Menu (Feature #8)
- ✅ Game Table View (Feature #9)
- ✅ Bidding Interface (Feature #10)
- ✅ Basic Card Animations (Feature #11 - subset)
- ✅ Visual Feedback (Feature #12)
- ✅ Score Display (Feature #13)
- ✅ Marriage Rule (Feature #16)
- ✅ Easy AI (Feature #21)
- ✅ Single Player Mode (Feature #31)
- ✅ TCAKit Integration (Feature #35)
- ✅ Game State Model (Feature #36)
- ✅ Action System (Feature #37)
- ✅ Effect Handling (Feature #38)

#### Should-Have Features (MVP Polish)
**Priority:** High - Complete the MVP experience

- 🔶 Rule Configuration System (Feature #14)
- 🔶 Rule Presets (Feature #15)
- 🔶 Double/Re-Double (Feature #17)
- 🔶 Single Hand Mode (Feature #18)
- 🔶 7th Card Trump (Feature #19)
- 🔶 Special Rules (Feature #20)
- 🔶 Medium AI (Feature #22)
- 🔶 Hard AI (Feature #23)
- 🔶 AI Bidding Logic (Feature #24)
- 🔶 AI Trump Selection (Feature #25)
- 🔶 AI Play Strategy (Feature #26)
- 🔶 Core Animation Layer (Feature #27)
- 🔶 Metal Particle Systems (Feature #28)
- 🔶 Core Graphics (Feature #29)
- 🔶 SwiftUI Animations (Feature #30)
- 🔶 Pass & Play Mode (Feature #32)
- 🔶 Tutorial Mode (Feature #33)
- 🔶 Game State Persistence (Feature #39)
- 🔶 Settings Storage (Feature #40)
- 🔶 Dark Mode (Feature #48)
- 🔶 Unit Tests (Feature #49)
- 🔶 Integration Tests (Feature #50)

#### Nice-to-Have Features (Post-MVP)
**Priority:** Medium/Low - Future enhancements

- 🔷 Practice Mode (Feature #34)
- 🔷 Statistics Tracking (Feature #41)
- 🔷 VoiceOver Support (Feature #42)
- 🔷 Dynamic Type (Feature #43)
- 🔷 Reduce Motion (Feature #44)
- 🔷 Color Blind Support (Feature #45)
- 🔷 Haptic Feedback (Feature #46)
- 🔷 Sound Effects (Feature #47)
- 🔷 UI Tests (Feature #51)
- 🔷 TestStore Testing (Feature #52)
- 🔷 Online Multiplayer
- 🔷 Leaderboards
- 🔷 Achievements
- 🔷 Localization
- 🔷 Custom Card Designs
- 🔷 watchOS Companion

---

## Recommended Tech Stack

### State Management
**Framework:** [TCAKit](https://github.com/ronstorm/tca-kit) v1.0.0+

**Justification:**
- Lightweight TCA implementation designed for SwiftUI
- Built-in async/await support for modern Swift concurrency
- Excellent dependency injection system
- Strong testing utilities with TestStore
- No external dependencies
- Perfect fit for game state management with clear action/reducer patterns

**Documentation:**
- [TCAKit GitHub](https://github.com/ronstorm/tca-kit)
- [TCAKit Complete Documentation](https://github.com/ronstorm/tca-kit/tree/master/Docs)
- [TCAKit Examples](https://github.com/ronstorm/tca-kit/tree/master/Examples)

### UI Framework
**Framework:** SwiftUI

**Justification:**
- Native iOS/macOS/tvOS/visionOS support
- Declarative UI perfect for game state rendering
- Built-in animation system for simple transitions
- Integrates seamlessly with Core Animation and Metal
- Cross-platform by design

**Documentation:**
- [SwiftUI Official Documentation](https://developer.apple.com/documentation/swiftui/)
- [SwiftUI Tutorials](https://developer.apple.com/tutorials/swiftui)
- [Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/)

### Animation Frameworks

#### Core Animation
**Purpose:** Heavy card animations (dealing, flipping, throwing)

**Justification:**
- Layer-based animations for complex card movements
- CATransform3D for realistic 3D card flips
- Hardware-accelerated performance
- Precise animation control and timing

**Documentation:**
- [Core Animation Programming Guide](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CoreAnimation_guide/)
- [Core Animation Documentation](https://developer.apple.com/documentation/quartzcore)
- [Advanced Animation Techniques](https://developer.apple.com/videos/play/wwdc2018/803/)

#### Metal
**Purpose:** GPU-accelerated particle systems

**Justification:**
- High-performance particle effects (confetti, sparkles)
- GPU-based rendering for complex effects
- Essential for victory celebrations and special events
- Maintains 60fps even with 500+ particles

**Documentation:**
- [Metal Programming Guide](https://developer.apple.com/metal/)
- [Metal Documentation](https://developer.apple.com/documentation/metal)
- [Metal Best Practices](https://developer.apple.com/videos/play/wwdc2022/10103/)

#### Core Graphics
**Purpose:** Custom card rendering

**Justification:**
- Vector-based card drawing
- Custom shadows and gradients
- High-quality rendering at any scale
- Perfect for card suit symbols and decorations

**Documentation:**
- [Core Graphics Documentation](https://developer.apple.com/documentation/coregraphics)
- [Quartz 2D Programming Guide](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Conceptual/drawingwithquartz2d/)

### Language & Platforms
**Language:** Swift 6.2  
**Minimum Versions:**
- iOS 17.0+
- iPadOS 17.0+
- macOS 14.0+ (Sonoma)
- tvOS 17.0+
- visionOS 1.0+

**Justification:**
- Swift 6 data race safety
- Modern concurrency features (async/await, actors)
- Latest SwiftUI capabilities
- Cross-platform support

**Documentation:**
- [Swift Documentation](https://swift.org/documentation/)
- [Swift Evolution](https://github.com/apple/swift-evolution)
- [What's New in Swift 6](https://www.swift.org/blog/announcing-swift-6/)

### Development Tools
**IDE:** Xcode 15.0+  
**Package Manager:** Swift Package Manager (SPM)  
**Version Control:** Git  
**Testing:** Swift Testing + TCAKit TestStore

**Documentation:**
- [Xcode Documentation](https://developer.apple.com/documentation/xcode)
- [Swift Package Manager](https://swift.org/package-manager/)
- [Swift Testing Documentation](https://developer.apple.com/documentation/testing)

### Additional Dependencies
**TCAKit** - State management (SPM)

**No other external dependencies** - Keeping the app lightweight and maintainable

---

## Implementation Stages

### Stage 1: Project Foundation & Core Models
**Duration:** 1-2 weeks  
**Dependencies:** None  
**Goal:** Establish project structure and fundamental data models

#### 1.1 Project Setup
- [x] Create Xcode project with multi-platform support
- [x] Configure Swift Package Manager
- [x] Add TCAKit dependency
- [x] Set up project folder structure (see [project_structure.md](project_structure.md))
- [x] Configure build settings and deployment targets
- [x] Set up .gitignore and version control
- [x] Create initial documentation structure

**Note:** Test targets (TwentyNineTests, TwentyNineUITests) need to be added via Xcode UI:
1. File → New → Target → Unit Testing Bundle (for TwentyNineTests)
2. File → New → Target → UI Testing Bundle (for TwentyNineUITests)
3. Test folder structure already created in project root

#### 1.2 Core Models
- [x] Implement `Card` model (rank, suit, point values)
- [x] Implement `Rank` enum with custom ordering (J=highest)
- [x] Implement `Suit` enum with symbols
- [x] Implement `Player` model (id, name, type, position, team)
- [x] Implement `PlayerType` enum (human, AI with difficulty)
- [x] Implement `Team` enum (northSouth, eastWest)
- [x] Implement `Position` enum (north, east, south, west)
- [x] Implement `Bid` model
- [x] Implement `Trick` model
- [x] Implement `TeamScore` model

#### 1.3 Game State Foundation
- [x] Create `GamePhase` enum (setup, dealing, bidding, etc.)
- [x] Create `RuleConfiguration` struct with all toggleable rules
- [x] Create comprehensive `GameState` struct
- [x] Implement `GameAction` enum with all possible actions
- [x] Set up basic TCAKit Store structure
- [x] Create placeholder reducer function

#### 1.4 Core Business Logic
- [x] Implement `CardShuffler` service (Fisher-Yates algorithm)
- [x] Implement `CardDealer` service (counter-clockwise distribution)
- [x] Implement `RuleValidator` service (move validation, bid validation)
- [x] Implement `ScoreCalculator` service (point counting, marriage adjustments)
- [x] Create unit tests for all business logic

**Deliverable:** Working data models and game logic foundation with tests

---

### Stage 2: Basic UI & Game Flow
**Duration:** 2-3 weeks  
**Dependencies:** Stage 1 completion  
**Goal:** Playable game with basic UI (no advanced animations yet)

#### 2.1 Main Menu Implementation
- [ ] Create `MainMenuView` with SwiftUI
- [ ] Implement navigation to game setup
- [ ] Add "Start New Game" button
- [ ] Add "Continue" button (disabled initially)
- [ ] Add "Tutorial" button (placeholder)
- [ ] Add "Settings" button (placeholder)
- [ ] Add "About" view with credits
- [ ] Apply basic styling and layout

#### 2.2 Game Table View
- [ ] Create `GameTableView` as main game screen
- [ ] Implement 4-player card layout (N/S/E/W positions)
- [ ] Create `CardView` component for rendering individual cards
- [ ] Implement player hand display (fan layout for human player)
- [ ] Create opponent card back display
- [ ] Add center area for played cards
- [ ] Implement trump indicator display
- [ ] Add trick counter and score display
- [ ] Create turn indicator highlighting

#### 2.3 Bidding System UI
- [ ] Create `BiddingPanelView` overlay
- [ ] Implement bid button grid (16-28)
- [ ] Add "Pass" button
- [ ] Display current highest bid
- [ ] Show bid history log
- [ ] Implement bid validation feedback
- [ ] Add player turn indicator during bidding
- [ ] Handle bid completion and transition

#### 2.4 Trump Selection UI
- [ ] Create `TrumpSelectionView` for bidder
- [ ] Display 4 trump indicator cards (2♠, 3♥, 4♦, 5♣)
- [ ] Implement trump card selection
- [ ] Show hidden trump indicator on table
- [ ] Create trump reveal mechanism
- [ ] Handle trump selection confirmation

#### 2.5 Game Flow Integration
- [ ] Implement game phase state machine in reducer
- [ ] Connect dealing phase to UI
- [ ] Connect bidding phase to UI
- [ ] Connect trump selection to UI
- [ ] Connect trick-taking phase to UI
- [ ] Implement phase transitions
- [ ] Add basic transition animations (SwiftUI)

#### 2.6 Trick-Taking Implementation
- [ ] Implement card selection for human player
- [ ] Add card play validation (follow suit rules)
- [ ] Show valid cards highlighting
- [ ] Implement card playing action
- [ ] Determine trick winner logic
- [ ] Implement trick collection to winner
- [ ] Track tricks won per team
- [ ] Handle 8 tricks completion

**Deliverable:** Fully playable game loop with basic UI (no AI yet)

---

### Stage 3: AI Implementation
**Duration:** 2-3 weeks  
**Dependencies:** Stage 2 completion  
**Goal:** Intelligent AI opponents at multiple difficulty levels

#### 3.1 AI Foundation
- [ ] Create `AIEngine` service protocol
- [ ] Implement `AIDecision` model (action + reasoning)
- [ ] Create `AIContext` for decision-making data
- [ ] Set up AI delay system (realistic thinking time)
- [ ] Implement AI turn handling in reducer

#### 3.2 Easy AI Implementation
- [ ] Implement easy AI bidding strategy (point-card counting)
- [ ] Implement easy AI trump selection (most points)
- [ ] Implement easy AI card playing (highest if winning, lowest if losing)
- [ ] Add randomness for unpredictability
- [ ] Test easy AI playability
- [ ] Tune difficulty parameters

#### 3.3 Medium AI Implementation
- [ ] Implement medium AI bidding (suit distribution awareness)
- [ ] Implement medium AI trump selection (points + suit length)
- [ ] Implement medium AI card playing:
  - [ ] Track high cards played
  - [ ] Basic partner support (don't override wins)
  - [ ] Try to win tricks with points
- [ ] Implement trump timing strategy
- [ ] Test medium AI challenge level
- [ ] Balance difficulty

#### 3.4 Hard AI Implementation
- [ ] Implement card counting system (track all 32 cards)
- [ ] Implement hard AI bidding (probability calculations, partner bids)
- [ ] Implement hard AI trump selection (optimal algorithm)
- [ ] Implement hard AI card playing:
  - [ ] Full card inference from plays
  - [ ] Strategic trump timing
  - [ ] Partner coordination logic
  - [ ] Endgame optimal play
- [ ] Implement marriage detection and declaration
- [ ] Test hard AI competitiveness
- [ ] Fine-tune for fair challenge

#### 3.5 AI Testing & Tuning
- [ ] Run AI vs AI simulation games (1000+ games)
- [ ] Measure win rates by difficulty
- [ ] Analyze AI decision quality
- [ ] Fix AI logic bugs
- [ ] Balance difficulty curves
- [ ] Ensure AI follows all rules correctly

**Deliverable:** 3 AI difficulty levels providing beginner to expert challenge

---

### Stage 4: Advanced Animations
**Duration:** 2-3 weeks  
**Dependencies:** Stage 3 completion  
**Goal:** Production-quality animations using Core Animation and Metal

#### 4.1 Core Animation Setup
- [ ] Create `AnimationController` service
- [ ] Set up CALayer-based card views
- [ ] Implement animation queue system
- [ ] Create reusable animation helpers
- [ ] Set up animation completion callbacks

#### 4.2 Card Dealing Animations
- [ ] Implement card shuffle animation (deck mixing)
- [ ] Create card dealing animation (counter-clockwise)
- [ ] Add stagger delay between cards
- [ ] Implement smooth path animations
- [ ] Add card flip animation when dealing to player
- [ ] Optimize for 60fps performance

#### 4.3 Card Movement Animations
- [ ] Implement card selection lift animation
- [ ] Create card throw animation (from hand to table)
- [ ] Add card flip animation (face up/down)
- [ ] Implement trick collection animation (cards to winner)
- [ ] Create smooth card sliding
- [ ] Add subtle rotation during movement

#### 4.4 3D Card Flip Animations
- [ ] Implement CATransform3D-based flips
- [ ] Create realistic perspective transformation
- [ ] Add lighting effects during flip
- [ ] Implement trump card reveal animation
- [ ] Optimize transform calculations
- [ ] Test on various devices

#### 4.5 Metal Particle Systems
- [ ] Set up Metal rendering layer
- [ ] Create particle system architecture
- [ ] Implement confetti effect (victory)
- [ ] Implement sparkle effect (marriage declaration)
- [ ] Create card trail particles (fast dealing)
- [ ] Add glow aura for selected cards
- [ ] Implement explosion effect (all tricks bonus)
- [ ] Optimize particle count for performance
- [ ] Test GPU usage and battery impact

#### 4.6 Animation Polish
- [ ] Add easing curves to all animations
- [ ] Implement spring physics for card interactions
- [ ] Create anticipation and follow-through
- [ ] Add subtle shadow animations
- [ ] Implement squash and stretch for emphasis
- [ ] Profile animation performance
- [ ] Optimize for battery efficiency

**Deliverable:** Visually stunning game with smooth, professional animations

---

### Stage 5: Rule Configuration System
**Duration:** 1-2 weeks  
**Dependencies:** Stage 3 completion  
**Goal:** Flexible rule system supporting all game variations

#### 5.1 Rule Configuration UI
- [ ] Create `RuleConfigurationView`
- [ ] Implement toggle switches for each rule
- [ ] Add rule description and explanation
- [ ] Create rule preset buttons
- [ ] Implement custom rule saving
- [ ] Add rule preview/summary
- [ ] Integrate with game setup flow

#### 5.2 Marriage Rule Implementation
- [ ] Detect K+Q of trump in player hand
- [ ] Implement marriage declaration UI
- [ ] Apply ±4 bid adjustment
- [ ] Add marriage celebration animation
- [ ] Show marriage status in score display
- [ ] Test marriage logic thoroughly

#### 5.3 Double/Re-Double Implementation
- [ ] Add Double button for opponents during bidding
- [ ] Implement Re-Double option for bidder
- [ ] Apply ±2 and ±4 score multipliers
- [ ] Update score calculation logic
- [ ] Add UI indicators for double/re-double status
- [ ] Test multiplier edge cases

#### 5.4 Single Hand Mode
- [ ] Implement 1 vs 3 game variant
- [ ] Adjust scoring for single player
- [ ] Update AI coordination (3 AI collaborate)
- [ ] Add single hand challenge UI
- [ ] Test balance and fairness

#### 5.5 7th Card Trump Implementation
- [ ] Implement trump reveal via 7th card
- [ ] Add UI for 7th card selection
- [ ] Validate 7th card availability
- [ ] Handle trump reveal timing
- [ ] Test interaction with other rules

#### 5.6 Special Rules
- [ ] Implement Joker Trump mode (highest card wins)
- [ ] Implement Reverse Trump (7 highest, J lowest)
- [ ] Implement All Tricks Bonus (+1 point)
- [ ] Implement Half-Point Penalty
- [ ] Add Auto-show Trump option
- [ ] Test all rule combinations

#### 5.7 Rule Presets
- [ ] Create "Standard" preset (Marriage only)
- [ ] Create "Bangladesh Classic" preset (Marriage + Double + Re-Double)
- [ ] Create "Advanced" preset (all rules)
- [ ] Create "Beginner" preset (Marriage + Auto-show)
- [ ] Allow custom preset saving/loading
- [ ] Add preset descriptions

**Deliverable:** Comprehensive rule system covering all regional variations

---

### Stage 6: Tutorial & Onboarding
**Duration:** 1-2 weeks  
**Dependencies:** Stage 4 completion  
**Goal:** Interactive tutorial teaching new players

#### 6.1 Tutorial Framework
- [ ] Create `TutorialView` overlay system
- [ ] Implement tutorial step navigation
- [ ] Add highlighting system for UI elements
- [ ] Create tutorial dialogue/instruction boxes
- [ ] Implement skip and restart options
- [ ] Add tutorial progress tracking

#### 6.2 Tutorial Content
- [ ] Create "Card Rankings" lesson
- [ ] Create "Bidding Basics" interactive practice
- [ ] Create "Trump Selection" lesson
- [ ] Create "Following Suit" practice
- [ ] Create "Trump Mechanics" lesson
- [ ] Create "Scoring" explanation
- [ ] Create complete practice game with hints

#### 6.3 Guided Gameplay
- [ ] Implement move suggestions during tutorial
- [ ] Add "Why?" explanations for invalid moves
- [ ] Show legal move indicators
- [ ] Implement step-by-step game walkthrough
- [ ] Add contextual tips and strategies

#### 6.4 Tutorial Polish
- [ ] Add tutorial voiceover text
- [ ] Create engaging tutorial animations
- [ ] Add completion celebration
- [ ] Implement tutorial skip for experienced players
- [ ] Test tutorial clarity with new users

**Deliverable:** Comprehensive, engaging tutorial for beginners

---

### Stage 7: Pass & Play Multiplayer
**Duration:** 1 week  
**Dependencies:** Stage 2 completion  
**Goal:** Local 4-player pass-and-play mode

#### 7.1 Pass & Play Setup
- [ ] Create player configuration screen
- [ ] Allow 4 human player names
- [ ] Implement turn-based gameplay
- [ ] Add "Pass Device" screen between turns
- [ ] Hide other players' cards during turns

#### 7.2 Privacy & Security
- [ ] Implement card hiding mechanism
- [ ] Add blur/fade when passing device
- [ ] Show "Tap to continue" for next player
- [ ] Ensure no hand information leaks
- [ ] Add confirmation before revealing hand

#### 7.3 Pass & Play UX
- [ ] Add turn timer (optional)
- [ ] Show clear player indicators
- [ ] Implement rotation for comfortable viewing
- [ ] Add "Undo Pass" option (before looking)
- [ ] Test multiplayer flow with 4 people

**Deliverable:** Smooth local multiplayer experience

---

### Stage 8: Persistence & Settings
**Duration:** 1 week  
**Dependencies:** Stage 5 completion  
**Goal:** Save game state and user preferences

#### 8.1 Game State Persistence
- [ ] Implement Codable for GameState
- [ ] Create `PersistenceService` using FileManager
- [ ] Add auto-save on game interruption
- [ ] Implement "Continue Game" functionality
- [ ] Handle corrupted save file recovery
- [ ] Test save/restore reliability

#### 8.2 Settings Storage
- [ ] Create `SettingsService` using UserDefaults
- [ ] Save rule configurations
- [ ] Save player name preferences
- [ ] Save AI difficulty preferences
- [ ] Save animation preferences (reduce motion)
- [ ] Implement settings sync across launches

#### 8.3 Settings UI
- [ ] Create comprehensive settings screen
- [ ] Add rule configuration section
- [ ] Add animation preferences
- [ ] Add sound preferences (for future)
- [ ] Add about/credits section
- [ ] Add version information
- [ ] Implement settings reset option

**Deliverable:** Persistent game state and customizable settings

---

### Stage 9: Polish & Optimization
**Duration:** 1-2 weeks  
**Dependencies:** Stage 8 completion  
**Goal:** Production-ready quality and performance

#### 9.1 Performance Optimization
- [ ] Profile app with Instruments
- [ ] Optimize animation performance (60fps target)
- [ ] Reduce memory usage (< 150MB target)
- [ ] Optimize CPU usage
- [ ] Reduce battery drain (< 5% per 30 min)
- [ ] Profile GPU usage (Metal)
- [ ] Optimize app launch time (< 2s target)

#### 9.2 UI Polish
- [ ] Refine all spacing and alignment
- [ ] Polish color scheme and gradients
- [ ] Add subtle shadows and depth
- [ ] Implement smooth transitions everywhere
- [ ] Polish card design and rendering
- [ ] Add visual hierarchy
- [ ] Ensure consistency across screens

#### 9.3 Dark Mode Support
- [ ] Create dark color palette
- [ ] Implement adaptive colors
- [ ] Test all screens in dark mode
- [ ] Adjust animations for dark backgrounds
- [ ] Polish dark mode aesthetics

#### 9.4 Edge Case Handling
- [ ] Handle app backgrounding gracefully
- [ ] Handle phone call interruptions
- [ ] Handle memory warnings
- [ ] Implement error states UI
- [ ] Add network failure handling (for future online mode)
- [ ] Test app with low power mode

#### 9.5 Accessibility (Basic)
- [ ] Add accessibility labels to all interactive elements
- [ ] Test with VoiceOver (basic support)
- [ ] Support Dynamic Type (scale text)
- [ ] Implement Reduce Motion alternatives
- [ ] Add high contrast mode support
- [ ] Test with accessibility features enabled

**Deliverable:** Polished, performant, accessible app

---

### Stage 10: Testing & Quality Assurance
**Duration:** 2 weeks  
**Dependencies:** Stage 9 completion  
**Goal:** Comprehensive testing and bug fixes

#### 10.1 Unit Testing
- [ ] Write tests for all game rule logic
- [ ] Write tests for score calculation
- [ ] Write tests for AI decision making
- [ ] Write tests for card shuffling
- [ ] Write tests for bid validation
- [ ] Write tests for move validation
- [ ] Achieve 80%+ code coverage on business logic

#### 10.2 TCAKit Reducer Testing
- [ ] Write TestStore tests for all game actions
- [ ] Test state transitions
- [ ] Test effect handling
- [ ] Test dependency injection
- [ ] Verify action ordering
- [ ] Test error scenarios

#### 10.3 Integration Testing
- [ ] Test complete game flows (start to victory)
- [ ] Test all rule configurations
- [ ] Test AI vs AI games (automated)
- [ ] Test save/restore game state
- [ ] Test settings persistence
- [ ] Run regression tests

#### 10.4 Manual Testing
- [ ] Test on iPhone (various sizes: SE to Pro Max)
- [ ] Test on iPad (various sizes)
- [ ] Test on macOS (if applicable)
- [ ] Test with different iOS versions (17.0+)
- [ ] Test orientation changes (iPad)
- [ ] Test interruptions (calls, backgrounding)
- [ ] Test with accessibility features
- [ ] Test performance on older devices

#### 10.5 Bug Fixing
- [ ] Create bug tracking system (GitHub Issues)
- [ ] Prioritize bugs (critical, major, minor)
- [ ] Fix all critical bugs
- [ ] Fix all major bugs
- [ ] Address minor bugs
- [ ] Verify bug fixes
- [ ] Update documentation

#### 10.6 Beta Testing
- [ ] Recruit beta testers (10-20 people)
- [ ] Set up TestFlight distribution
- [ ] Collect feedback
- [ ] Analyze crash reports
- [ ] Implement critical feedback
- [ ] Run second beta round if needed

**Deliverable:** Stable, tested app ready for App Store submission

---

### Stage 11: Release Preparation
**Duration:** 1 week  
**Dependencies:** Stage 10 completion  
**Goal:** App Store submission and launch

#### 11.1 App Store Assets
- [ ] Create app icon (all sizes)
- [ ] Take screenshots (iPhone, iPad)
- [ ] Create app preview video
- [ ] Write app description
- [ ] Prepare marketing copy
- [ ] Create promotional artwork

#### 11.2 Legal & Compliance
- [ ] Write privacy policy
- [ ] Create terms of service (if needed)
- [ ] Ensure App Store guidelines compliance
- [ ] Add required disclosures
- [ ] Verify copyright information

#### 11.3 Build & Submission
- [ ] Create production build
- [ ] Archive and validate build
- [ ] Submit to App Store Connect
- [ ] Fill out App Store metadata
- [ ] Submit for review
- [ ] Respond to any review feedback

#### 11.4 Launch Planning
- [ ] Plan launch date
- [ ] Prepare announcement materials
- [ ] Set up analytics (optional)
- [ ] Create support email/documentation
- [ ] Plan post-launch monitoring

**Deliverable:** App live on App Store

---

### Stage 12: Post-Launch (Future Enhancements)
**Duration:** Ongoing  
**Dependencies:** Stage 11 completion  
**Goal:** Continuous improvement and new features

#### 12.1 Sound & Audio
- [ ] Create/source sound effects library
- [ ] Implement audio playback system
- [ ] Add card shuffle sound
- [ ] Add card flip sound
- [ ] Add card slide sound
- [ ] Add bid selection click
- [ ] Add trump reveal sound
- [ ] Add victory fanfare
- [ ] Add background music (optional)
- [ ] Implement audio settings

#### 12.2 Haptics Enhancement
- [ ] Add haptic feedback for card plays
- [ ] Add haptics for bid placement
- [ ] Add haptics for trump reveal
- [ ] Add haptics for marriage declaration
- [ ] Add haptics for victory/defeat
- [ ] Implement haptic intensity settings

#### 12.3 Statistics & Achievements
- [ ] Create statistics tracking system
- [ ] Track total games played
- [ ] Track win/loss ratios
- [ ] Track highest bids
- [ ] Track marriage declarations
- [ ] Create achievement system
- [ ] Display statistics UI
- [ ] Add career progression

#### 12.4 Online Multiplayer
- [ ] Research backend solution (CloudKit/Game Center)
- [ ] Design multiplayer architecture
- [ ] Implement matchmaking
- [ ] Create lobby system
- [ ] Add friend invitations
- [ ] Implement real-time sync
- [ ] Add chat/emotes
- [ ] Create leaderboards
- [ ] Handle disconnections gracefully

#### 12.5 Additional Features
- [ ] Custom card designs (unlockable)
- [ ] Alternative table themes
- [ ] Localization (Bengali, Hindi, Urdu)
- [ ] watchOS companion app
- [ ] Widget support
- [ ] Daily challenges
- [ ] Tournament mode
- [ ] Replay system

**Deliverable:** Continuous feature updates and improvements

---

## Resource Links

### Official Documentation
- [TCAKit GitHub Repository](https://github.com/ronstorm/tca-kit)
- [TCAKit Complete Documentation](https://github.com/ronstorm/tca-kit/tree/master/Docs)
- [TCAKit Examples - TodoList](https://github.com/ronstorm/tca-kit/tree/master/Examples)
- [SwiftUI Documentation](https://developer.apple.com/documentation/swiftui/)
- [Core Animation Programming Guide](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CoreAnimation_guide/)
- [Metal Programming Guide](https://developer.apple.com/metal/)
- [Core Graphics Documentation](https://developer.apple.com/documentation/coregraphics)

### Learning Resources
- [SwiftUI Tutorials](https://developer.apple.com/tutorials/swiftui)
- [WWDC - Advanced Animation Techniques](https://developer.apple.com/videos/play/wwdc2018/803/)
- [WWDC - Metal Best Practices](https://developer.apple.com/videos/play/wwdc2022/10103/)
- [Swift Concurrency](https://docs.swift.org/swift-book/LanguageGuide/Concurrency.html)

### Design Resources
- [Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/)
- [SF Symbols](https://developer.apple.com/sf-symbols/)
- [Apple Design Resources](https://developer.apple.com/design/resources/)

### Testing Resources
- [Swift Testing Documentation](https://developer.apple.com/documentation/testing)
- [Testing in Xcode](https://developer.apple.com/videos/play/wwdc2019/413/)
- [Meet Swift Testing (WWDC23)](https://developer.apple.com/videos/play/wwdc2023/10179/)
- [TCAKit TestStore](https://github.com/ronstorm/tca-kit/blob/master/Docs/TestStore.md)

### Project Documentation
- [PRD - Product Requirements](../PRD.md)
- [Project Structure](project_structure.md)
- [UI/UX Documentation](UI_UX_doc.md)
- [Game Rules](../game-rule.md)

---

## Development Guidelines

### Code Quality Standards
1. **Follow Swift 6.2 best practices** (see workspace rules)
2. **Use TCA patterns strictly** - Keep reducers pure, effects for side effects
3. **Write tests first** for business logic (TDD approach)
4. **Comment complex algorithms** - Especially AI decision logic
5. **Use meaningful names** - Clarity over brevity
6. **Keep files focused** - Single responsibility per file
7. **Document public APIs** - Use doc comments for all public functions

### Performance Targets
- **60fps** during all animations
- **< 2 seconds** app launch time
- **< 1 second** AI response time (easy/medium)
- **< 2 seconds** AI response time (hard)
- **< 150MB** memory usage during gameplay
- **< 5%** battery drain per 30-minute session

### Testing Requirements
- **80%+ code coverage** for business logic
- **All reducers** tested with TestStore
- **Integration tests** for complete game flows
- **Manual testing** on multiple devices and iOS versions

### Git Workflow
1. Create feature branches (`feature/card-dealing`, `feature/ai-medium`)
2. Commit frequently with clear messages
3. Use conventional commits (`feat:`, `fix:`, `refactor:`)
4. Review changes before merging to main
5. Tag releases (`v1.0.0`, `v1.1.0`)

### Documentation Maintenance
- Update Implementation.md checkboxes as tasks complete
- Update project_structure.md when adding new folders/files
- Keep UI_UX_doc.md in sync with design changes
- Maintain PRD.md as requirements evolve

---

## Progress Tracking

### Current Stage: Stage 1 (Planning Complete)

**Completed Stages:**
- ✅ Planning & Documentation

**In Progress:**
- ⏳ Stage 1: Project Foundation & Core Models

**Upcoming:**
- ⬜ Stage 2: Basic UI & Game Flow
- ⬜ Stage 3: AI Implementation
- ⬜ Stage 4: Advanced Animations

**Target MVP Date:** TBD  
**Target Release Date:** TBD

---

**Last Updated:** November 23, 2025  
**Next Review:** After Stage 1 completion

