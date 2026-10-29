# Bug Tracking & Issue Resolution

**Version:** 1.0  
**Last Updated:** November 23, 2025  
**Status:** Active Development

---

## Purpose

This document tracks all bugs, errors, and issues encountered during development along with their solutions. Before fixing any error, check this document first to see if a similar issue has been resolved.

**Why Track Bugs?**
- Avoid solving the same problem twice
- Document lessons learned
- Build institutional knowledge
- Help future developers (including future you!)

---

## How to Use This Document

### When You Encounter a Bug

1. **Search this document** for similar issues
2. If found: Use the documented solution
3. If not found: Add a new entry with details
4. After fixing: Update the entry with solution

### Entry Format

```markdown
### [BUG-XXX] Short Description

**Status:** 🔴 Open | 🟡 In Progress | 🟢 Resolved  
**Priority:** Critical | High | Medium | Low  
**Discovered:** YYYY-MM-DD  
**Resolved:** YYYY-MM-DD (if resolved)  
**Affected Components:** List components/files

**Description:**
Detailed description of the bug, including what was expected vs. what happened.

**Steps to Reproduce:**
1. Step 1
2. Step 2
3. Step 3

**Error Messages:**
```
Paste error messages, stack traces, or console output here
```

**Root Cause:**
Explanation of why this bug occurred.

**Solution:**
How the bug was fixed, including code changes and reasoning.

**Prevention:**
How to avoid this bug in the future.

**Related Issues:** Links to related bugs if any
```

---

## Active Issues

### 🔴 Open Bugs

### [BUG-004] Trump is forced on every player after it's revealed

**Status:** 🔴 Open  
**Priority:** High  
**Discovered:** 2026-10-29  
**Affected Components:** `RuleValidator.canPlayCard`

**Description:**
`game-rule.md` says only the player who *asks* to reveal trump must play a trump on that turn. `canPlayCard` instead forces every void player to trump for the rest of the round once `trumpRevealed` is true. The test `testMustPlayTrumpIfRevealed` encodes the current behaviour.

**Solution:**
Planned for Stage 2.5: pass whether the current player just requested the reveal (e.g., `mustPlayTrump: Bool`) instead of deriving it from `trumpRevealed`.

---

### [BUG-005] "Match a previous bid" rule is ambiguous

**Status:** 🔴 Open  
**Priority:** Medium  
**Discovered:** 2026-10-29  
**Affected Components:** `RuleValidator.isValidBid`

**Description:**
`game-rule.md`: "A player can match a previous bid if they placed it first." The validator only allows a player to match a bid *they currently hold*, which never changes the outcome. The common table rule is that the earlier bidder may match a challenger's raise to keep the bid. Needs a decision on the intended rule before Stage 2.3 bidding UI.

---

---

### 🟡 In Progress

*No bugs in progress yet.*

---

## Resolved Issues

### 🟢 Closed Bugs

### [BUG-001] Game over not detected when game points jump past ±6

**Status:** 🟢 Resolved  
**Priority:** High  
**Discovered:** 2026-10-29  
**Resolved:** 2026-10-29  
**Affected Components:** `GameState`

**Description:**
`GameState.isGameOver` checked `gamePoints == 6 || == -6`. A doubled (±2) or re-doubled (±4) round can move a team from e.g. +4 to +8, so the game would never end.

**Root Cause:**
Exact equality instead of a threshold, plus game points stored twice (`GameState.gamePoints` dictionary and `TeamScore.gamePoints`), so the two could disagree.

**Solution:**
Removed the duplicate dictionary; `gamePoints(for:)` reads `TeamScore.gamePoints`, and `isGameOver` uses `TeamScore.hasWon`/`hasLost` (`>=`/`<=` against `TeamScore.gameEndThreshold`).

**Prevention:**
Keep one source of truth per value; parameterized tests cover ±6, ±7, ±8.

---

### [BUG-002] Card suit tie-break sorted in reverse

**Status:** 🟢 Resolved  
**Priority:** Low  
**Discovered:** 2026-10-29  
**Resolved:** 2026-10-29  
**Affected Components:** `Card`, `Suit`

**Description:**
`Card <` was documented as spades < hearts < diamonds < clubs but compared `suit.rawValue` strings, which sorts alphabetically (clubs < diamonds < hearts < spades).

**Solution:**
`Suit` now conforms to `Comparable` using declaration order; `Card <` compares suits directly.

---

### [BUG-003] Card identity changed on every creation

**Status:** 🟢 Resolved  
**Priority:** Medium  
**Discovered:** 2026-10-29  
**Resolved:** 2026-10-29  
**Affected Components:** `Card`, `GameState`

**Description:**
`Card.id` was a random `UUID` while `==`/`hash` ignored it, so two equal cards had different IDs. This made selection by ID (`Set<UUID>`) and tests non-deterministic. `fullDescription` also returned "J of Spades" instead of the documented "Jack of Spades".

**Solution:**
`Card.id` is derived from rank and suit (each combination is unique in the deck), and Equatable/Hashable are synthesized. Card selection uses `Card.ID`. Added `Rank.name` for spoken names.

---

---

## Common Issue Categories

This section will be populated as patterns emerge during development.

### MVVM & State Management

*Will be populated with MVVM- and navigation-specific issues*

**Common Patterns:**
- State mutated from views instead of through view model intents
- View model created inside a view's `body` (state resets on every re-render; let the coordinator own it)
- Views not updating (type missing `@Observable`, or state marked `@ObservationIgnored`)
- Main-actor isolation errors when calling services from view models
- Retain cycles between coordinator and view model callbacks (capture `[weak self]`)

---

### Animation Issues

*Will be populated with animation-specific issues*

**Common Patterns:**
- Performance drops below 60fps
- Animation timing conflicts
- Metal particle system issues
- Core Animation layer problems

---

### UI Layout Issues

*Will be populated with UI-specific issues*

**Common Patterns:**
- Responsive layout breakage
- SafeArea conflicts
- Device-specific rendering
- Dark mode inconsistencies

---

### Game Logic Bugs

*Will be populated with game rule issues*

**Common Patterns:**
- Incorrect move validation
- Scoring calculation errors
- Trump reveal timing
- AI decision logic

---

### Data Persistence

*Will be populated with save/load issues*

**Common Patterns:**
- Codable decoding failures
- File system errors
- State restoration bugs
- Migration issues

---

## Known Limitations

**Platform Constraints:**
- Metal particle systems require iOS 17.0+ (as per minimum target)
- Core Animation 3D transforms may vary by device performance
- VoiceOver gesture support limited on tvOS

**Design Decisions:**
- Cards locked to 2:3 aspect ratio for traditional feel
- Portrait orientation locked during gameplay (iPhone only)
- Animations disabled when Reduce Motion is enabled

---

## Testing Notes

### Manual Testing Checklist

**Before Each Commit:**
- [ ] Run all unit tests
- [ ] Check for linter warnings
- [ ] Test on simulator (iPhone, iPad)
- [ ] Verify no console errors

**Before Each PR:**
- [ ] Run integration tests
- [ ] Test on physical device
- [ ] Check memory usage
- [ ] Profile animations (60fps?)
- [ ] Test dark mode
- [ ] Test accessibility features

**Before Release:**
- [ ] Full regression test
- [ ] Test all rule configurations
- [ ] AI vs AI simulation (100+ games)
- [ ] Beta tester feedback addressed
- [ ] Performance profiling passed
- [ ] Memory leak check passed

---

## Debug Tools

### Useful Xcode Features

**Instruments:**
- **Time Profiler:** Find CPU bottlenecks
- **Allocations:** Track memory usage
- **Leaks:** Detect memory leaks
- **Core Animation:** Profile animation performance
- **Metal System Trace:** GPU performance

**LLDB Commands:**
```bash
# Print view hierarchy
po UIApplication.shared.windows.first?.rootViewController

# Print state
po store.state

# Break on error
breakpoint set --name objc_exception_throw
```

**SwiftUI Debug:**
```swift
// View hierarchy
._printChanges()  // Print why view re-rendered

// State tracking
.onChange(of: state) { oldValue, newValue in
    print("State changed: \(oldValue) → \(newValue)")
}
```

---

## Performance Baselines

**Target Metrics:**
- **Frame Rate:** 60fps during animations
- **Launch Time:** < 2 seconds
- **Memory:** < 150MB during gameplay
- **AI Response:** < 1s (Easy/Medium), < 2s (Hard)
- **Battery:** < 5% per 30 minutes

**How to Measure:**
1. Use Instruments for profiling
2. Test on oldest supported device (iOS 17.0 device)
3. Run extended gameplay sessions
4. Monitor console for warnings

---

## Contact & Support

**For Development Questions:**
- Check [Implementation.md](Implementation.md) for development plan
- Check [project_structure.md](project_structure.md) for code organization
- Check [UI_UX_doc.md](UI_UX_doc.md) for design specs

**For Game Rules:**
- See game rules in [PRD.md](../PRD.md) Section 15.2
- Check [PRD.md](../PRD.md) for feature requirements

---

## Appendix: Example Bug Entry

### [BUG-001] Card Animation Stuttering on iPhone SE

**Status:** 🟢 Resolved  
**Priority:** High  
**Discovered:** 2025-11-23  
**Resolved:** 2025-11-24  
**Affected Components:** `AnimationController`, `CardView`

**Description:**
When dealing cards on iPhone SE (1st gen), animations drop to ~30fps causing visible stuttering. Cards should deal smoothly at 60fps.

**Steps to Reproduce:**
1. Run app on iPhone SE (1st gen) or simulator
2. Start new game
3. Observe card dealing animation
4. Frame rate drops during animation

**Error Messages:**
```
[Warning] Core Animation: animations taking longer than 16ms per frame
[Performance] Frame rate: 34.2 fps (target: 60 fps)
```

**Root Cause:**
Card dealing was creating new CALayer instances for each animation frame instead of reusing layers. This caused excessive memory allocations and GC pressure on lower-end devices.

**Solution:**
1. Pre-allocate card layers during game setup
2. Reuse existing layers for animations
3. Use `CAAnimationGroup` instead of sequential animations
4. Reduce shadow complexity on `cardTableGreen` background

```swift
// Before (bad)
func dealCard() {
    let layer = CALayer() // New layer every time!
    // ... animation code
}

// After (good)
private var cardLayers: [CALayer] = []

func setupCardLayers() {
    cardLayers = (0..<32).map { _ in
        let layer = CALayer()
        layer.contentsGravity = .resizeAspect
        return layer
    }
}

func dealCard(index: Int) {
    let layer = cardLayers[index] // Reuse existing layer
    // ... animation code
}
```

**Prevention:**
- Always profile animations on lowest-spec device
- Pre-allocate resources when possible
- Use Instruments to detect allocation hotspots
- Add performance tests to CI/CD

**Related Issues:** None

---

**Last Updated:** October 29, 2026  
**Next Review:** After Stage 2 implementation (UI & Game Flow)

