# TwentyNine Project Structure

**Version:** 1.0  
**Last Updated:** November 23, 2025  
**Reference:** [Implementation.md](Implementation.md)

---

## Table of Contents
1. [Project Overview](#project-overview)
2. [Root Directory Structure](#root-directory-structure)
3. [Source Code Organization](#source-code-organization)
4. [Module Descriptions](#module-descriptions)
5. [File Naming Conventions](#file-naming-conventions)
6. [Build & Configuration](#build--configuration)
7. [Testing Structure](#testing-structure)
8. [Asset Organization](#asset-organization)

---

## Project Overview

TwentyNine follows a **modular architecture** organized by feature and responsibility. The project uses:
- **TCAKit** for state management
- **SwiftUI** for UI
- **Core Animation, Metal, Core Graphics** for advanced graphics
- **Swift Package Manager** for dependencies

### Architecture Layers
```
┌─────────────────────────────────────────────┐
│              Application Layer               │
│         (App Entry, Root View)              │
└─────────────────┬───────────────────────────┘
                  │
┌─────────────────▼───────────────────────────┐
│           Feature Modules Layer             │
│  (Game, Menu, Settings, Tutorial)           │
└─────────────────┬───────────────────────────┘
                  │
┌─────────────────▼───────────────────────────┐
│        Shared Components Layer              │
│  (Reusable Views, UI Kit)                   │
└─────────────────┬───────────────────────────┘
                  │
┌─────────────────▼───────────────────────────┐
│         Business Logic Layer                │
│  (Game Rules, AI, Validation)               │
└─────────────────┬───────────────────────────┘
                  │
┌─────────────────▼───────────────────────────┐
│           Services Layer                    │
│  (Persistence, Animation, Sound)            │
└─────────────────┬───────────────────────────┘
                  │
┌─────────────────▼───────────────────────────┐
│          Core/Foundation Layer              │
│  (Models, Extensions, Utilities)            │
└─────────────────────────────────────────────┘
```

---

## Root Directory Structure

```
TwentyNine/
├── TwentyNine/                      # Main app target
│   ├── App/                         # Application entry & setup
│   ├── Features/                    # Feature modules
│   ├── Shared/                      # Shared components
│   ├── Core/                        # Core models & utilities
│   ├── Services/                    # Business services
│   ├── Resources/                   # Assets & resources
│   └── TwentyNineApp.swift          # App entry point
│
├── TwentyNineTests/                 # Unit & integration tests
│   ├── CoreTests/                   # Core model tests
│   ├── ServicesTests/               # Service tests
│   ├── FeaturesTests/               # Feature/reducer tests
│   └── TestHelpers/                 # Test utilities
│
├── TwentyNineUITests/               # UI automation tests
│   ├── GameFlowTests/               # End-to-end tests
│   └── AccessibilityTests/          # Accessibility tests
│
├── Docs/                            # Project documentation
│   ├── Implementation.md            # Implementation plan
│   ├── project_structure.md         # This file
│   └── UI_UX_doc.md                # UI/UX guidelines
│
├── Scripts/                         # Build & automation scripts
│   ├── generate-assets.sh           # Asset generation
│   └── run-tests.sh                # Test automation
│
├── .github/                         # GitHub configuration
│   └── workflows/                   # CI/CD workflows
│
├── TwentyNine.xcodeproj/            # Xcode project
├── Package.swift                    # SPM dependencies (if needed)
├── .gitignore                       # Git ignore rules
├── .swiftlint.yml                   # SwiftLint configuration
├── LICENSE                          # MIT License
├── README.md                        # Project overview
├── game-rule.md                     # Game rules reference
└── PRD.md                           # Product requirements
```

---

## Source Code Organization

### Detailed Source Structure

```
TwentyNine/
│
├── App/
│   ├── TwentyNineApp.swift              # @main App entry
│   ├── AppDelegate.swift                # App lifecycle (if needed)
│   ├── RootView.swift                   # Root navigation container
│   └── AppDependencies.swift            # Dependency setup
│
├── Features/
│   ├── Game/                            # Main game feature
│   │   ├── GameFeature.swift           # Game state, actions, reducer
│   │   ├── Views/
│   │   │   ├── GameTableView.swift     # Main game screen
│   │   │   ├── PlayerHandView.swift    # Player card hand
│   │   │   ├── PlayedCardsView.swift   # Center played cards
│   │   │   ├── BiddingPanelView.swift  # Bidding UI
│   │   │   ├── TrumpSelectionView.swift # Trump selection
│   │   │   └── ScoreBoardView.swift    # Score display
│   │   ├── Components/
│   │   │   ├── CardView.swift          # Individual card
│   │   │   ├── PlayerPositionView.swift # Player position indicator
│   │   │   └── TrickCounterView.swift  # Trick counter
│   │   └── GameFeatureTests.swift      # Feature tests
│   │
│   ├── MainMenu/                        # Main menu feature
│   │   ├── MainMenuFeature.swift       # Menu state & logic
│   │   ├── Views/
│   │   │   ├── MainMenuView.swift      # Main menu screen
│   │   │   ├── GameSetupView.swift     # New game setup
│   │   │   └── AboutView.swift         # About screen
│   │   └── MainMenuFeatureTests.swift
│   │
│   ├── Settings/                        # Settings feature
│   │   ├── SettingsFeature.swift       # Settings state & logic
│   │   ├── Views/
│   │   │   ├── SettingsView.swift      # Settings screen
│   │   │   ├── RuleConfigurationView.swift # Rule toggles
│   │   │   └── AnimationSettingsView.swift # Animation prefs
│   │   └── SettingsFeatureTests.swift
│   │
│   └── Tutorial/                        # Tutorial feature
│       ├── TutorialFeature.swift       # Tutorial state & logic
│       ├── Views/
│       │   ├── TutorialView.swift      # Tutorial container
│       │   ├── TutorialStepView.swift  # Individual step
│       │   └── TutorialHighlightView.swift # Element highlighting
│       └── TutorialFeatureTests.swift
│
├── Shared/                              # Shared UI components
│   ├── Components/
│   │   ├── Buttons/
│   │   │   ├── PrimaryButton.swift     # Primary action button
│   │   │   ├── SecondaryButton.swift   # Secondary button
│   │   │   └── IconButton.swift        # Icon-only button
│   │   ├── Cards/
│   │   │   ├── CardBackView.swift      # Card back design
│   │   │   └── CardDeckView.swift      # Deck of cards
│   │   ├── Overlays/
│   │   │   ├── AlertView.swift         # Custom alert
│   │   │   ├── LoadingView.swift       # Loading indicator
│   │   │   └── ToastView.swift         # Toast notifications
│   │   └── Animations/
│   │       ├── ShimmerView.swift       # Shimmer effect
│   │       └── PulseView.swift         # Pulse animation
│   │
│   ├── Modifiers/
│   │   ├── CardStyle.swift             # Card styling modifier
│   │   ├── GlowEffect.swift            # Glow effect modifier
│   │   └── ShakeEffect.swift           # Shake animation
│   │
│   └── Extensions/
│       ├── View+Extensions.swift       # View helpers
│       ├── Color+Theme.swift           # Color extensions
│       └── Animation+Custom.swift      # Custom animations
│
├── Core/                                # Core domain models
│   ├── Models/
│   │   ├── Card.swift                  # Card model
│   │   ├── Rank.swift                  # Card rank enum
│   │   ├── Suit.swift                  # Card suit enum
│   │   ├── Player.swift                # Player model
│   │   ├── Team.swift                  # Team enum
│   │   ├── Position.swift              # Player position
│   │   ├── Bid.swift                   # Bid model
│   │   ├── Trick.swift                 # Trick model
│   │   ├── GamePhase.swift             # Game phase enum
│   │   ├── RuleConfiguration.swift     # Rule config
│   │   └── TeamScore.swift             # Team score
│   │
│   ├── GameState/
│   │   ├── GameState.swift             # Main game state
│   │   ├── GameAction.swift            # All game actions
│   │   └── GameEnvironment.swift       # Dependencies
│   │
│   ├── Extensions/
│   │   ├── Array+Extensions.swift      # Array helpers
│   │   ├── Collection+Extensions.swift # Collection helpers
│   │   ├── Date+Extensions.swift       # Date formatting
│   │   └── String+Extensions.swift     # String helpers
│   │
│   └── Utilities/
│       ├── Constants.swift             # App constants
│       ├── Logger.swift                # Logging utility
│       └── DebugHelpers.swift          # Debug tools
│
├── Services/                            # Business services
│   ├── GameLogic/
│   │   ├── CardShuffler.swift          # Card shuffling
│   │   ├── CardDealer.swift            # Card distribution
│   │   ├── RuleValidator.swift         # Move validation
│   │   ├── ScoreCalculator.swift       # Score calculation
│   │   ├── TrickResolver.swift         # Trick winner logic
│   │   └── MarriageDetector.swift      # Marriage detection
│   │
│   ├── AI/
│   │   ├── AIEngine.swift              # AI protocol
│   │   ├── AIContext.swift             # AI decision context
│   │   ├── AIDecision.swift            # AI decision model
│   │   ├── EasyAI.swift                # Easy difficulty
│   │   ├── MediumAI.swift              # Medium difficulty
│   │   ├── HardAI.swift                # Hard difficulty
│   │   ├── BiddingStrategy.swift       # Bidding algorithms
│   │   ├── TrumpStrategy.swift         # Trump selection
│   │   └── PlayStrategy.swift          # Card playing
│   │
│   ├── Animation/
│   │   ├── AnimationController.swift   # Animation coordinator
│   │   ├── CoreAnimationService.swift  # Core Animation wrapper
│   │   ├── MetalParticleSystem.swift   # Metal particles
│   │   ├── CardAnimations.swift        # Card-specific animations
│   │   └── AnimationQueue.swift        # Animation sequencing
│   │
│   ├── Persistence/
│   │   ├── PersistenceService.swift    # Save/load protocol
│   │   ├── GameStatePersistence.swift  # Game state storage
│   │   ├── SettingsPersistence.swift   # Settings storage
│   │   └── FileManager+Extensions.swift # File helpers
│   │
│   ├── Audio/
│   │   ├── SoundManager.swift          # Sound playback
│   │   ├── HapticManager.swift         # Haptic feedback
│   │   └── AudioAssets.swift           # Audio asset enum
│   │
│   └── Analytics/
│       ├── AnalyticsService.swift      # Analytics protocol
│       └── EventLogger.swift           # Event tracking
│
└── Resources/                           # App resources
    ├── Assets.xcassets/                 # Asset catalog
    │   ├── AppIcon.appiconset/         # App icon
    │   ├── Colors/                     # Color assets
    │   │   ├── Primary.colorset/       # Primary brand color
    │   │   ├── Secondary.colorset/     # Secondary color
    │   │   ├── Background.colorset/    # Background color
    │   │   └── CardTable.colorset/     # Table green
    │   ├── Images/                     # Image assets
    │   │   ├── CardBacks/              # Card back designs
    │   │   └── Decorations/            # UI decorations
    │   └── Symbols/                    # Custom symbols
    │       └── TrumpIndicator.symbolset/
    │
    ├── Sounds/                          # Audio files (future)
    │   ├── card-flip.wav
    │   ├── card-shuffle.wav
    │   └── victory.wav
    │
    ├── Fonts/                           # Custom fonts (if any)
    │
    └── Localizations/                   # Localization (future)
        ├── en.lproj/
        │   └── Localizable.strings
        └── bn.lproj/                    # Bengali (future)
            └── Localizable.strings
```

---

## Module Descriptions

### App Module
**Purpose:** Application entry point and global setup

**Key Files:**
- `TwentyNineApp.swift` - SwiftUI App entry with `@main`
- `RootView.swift` - Root navigation and global state
- `AppDependencies.swift` - Dependency injection setup

**Responsibilities:**
- App lifecycle management
- Global dependency configuration
- Root navigation structure
- Initial state setup

---

### Features Module
**Purpose:** Self-contained feature modules following TCA patterns

#### Game Feature
**Most complex feature** - Contains all game logic and UI

**Structure:**
```
GameFeature.swift:
  - GameState struct
  - GameAction enum
  - gameReducer function
  - Game dependencies
```

**Views:**
- `GameTableView` - Main game screen with 4-player layout
- `BiddingPanelView` - Bidding interface overlay
- `TrumpSelectionView` - Trump selection for bidder
- `ScoreBoardView` - Score tracking display

**Components:**
- `CardView` - Individual card rendering with animations
- `PlayerPositionView` - Player name and status indicator
- `TrickCounterView` - Current trick counter

#### MainMenu Feature
**Simple feature** - Navigation and game setup

**Responsibilities:**
- Game type selection (Single Player, Pass & Play, Tutorial)
- Player configuration
- Rule preset selection
- About/credits display

#### Settings Feature
**Configuration feature** - App preferences

**Responsibilities:**
- Rule configuration (11 toggleable rules)
- Animation preferences (reduce motion)
- Sound preferences (future)
- App information

#### Tutorial Feature
**Onboarding feature** - Interactive tutorial

**Responsibilities:**
- Step-by-step game instructions
- Interactive practice
- UI element highlighting
- Progress tracking

---

### Shared Module
**Purpose:** Reusable UI components and utilities

**Categories:**
1. **Components** - Pre-built UI elements (buttons, cards, overlays)
2. **Modifiers** - View modifiers for styling and effects
3. **Extensions** - SwiftUI and Foundation extensions

**Key Components:**
- `PrimaryButton` - Styled action button
- `CardBackView` - Card back design
- `AlertView` - Custom alert dialog
- `LoadingView` - Loading spinner

**Key Modifiers:**
- `CardStyle` - Apply card styling (shadow, border, etc.)
- `GlowEffect` - Glow effect for selected items
- `ShakeEffect` - Shake animation for errors

---

### Core Module
**Purpose:** Domain models and foundational code

**Structure:**
```
Models/          # Domain models (Card, Player, etc.)
GameState/       # TCA state management types
Extensions/      # Swift standard library extensions
Utilities/       # Helper functions and constants
```

**Key Models:**
- `Card` - Identifiable, Equatable, Hashable card
- `GameState` - Complete game state for TCA
- `GameAction` - All possible actions in the game
- `RuleConfiguration` - Toggleable game rules

**Design Principles:**
- Models are **value types** (structs) when possible
- All models conform to `Equatable` for TCA
- Models are **Codable** for persistence
- Pure data - no business logic in models

---

### Services Module
**Purpose:** Business logic and external interactions

#### GameLogic Services
**Pure business logic** - Game rule implementation

- `CardShuffler` - Fisher-Yates shuffle algorithm
- `RuleValidator` - Move validation (follow suit, bid rules)
- `ScoreCalculator` - Point counting and adjustments
- `TrickResolver` - Determine trick winner

**Pattern:** Protocol-based for testability and dependency injection

```swift
protocol RuleValidator {
    func canPlayCard(_ card: Card, in state: GameState) -> Bool
    func isValidBid(_ bid: Int, current: Int?) -> Bool
}
```

#### AI Services
**AI decision making** - Difficulty-based strategies

- `AIEngine` - Protocol for AI implementations
- `EasyAI`, `MediumAI`, `HardAI` - Difficulty levels
- `BiddingStrategy` - Bidding algorithms
- `PlayStrategy` - Card playing decisions

**Pattern:** Strategy pattern for different AI levels

#### Animation Services
**Animation coordination** - Core Animation and Metal

- `AnimationController` - Coordinates all animations
- `CoreAnimationService` - CALayer-based animations
- `MetalParticleSystem` - GPU particle effects
- `AnimationQueue` - Sequential animation management

#### Persistence Services
**Data storage** - Save game and settings

- `GameStatePersistence` - FileManager-based save/load
- `SettingsPersistence` - UserDefaults for preferences

#### Audio Services (Future)
**Sound and haptics** - Audio playback

- `SoundManager` - AVAudioPlayer wrapper
- `HapticManager` - UIFeedbackGenerator wrapper

---

## File Naming Conventions

### Swift Files
- **Models:** `Card.swift`, `Player.swift` (singular, noun)
- **Views:** `GameTableView.swift`, `BiddingPanelView.swift` (descriptive + View suffix)
- **Services:** `CardShuffler.swift`, `RuleValidator.swift` (noun or verb)
- **Features:** `GameFeature.swift`, `MainMenuFeature.swift` (Feature suffix)
- **Tests:** `CardTests.swift`, `GameFeatureTests.swift` (Tests suffix)
- **Extensions:** `View+Extensions.swift`, `Color+Theme.swift` (Type + Extensions or purpose)

### General Rules
- Use **PascalCase** for file names (matches type name)
- One primary type per file (exceptions: small related enums)
- Group related files in folders
- Test files mirror source file names with `Tests` suffix

### Asset Files
- **Images:** `card-back-blue.png`, `table-texture.png` (kebab-case)
- **Colors:** `PrimaryColor.colorset`, `Background.colorset` (PascalCase)
- **Sounds:** `card-flip.wav`, `victory-fanfare.mp3` (kebab-case)

---

## Build & Configuration

### Build Targets

#### TwentyNine (Main App)
**Target Name:** TwentyNine  
**Bundle ID:** com.codingwithamit.twentynine  
**Platform:** iOS, iPadOS, macOS, tvOS, visionOS  
**Deployment Targets:**
- iOS 17.0+
- iPadOS 17.0+
- macOS 14.0+
- tvOS 17.0+
- visionOS 1.0+

**Build Settings:**
- Swift Language Version: 6.2
- Optimization Level: Debug (-Onone), Release (-O)
- Enable Testability: Debug only

#### TwentyNineTests (Unit/Integration Tests)
**Target Name:** TwentyNineTests  
**Type:** Unit Test Bundle  
**Host Application:** TwentyNine

#### TwentyNineUITests (UI Tests)
**Target Name:** TwentyNineUITests  
**Type:** UI Test Bundle  
**Host Application:** TwentyNine

### Configuration Files

#### Info.plist
**Location:** `TwentyNine/Resources/Info.plist`

**Key Entries:**
- `CFBundleDisplayName` - "TwentyNine"
- `UILaunchScreen` - Launch screen configuration
- `UISupportedInterfaceOrientations` - Portrait + Landscape (iPad)
- `UIRequiredDeviceCapabilities` - arm64

#### .swiftlint.yml
**Location:** Root directory

**Rules Enabled:**
- Line length: 120 characters
- Function body length: 40 lines (warning), 60 (error)
- Type body length: 300 lines (warning), 500 (error)
- Force unwrapping: Error
- Trailing whitespace: Error

#### Package.swift (if using SPM)
**Location:** Root directory

```swift
// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "TwentyNine",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
        .tvOS(.v17),
        .visionOS(.v1)
    ],
    dependencies: [
        .package(url: "https://github.com/ronstorm/tca-kit.git", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "TwentyNine",
            dependencies: [
                .product(name: "TCAKit", package: "tca-kit")
            ]
        )
    ]
)
```

---

## Testing Structure

### TwentyNineTests/ (Unit & Integration)

```
TwentyNineTests/
├── CoreTests/
│   ├── Models/
│   │   ├── CardTests.swift             # Card model tests
│   │   ├── PlayerTests.swift           # Player model tests
│   │   └── RuleConfigurationTests.swift
│   └── Extensions/
│       └── ArrayExtensionsTests.swift
│
├── ServicesTests/
│   ├── GameLogic/
│   │   ├── CardShufflerTests.swift     # Shuffle algorithm tests
│   │   ├── RuleValidatorTests.swift    # Move validation tests
│   │   ├── ScoreCalculatorTests.swift  # Score calculation tests
│   │   └── TrickResolverTests.swift
│   ├── AI/
│   │   ├── EasyAITests.swift           # Easy AI decision tests
│   │   ├── MediumAITests.swift
│   │   ├── HardAITests.swift
│   │   └── BiddingStrategyTests.swift
│   └── Persistence/
│       ├── GameStatePersistenceTests.swift
│       └── SettingsPersistenceTests.swift
│
├── FeaturesTests/
│   ├── GameFeatureTests.swift          # Game reducer tests
│   ├── MainMenuFeatureTests.swift
│   └── SettingsFeatureTests.swift
│
└── TestHelpers/
    ├── MockDependencies.swift          # Mock services
    ├── TestData.swift                  # Test fixtures
    └── XCTestCase+Extensions.swift     # Test helpers
```

### TwentyNineUITests/ (UI Automation)

```
TwentyNineUITests/
├── GameFlowTests/
│   ├── CompleteGameFlowTests.swift     # End-to-end game
│   ├── BiddingFlowTests.swift          # Bidding scenarios
│   └── TrickTakingFlowTests.swift      # Trick-taking scenarios
│
├── AccessibilityTests/
│   ├── VoiceOverTests.swift            # VoiceOver navigation
│   └── DynamicTypeTests.swift          # Text scaling tests
│
└── UITestHelpers/
    ├── XCUIApplication+Extensions.swift
    └── TestScreens.swift               # Page object pattern
```

### Testing Strategy

**Unit Tests (80%+ coverage target):**
- All game logic services
- All AI decision making
- Score calculations
- Move validation
- TCA reducers (using TestStore)

**Integration Tests:**
- Complete game flows (deal → bid → play → score)
- AI vs AI simulation games
- State persistence (save/restore)
- Rule configuration changes

**UI Tests:**
- Critical user paths (start game → play → victory)
- Accessibility features
- Multi-device support

---

## Asset Organization

### Assets.xcassets Structure

```
Assets.xcassets/
├── AppIcon.appiconset/
│   ├── Contents.json
│   ├── icon_1024x1024.png              # App Store icon
│   ├── icon_180x180.png                # iPhone
│   └── ...
│
├── Colors/
│   ├── Primary.colorset/               # Brand primary
│   │   └── Contents.json
│   ├── Secondary.colorset/             # Brand secondary
│   ├── Accent.colorset/                # Accent color
│   ├── Background.colorset/            # Background
│   │   ├── Contents.json               # Light/Dark variants
│   ├── CardTableGreen.colorset/        # Table felt color
│   ├── CardRed.colorset/               # Hearts/Diamonds
│   └── CardBlack.colorset/             # Spades/Clubs
│
├── Images/
│   ├── CardBacks/
│   │   ├── card-back-classic.imageset/
│   │   ├── card-back-modern.imageset/
│   │   └── card-back-minimal.imageset/
│   ├── Decorations/
│   │   ├── table-texture.imageset/
│   │   └── wood-frame.imageset/
│   └── Icons/
│       ├── trophy.imageset/
│       └── crown.imageset/
│
└── Symbols/
    └── TrumpIndicator.symbolset/       # Custom SF Symbol
```

### Asset Naming
- Use **kebab-case** for image assets
- Use **PascalCase** for color sets
- Include variant suffixes: `@2x`, `@3x`, `~dark`, `~ipad`
- Organize by purpose in folders

### Performance
- Use **vector PDFs** when possible (resolution-independent)
- Compress PNGs (ImageOptim or similar)
- Use **asset catalogs** for efficient bundling
- Leverage **on-demand resources** for large assets (future)

---

## Configuration Management

### Environment-Specific Settings

```swift
// Core/Utilities/Constants.swift

enum AppConfiguration {
    static var isDebug: Bool {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }
    
    static var loggingEnabled: Bool {
        isDebug
    }
    
    static var showDeveloperOptions: Bool {
        isDebug
    }
}

enum GameConstants {
    static let minimumBid = 16
    static let maximumBid = 28
    static let totalCardPoints = 28
    static let cardsPerPlayer = 8
    static let tricksPerGame = 8
    static let victoryPoints = 6
    static let defeatPoints = -6
}

enum AnimationConstants {
    static let cardDealDuration: TimeInterval = 0.3
    static let cardFlipDuration: TimeInterval = 0.4
    static let trickCollectionDuration: TimeInterval = 0.6
    static let targetFrameRate = 60.0
}
```

---

## Development Workflow

### Adding a New Feature

1. **Create feature folder** in `Features/`
2. **Create Feature file** with State, Action, Reducer
3. **Create Views/** subfolder for UI
4. **Create Components/** if needed for reusable parts
5. **Create tests** in `TwentyNineTests/FeaturesTests/`
6. **Update dependencies** if new services needed
7. **Document** in `UI_UX_doc.md` if UI changes

### Adding a New Service

1. **Define protocol** in `Services/[Category]/`
2. **Create implementation** conforming to protocol
3. **Register in Dependencies** extension
4. **Create tests** with mock implementation
5. **Document** in code comments

### Adding a New Model

1. **Create model file** in `Core/Models/`
2. **Conform to Equatable** (required for TCA)
3. **Conform to Codable** (if needs persistence)
4. **Add tests** for model logic
5. **Update GameState** if model is part of state

---

## Build Scripts

### generate-assets.sh
**Purpose:** Generate asset variations

```bash
#!/bin/bash
# Generate @2x and @3x versions of card images
# Usage: ./Scripts/generate-assets.sh
```

### run-tests.sh
**Purpose:** Run all tests with coverage

```bash
#!/bin/bash
# Run unit tests, integration tests, generate coverage report
# Usage: ./Scripts/run-tests.sh
```

---

## Migration Guide

### Moving from Flat Structure to Modular

If starting with a flat structure:

1. Create module folders first
2. Move files incrementally by feature
3. Update imports in moved files
4. Run tests after each module migration
5. Update Xcode project references

### Example Migration:
```
Before: TwentyNine/CardView.swift
After:  TwentyNine/Features/Game/Components/CardView.swift
```

---

## Best Practices

### File Organization
✅ **Do:**
- One primary type per file
- Group related types in same folder
- Use clear, descriptive file names
- Keep folder depth reasonable (max 4 levels)

❌ **Don't:**
- Create "Utils" or "Helpers" dump folders
- Mix UI and business logic in same file
- Use abbreviations in file names
- Create files with 1000+ lines

### Module Dependencies
✅ **Do:**
- Features depend on Core and Services
- Services depend on Core only
- Shared depends on Core only
- Core has no dependencies (foundation layer)

❌ **Don't:**
- Create circular dependencies
- Let Core depend on Features
- Bypass service layer from Features

### Testing Organization
✅ **Do:**
- Mirror source structure in tests
- Keep test helpers separate
- Use descriptive test names
- Group related tests in classes

❌ **Don't:**
- Mix unit and integration tests
- Create single massive test file
- Skip testing edge cases

---

## Cross-Platform Considerations

### Platform-Specific Code

```swift
// Use compilation conditions for platform-specific code
#if os(iOS)
    import UIKit
    // iOS-specific code
#elseif os(macOS)
    import AppKit
    // macOS-specific code
#endif
```

### Responsive Layouts

```swift
// Use size classes and environment values
@Environment(\.horizontalSizeClass) var horizontalSize

if horizontalSize == .compact {
    // Narrow layout (iPhone portrait)
} else {
    // Wide layout (iPad, iPhone landscape)
}
```

---

## Version Control

### .gitignore Highlights
```
# Xcode user data
xcuserdata/
*.xcuserstate

# Build artifacts
DerivedData/
build/

# Swift Package Manager
.swiftpm/
Packages/

# macOS
.DS_Store
```

### Commit Conventions
- `feat: Add hard AI implementation`
- `fix: Fix card dealing animation glitch`
- `refactor: Restructure game state model`
- `test: Add tests for score calculator`
- `docs: Update project structure documentation`

---

**Last Updated:** November 23, 2025  
**Next Review:** After Stage 1 implementation

