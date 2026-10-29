# TwentyNine

A modern, cross-platform card game built with SwiftUI using MVVM with the Coordinator pattern. TwentyNine is a trick-taking card game popular in South Asia, featuring strategic bidding, trump selection, and team-based gameplay.

## 🎮 Game Overview

TwentyNine is a 4-player partnership card game where teams compete to win tricks and meet their bids. The game features:
- **32-card deck** with custom ranking system
- **Strategic bidding** (16-28 points)
- **Secret trump selection** via indicator cards
- **Team-based scoring** with marriage bonuses
- **Multiple rule variants** and difficulty levels
- **AI opponents** with three difficulty levels

## 📋 Current Status

**Stage 1: Project Foundation & Core Models** ✅ **Complete**

### Completed Features
- ✅ Project setup with multi-platform support (iOS, iPadOS, macOS, tvOS, visionOS)
- ✅ Core data models (`Card`, `Player`, `Team`, `Bid`, `Trick`, `TeamScore`)
- ✅ MVVM + Coordinator architecture (`@Observable` view models, `AppCoordinator` navigation)
- ✅ Game logic services:
  - `CardShuffler` - Fisher-Yates shuffle algorithm
  - `CardDealer` - Counter-clockwise card distribution
  - `RuleValidator` - Move and bid validation
  - `ScoreCalculator` - Point counting and marriage adjustments
- ✅ Comprehensive unit tests (all passing)
- ✅ Swift 6 concurrency compliance

### Next Steps
- 🚧 Stage 2: Basic UI & Game Flow (in progress)
- ⏳ Stage 3: Advanced Animations & Polish
- ⏳ Stage 4: AI Implementation
- ⏳ Stage 5: Tutorial & Accessibility

## 📚 Documentation

### Planning & Requirements
- **[Product Requirements Document](Docs/PRD.md)** - Complete product specification
- **[Game Rules](Docs/game-rule.md)** - Full gameplay rules and instructions

### Development Guides
- **[Implementation Plan](Docs/Implementation.md)** - Staged development roadmap with 12 phases
- **[Project Structure](Docs/project_structure.md)** - Folder organization and architecture
- **[UI/UX Guidelines](Docs/UI_UX_doc.md)** - Design system and component specifications

## 🛠️ Requirements

- **iOS 17.0+**
- **iPadOS 17.0+**
- **macOS 14.0+** (Sonoma)
- **tvOS 17.0+**
- **visionOS 1.0+**
- **Xcode 15.0+**
- **Swift 6.2**

## 🏗️ Architecture

- **Architecture:** MVVM + Coordinator (Observation framework, no third-party dependencies)
- **UI Framework:** SwiftUI
- **Language:** Swift 6.2 with strict concurrency
- **Testing:** Swift Testing framework
- **Package Manager:** Swift Package Manager (SPM)

## 🧪 Testing

Run all tests:
```bash
xcodebuild test -project TwentyNine.xcodeproj -scheme TwentyNine -sdk iphonesimulator
```

Current test coverage:
- ✅ Card shuffling and dealing logic
- ✅ Rule validation (suit following, trump rules)
- ✅ Score calculation (trick points, marriage bonuses)
- ✅ Game state, view models and coordinator navigation

## 📄 License

MIT License - see [LICENSE](LICENSE) for details.

---

© 2025 Coding With Amit. All rights reserved.

