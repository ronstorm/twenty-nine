# TwentyNine UI/UX Documentation

**Version:** 1.0  
**Last Updated:** November 23, 2025  
**Reference:** [PRD.md](../PRD.md) | [Implementation.md](Implementation.md)

---

## Table of Contents
1. [Design Philosophy](#design-philosophy)
2. [Design System](#design-system)
3. [Screen Specifications](#screen-specifications)
4. [Component Library](#component-library)
5. [Animation Guidelines](#animation-guidelines)
6. [Responsive Design](#responsive-design)
7. [Accessibility](#accessibility)
8. [User Flows](#user-flows)
9. [Prototyping & Testing](#prototyping--testing)

---

## Design Philosophy

### Core Principles

#### 1. Authentic Experience
**Goal:** Feel like playing with real cards at a real table

- **Visual Realism:** Textured card table, realistic card shadows
- **Physical Metaphors:** Cards slide, flip, and stack like real cards
- **Traditional Aesthetics:** Classic playing card designs
- **Cultural Authenticity:** Honor South Asian gaming traditions

#### 2. Clarity Over Complexity
**Goal:** Always know what's happening and what to do next

- **Clear Affordances:** Buttons look clickable, cards look draggable
- **Visual Hierarchy:** Important information stands out
- **Immediate Feedback:** Every action has visible response
- **Progressive Disclosure:** Show advanced options only when needed

#### 3. Delightful Interactions
**Goal:** Make every interaction feel smooth and satisfying

- **Smooth Animations:** 60fps, natural easing curves
- **Celebration Moments:** Victory, marriage, special achievements
- **Subtle Details:** Card flip sounds, haptic feedback, particle effects
- **Polish:** No rough edges, everything feels intentional

#### 4. Accessible to All
**Goal:** Playable by everyone, regardless of ability

- **VoiceOver Support:** Full screen reader compatibility
- **High Contrast:** Color-blind friendly with symbol emphasis
- **Scalable Text:** Dynamic Type support
- **Reduce Motion:** Alternative animations for accessibility
- **Clear Language:** Simple, beginner-friendly terminology

---

## Design System

### Color Palette

#### Brand Colors
```swift
// Core/Extensions/Color+Theme.swift

extension Color {
    // Primary Brand Colors
    static let primaryGreen = Color(hex: "#2D5C3F")      // Dark forest green
    static let accentGold = Color(hex: "#D4AF37")        // Rich gold
    static let cardTableGreen = Color(hex: "#0B5F31")    // Felt table green
    
    // Card Colors
    static let cardRed = Color(hex: "#DC143C")           // Crimson red (Hearts/Diamonds)
    static let cardBlack = Color(hex: "#1C1C1C")         // True black (Spades/Clubs)
    static let cardWhite = Color(hex: "#FAFAFA")         // Off-white (card background)
    static let cardBorder = Color(hex: "#D4D4D4")        // Light gray border
    
    // UI Colors
    static let backgroundLight = Color(hex: "#F5F5F5")   // Light mode background
    static let backgroundDark = Color(hex: "#1A1A1A")    // Dark mode background
    static let surfaceLight = Color(hex: "#FFFFFF")      // Light mode surface
    static let surfaceDark = Color(hex: "#2A2A2A")       // Dark mode surface
    
    // Semantic Colors
    static let success = Color(hex: "#28A745")           // Success green
    static let error = Color(hex: "#DC3545")             // Error red
    static let warning = Color(hex: "#FFC107")           // Warning amber
    static let info = Color(hex: "#17A2B8")              // Info blue
    
    // Text Colors
    static let textPrimary = Color(hex: "#212529")       // Primary text (light mode)
    static let textSecondary = Color(hex: "#6C757D")     // Secondary text
    static let textDisabled = Color(hex: "#ADB5BD")      // Disabled text
    static let textPrimaryDark = Color(hex: "#F8F9FA")   // Primary text (dark mode)
}
```

#### Color Usage Guidelines

| Element | Light Mode | Dark Mode | Purpose |
|---------|-----------|-----------|---------|
| Background | `backgroundLight` | `backgroundDark` | Main screen background |
| Card Table | `cardTableGreen` | `cardTableGreen` | Game table surface |
| Cards | `cardWhite` | `cardWhite` | Card background (always light) |
| Primary Actions | `primaryGreen` | `primaryGreen` | Main action buttons |
| Accent | `accentGold` | `accentGold` | Highlights, selected states |
| Hearts/Diamonds | `cardRed` | `cardRed` | Red suits |
| Spades/Clubs | `cardBlack` | `cardBlack` | Black suits |

### Typography

#### Font System
**System Font:** SF Pro (iOS/macOS default)  
**Fallback:** System default for each platform

```swift
// Typography Scale
enum FontStyle {
    // Display
    case displayLarge      // 57pt, Bold
    case displayMedium     // 45pt, Bold
    case displaySmall      // 36pt, Bold
    
    // Headline
    case headlineLarge     // 32pt, Bold
    case headlineMedium    // 28pt, Semibold
    case headlineSmall     // 24pt, Semibold
    
    // Title
    case titleLarge        // 22pt, Regular
    case titleMedium       // 16pt, Medium
    case titleSmall        // 14pt, Medium
    
    // Body
    case bodyLarge         // 16pt, Regular
    case bodyMedium        // 14pt, Regular
    case bodySmall         // 12pt, Regular
    
    // Label
    case labelLarge        // 14pt, Medium
    case labelMedium       // 12pt, Medium
    case labelSmall        // 11pt, Medium
    
    // Card Rank
    case cardRankLarge     // 48pt, Bold - on card face
    case cardRankSmall     // 18pt, Bold - card corners
}
```

#### Typography Usage

| Element | Style | Purpose |
|---------|-------|---------|
| Screen Titles | `displaySmall` | Main menu title |
| Section Headers | `headlineMedium` | Settings sections |
| Player Names | `titleMedium` | Player indicators |
| Card Ranks | `cardRankLarge` | Card face rank |
| Scores | `titleLarge` | Score display |
| Buttons | `labelLarge` | Button labels |
| Body Text | `bodyMedium` | Instructions, descriptions |
| Hints | `bodySmall` | Tutorial hints |

### Spacing System

#### Spacing Scale
```swift
enum Spacing {
    static let xxxs: CGFloat = 2    // Tight spacing
    static let xxs: CGFloat = 4     // Minimal spacing
    static let xs: CGFloat = 8      // Extra small
    static let sm: CGFloat = 12     // Small
    static let md: CGFloat = 16     // Medium (base unit)
    static let lg: CGFloat = 24     // Large
    static let xl: CGFloat = 32     // Extra large
    static let xxl: CGFloat = 48    // 2X large
    static let xxxl: CGFloat = 64   // 3X large
}
```

#### Spacing Usage
- **Card Margins:** `md` (16pt)
- **Button Padding:** `sm` horizontal, `xs` vertical (12pt × 8pt)
- **Section Spacing:** `lg` (24pt)
- **Screen Padding:** `md` to `lg` (16-24pt depending on device)
- **Card Separation:** `xs` (8pt) in hand, `xxs` (4pt) in stack

### Elevation & Shadows

#### Shadow Levels
```swift
enum ShadowStyle {
    case none          // No shadow
    case subtle        // Light shadow for cards
    case elevated      // Moderate shadow for floating elements
    case prominent     // Strong shadow for modals
    case dramatic      // Extra strong for trump reveal
}

extension View {
    func shadow(_ style: ShadowStyle) -> some View {
        switch style {
        case .none:
            return self
        case .subtle:
            return self.shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
        case .elevated:
            return self.shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 4)
        case .prominent:
            return self.shadow(color: .black.opacity(0.25), radius: 16, x: 0, y: 8)
        case .dramatic:
            return self.shadow(color: .black.opacity(0.35), radius: 24, x: 0, y: 12)
        }
    }
}
```

#### Elevation Usage
- **Cards in Hand:** `subtle` - slight depth
- **Selected Card:** `elevated` - lifts above others
- **Floating Panels:** `prominent` - clear separation
- **Trump Reveal:** `dramatic` - maximum impact

### Corner Radius

```swift
enum CornerRadius {
    static let sm: CGFloat = 4      // Small elements
    static let md: CGFloat = 8      // Cards, buttons
    static let lg: CGFloat = 12     // Panels
    static let xl: CGFloat = 16     // Modals
    static let round: CGFloat = 999 // Fully round (pills)
}
```

#### Radius Usage
- **Cards:** `md` (8pt) - traditional playing card corners
- **Buttons:** `md` (8pt) - modern but not too round
- **Panels:** `lg` (12pt) - friendly, approachable
- **Avatars:** `round` - fully circular

---

## Screen Specifications

### 1. Main Menu Screen

#### Layout Structure
```
┌─────────────────────────────────────────┐
│                                         │
│              [Logo/Icon]                │  ← displayLarge "TwentyNine"
│                                         │     + Card graphic
│                                         │
│         [Start New Game]                │  ← Primary button (full width)
│         [Continue Game]                 │  ← Secondary (if saved game)
│         [Tutorial]                      │  ← Secondary
│         [Settings]                      │  ← Secondary
│         [About]                         │  ← Tertiary/text button
│                                         │
│                                         │
│            v1.0.0 • © 2025              │  ← labelSmall, muted
└─────────────────────────────────────────┘
```

#### Specifications
- **Background:** `backgroundLight` (light mode), `backgroundDark` (dark mode)
- **Button Stack Spacing:** `sm` (12pt)
- **Screen Padding:** `lg` (24pt) horizontal, `xl` (32pt) vertical
- **Logo Size:** 120×120pt
- **Button Width:** Full width minus screen padding
- **Button Height:** 56pt (touch-friendly)

#### Interactions
- **Start New Game:** Navigates to game setup
- **Continue Game:** Disabled with 50% opacity if no saved game
- **Tutorial:** Opens tutorial mode
- **Settings:** Opens settings sheet
- **About:** Opens about modal

#### Animations
- **Entry:** Fade in + slight scale up (0.3s ease-out)
- **Button Press:** Scale to 0.96 (0.1s ease-in-out)
- **Navigation:** Slide transition (0.25s ease-in-out)

---

### 2. Game Setup Screen

#### Layout Structure
```
┌─────────────────────────────────────────┐
│  ← Back        New Game                 │  ← Navigation bar
├─────────────────────────────────────────┤
│                                         │
│  Game Mode                              │  ← Section header
│  ○ Single Player (You + 3 AI)          │  ← Radio buttons
│  ○ Pass & Play (4 Players)             │
│                                         │
│  Players                                │  ← Section header
│  South (You):  [Your Name_____]        │  ← Text field
│  West (AI):    [Easy ▼]                │  ← Dropdown
│  North (AI):   [Easy ▼]                │
│  East (AI):    [Easy ▼]                │
│                                         │
│  Rules                                  │  ← Section header
│  Preset:       [Standard ▼]            │  ← Dropdown
│  [Customize Rules...]                  │  ← Link
│                                         │
│         [Start Game]                    │  ← Primary button
└─────────────────────────────────────────┘
```

#### Specifications
- **Section Spacing:** `xl` (32pt)
- **Field Height:** 44pt minimum (accessibility)
- **Radio/Checkbox Size:** 24×24pt
- **Dropdown Height:** 44pt

#### Interactions
- **Game Mode:** Toggle between single player and pass & play
- **AI Difficulty:** Dropdown with Easy/Medium/Hard
- **Rules Preset:** Dropdown with Standard/Bangladesh Classic/Advanced/Beginner/Custom
- **Customize Rules:** Opens rule configuration sheet

---

### 3. Game Table Screen (Main Game View)

#### Layout Structure (iPhone Portrait)
```
┌─────────────────────────────────────────┐
│  ⚙️ Settings    Trick 3/8    Menu ≡     │  ← Status bar
├─────────────────────────────────────────┤
│                                         │
│            [NORTH - AI]                 │  ← Opponent (top)
│         [🂠] [🂠] [🂠] [🂠]              │     Card backs (4 cards visible)
│                                         │
│  [WEST]              Trump: ?    [EAST] │  ← Opponents (sides)
│  [🂠]                              [🂠]  │     Card backs + trump indicator
│  [🂠]        ┌─────────────┐      [🂠]  │
│  [🂠]        │   Played    │      [🂠]  │  ← Center play area
│  [🂠]        │   Cards     │      [🂠]  │
│              │  [🂡] [🂱]  │            │     Cards in current trick
│              └─────────────┘            │
│                                         │
│            [SOUTH - You]                │  ← Player (bottom)
│      [J♠] [9♥] [A♣] [10♦]              │     Player's hand (fanned)
│        [K♠] [8♥] [Q♦]                  │
│                                         │
│  Score: R🟥🟥🟥 | B⬛️  Bid: 22          │  ← Score display
└─────────────────────────────────────────┘
```

#### Layout Structure (iPad Landscape)
```
┌──────────────────────────────────────────────────────────┐
│  ⚙️ Settings       TwentyNine • Trick 3/8       Menu ≡   │
├──────────────────────────────────────────────────────────┤
│                                                          │
│                     [NORTH - AI]                         │
│            [🂠] [🂠] [🂠] [🂠] [🂠] [🂠]                  │
│                                                          │
│  [WEST]                                         [EAST]   │
│  [🂠]                                            [🂠]    │
│  [🂠]          ┌──────────────────┐             [🂠]    │
│  [🂠]          │  Played Cards    │             [🂠]    │
│  [🂠]          │   [🂡] [🂱]      │             [🂠]    │
│  [🂠]          │ Trump: ? (Hidden)│             [🂠]    │
│  [🂠]          └──────────────────┘             [🂠]    │
│                                                          │
│                    [SOUTH - You]                         │
│      [J♠] [9♥] [A♣] [10♦] [K♠] [8♥] [Q♦] [7♣]          │
│                                                          │
│  Score: R🟥🟥🟥 | B⬛️         Bid: 22 (You)             │
└──────────────────────────────────────────────────────────┘
```

#### Specifications

**Card Sizes:**
- iPhone (Portrait): 60×90pt (0.67 aspect ratio)
- iPhone (Landscape): 50×75pt
- iPad: 80×120pt
- Card aspect ratio: Always 2:3

**Player Positions:**
- North: Top center
- South: Bottom center (human player default)
- East: Right side, vertical stack
- West: Left side, vertical stack

**Card Hand Layout:**
- Cards overlap by 60% to save space
- Fan spread: 5-10° between cards
- Selected card: Lifts 20pt up
- Tap to select, tap again to play

**Center Play Area:**
- 4 cards arranged in cross pattern
- Cards slightly offset/rotated for visual interest
- Trump indicator: Icon or hidden card symbol

**Status Bar Elements:**
- Settings icon (⚙️): Top-left
- Trick counter: Top-center ("Trick 3/8")
- Menu icon (≡): Top-right

**Score Display:**
- Red 6s (🟥): Positive score
- Black 6s (⬛️): Negative score
- Current bid: "Bid: 22 (You)" or "Bid: 22 (North)"

#### Interactions

**Card Selection (Human Player):**
1. Tap card → Card lifts 20pt
2. Tap again → Card plays (slides to center)
3. Tap different card → Previous deselects, new selects

**Valid Card Highlighting:**
- Playable cards: Subtle glow (2pt, opacity 0.3)
- Invalid cards: 50% opacity when any card selected

**Turn Indicator:**
- Active player name: Bold + accent color
- Active position: Glowing outline

**Trump Reveal:**
- Hidden: "Trump: ?" with question mark icon
- Revealed: "Trump: ♠" with suit symbol + animation

#### Animations
- **Card Deal:** Cards fly from deck to positions (0.3s each, staggered 0.1s)
- **Card Selection:** Smooth lift (0.15s ease-out)
- **Card Play:** Throw to center (0.4s ease-in)
- **Trick Win:** Cards collect to winner (0.6s ease-in-out)
- **Trump Reveal:** Dramatic flip (0.8s with spring)

---

### 4. Bidding Panel (Overlay)

#### Layout Structure
```
┌─────────────────────────────────────────┐
│        [Dimmed Game Table]              │
│  ┌─────────────────────────────────┐   │
│  │                                 │   │
│  │      Your Turn to Bid           │   │  ← headlineMedium
│  │                                 │   │
│  │  Current Bid: 20 (by East)      │   │  ← titleMedium
│  │                                 │   │
│  │  [16][17][18][19][20]           │   │  ← Disabled bids (≤ current)
│  │  [21][22][23][24][25]           │   │  ← Active bids (> current)
│  │  [26][27][28]                   │   │
│  │                                 │   │
│  │         [Pass]                  │   │  ← Secondary button
│  │                                 │   │
│  │  Bid History:                   │   │  ← labelSmall
│  │  West: 16, North: Pass          │   │
│  │  East: 20                       │   │
│  │                                 │   │
│  └─────────────────────────────────┘   │
└─────────────────────────────────────────┘
```

#### Specifications
- **Panel Width:** 320pt (iPhone), 400pt (iPad)
- **Panel Padding:** `md` (16pt)
- **Bid Button Size:** 56×56pt (square)
- **Bid Button Spacing:** `xs` (8pt)
- **Pass Button:** Full width, 48pt height

**Bid Button States:**
- **Default (valid bid):** Primary color, enabled
- **Below current:** Gray, disabled, 50% opacity
- **Current bid (if yours):** Accent color outline
- **Hover (iPad/Mac):** Scale 1.05
- **Pressed:** Scale 0.95

#### Interactions
- **Bid Selection:** Tap number → Confirms bid → Panel dismisses
- **Pass:** Tap Pass → Confirm alert → Panel dismisses
- **Dismiss:** Tap outside panel (only if can pass)

#### Animations
- **Entry:** Fade in background (0.2s) + slide up panel (0.3s ease-out)
- **Exit:** Slide down + fade out (0.25s ease-in)
- **Bid Confirm:** Flash selected button (0.2s)

---

### 5. Trump Selection Screen

#### Layout Structure
```
┌─────────────────────────────────────────┐
│                                         │
│        Select Trump Suit                │  ← headlineLarge
│                                         │
│    Tap a card to set trump suit         │  ← bodyMedium
│                                         │
│         ┌─────┐  ┌─────┐                │
│         │ 2♠  │  │ 3♥  │                │  ← Trump indicators
│         │     │  │     │                │     (large, elevated)
│         └─────┘  └─────┘                │
│                                         │
│         ┌─────┐  ┌─────┐                │
│         │ 4♦  │  │ 5♣  │                │
│         │     │  │     │                │
│         └─────┘  └─────┘                │
│                                         │
│                                         │
│    Trump will be hidden from others     │  ← labelSmall, muted
└─────────────────────────────────────────┘
```

#### Specifications
- **Card Size:** 100×150pt (large for easy tap)
- **Card Spacing:** `lg` (24pt)
- **Layout:** 2×2 grid, centered
- **Screen Padding:** `xl` (32pt)

#### Interactions
- **Card Selection:** Tap card → Highlight → Confirm dialog
- **Confirmation:** "Set ♠ as trump?" → Yes/No
- **Result:** Selected card slides to table center, flips face down

#### Animations
- **Entry:** Cards fade in + scale up (0.4s, staggered 0.1s)
- **Hover:** Card lifts slightly (iPad/Mac)
- **Selection:** Card glows + scales to 1.1
- **Confirm:** Selected card flies to center (0.5s) + flips (0.4s)

---

### 6. Score Summary Screen

#### Layout Structure
```
┌─────────────────────────────────────────┐
│                                         │
│        [Trophy/Sad Icon]                │  ← Success/failure icon
│                                         │
│         Round Complete!                 │  ← displaySmall
│                                         │
│  ┌─────────────────────────────────┐   │
│  │  Your Team (North-South)        │   │  ← Section
│  │                                 │   │
│  │  Cards Won:  24 points          │   │  ← titleMedium
│  │  Bid Target: 22 points          │   │
│  │  Marriage:   +4 bonus           │   │
│  │  ─────────────────────          │   │
│  │  Result:     SUCCESS ✓          │   │  ← success color
│  │                                 │   │
│  │  Game Points: +1                │   │
│  │  Total Score: 🟥🟥🟥           │   │  ← Visual score
│  └─────────────────────────────────┘   │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │  Opponent Team (East-West)      │   │
│  │                                 │   │
│  │  Cards Won:  4 points           │   │
│  │  Total Score: ⬛️                │   │
│  └─────────────────────────────────┘   │
│                                         │
│     [Play Again]   [Main Menu]         │  ← Action buttons
└─────────────────────────────────────────┘
```

#### Specifications
- **Panel Style:** Elevated card with `prominent` shadow
- **Icon Size:** 80×80pt
- **Section Padding:** `md` (16pt)
- **Button Width:** Equal width, side-by-side

#### Interactions
- **Play Again:** Start new round (same players/rules)
- **Main Menu:** Return to main menu (confirm if game in progress)

#### Animations
- **Entry:** Fade in + scale up (0.5s ease-out)
- **Success:** Confetti particle effect (2s, Metal)
- **Failure:** Subtle shake effect (0.3s)
- **Score Update:** Number count-up animation (1s)

---

### 7. Victory Screen

#### Layout Structure
```
┌─────────────────────────────────────────┐
│                                         │
│         [Confetti Animation]            │  ← Metal particle system
│                                         │
│            🏆 VICTORY! 🏆               │  ← displayLarge
│                                         │
│       North-South Team Wins!            │  ← headlineMedium
│                                         │
│  ┌─────────────────────────────────┐   │
│  │  Final Score                    │   │
│  │                                 │   │
│  │  Your Team:     🟥🟥🟥🟥🟥🟥   │   │  ← 6 red
│  │  Opponent Team: ⬛️⬛️⬛️          │   │
│  │                                 │   │
│  │  Game Duration: 15 minutes      │   │
│  │  Rounds Played: 9               │   │
│  │  Marriages:     2               │   │
│  └─────────────────────────────────┘   │
│                                         │
│     [Play Again]   [Main Menu]         │
└─────────────────────────────────────────┘
```

#### Specifications
- **Confetti:** 200-500 particles, multi-colored, 3s duration
- **Trophy:** Animated (rotate + bounce)
- **Stats Panel:** Semi-transparent background

#### Animations
- **Entry:** Confetti burst from center
- **Trophy:** Bounce in (0.6s spring)
- **Text:** Fade in (0.8s staggered)
- **Continuous:** Gentle floating confetti

---

## Component Library

### Buttons

#### Primary Button
**Usage:** Main actions (Start Game, Confirm, etc.)

```swift
struct PrimaryButton: View {
    let title: String
    let action: () -> Void
    @Environment(\.isEnabled) var isEnabled
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.labelLarge)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(isEnabled ? Color.primaryGreen : Color.textDisabled)
                .cornerRadius(.md)
        }
        .shadow(.subtle)
    }
}
```

**States:**
- Default: Primary green background
- Hover: 5% lighter
- Pressed: Scale 0.96
- Disabled: Gray, 50% opacity

#### Secondary Button
**Usage:** Secondary actions (Cancel, Pass, etc.)

```swift
struct SecondaryButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.labelLarge)
                .foregroundColor(.primaryGreen)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(Color.clear)
                .overlay(
                    RoundedRectangle(cornerRadius: .md)
                        .stroke(Color.primaryGreen, lineWidth: 2)
                )
        }
    }
}
```

#### Icon Button
**Usage:** Settings, menu, close buttons

```swift
struct IconButton: View {
    let systemName: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: systemName)
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(.textPrimary)
                .frame(width: 44, height: 44)
                .background(Color.surfaceLight.opacity(0.8))
                .clipShape(Circle())
        }
        .shadow(.subtle)
    }
}
```

---

### Cards

#### CardView Component
**Usage:** Display individual playing cards

```swift
struct CardView: View {
    let card: Card
    let size: CardSize
    let faceUp: Bool
    let isSelected: Bool
    let isHighlighted: Bool
    
    var body: some View {
        ZStack {
            // Card background
            RoundedRectangle(cornerRadius: .md)
                .fill(Color.cardWhite)
                .overlay(
                    RoundedRectangle(cornerRadius: .md)
                        .stroke(Color.cardBorder, lineWidth: 1)
                )
            
            if faceUp {
                // Card face content
                VStack {
                    HStack {
                        rankView(size: .small)
                        Spacer()
                    }
                    Spacer()
                    rankView(size: .large)
                    Spacer()
                    HStack {
                        Spacer()
                        rankView(size: .small)
                            .rotationEffect(.degrees(180))
                    }
                }
                .padding(.xs)
            } else {
                // Card back pattern
                CardBackView()
            }
        }
        .frame(width: size.width, height: size.height)
        .shadow(isSelected ? .elevated : .subtle)
        .scaleEffect(isSelected ? 1.05 : 1.0)
        .overlay(
            RoundedRectangle(cornerRadius: .md)
                .stroke(Color.accentGold, lineWidth: isHighlighted ? 3 : 0)
        )
    }
    
    @ViewBuilder
    private func rankView(size: RankSize) -> some View {
        VStack(spacing: 2) {
            Text(card.rank.symbol)
                .font(size == .small ? .cardRankSmall : .cardRankLarge)
                .foregroundColor(card.suit.color)
            
            Text(card.suit.symbol)
                .font(size == .small ? .bodySmall : .headlineSmall)
                .foregroundColor(card.suit.color)
        }
    }
}

enum CardSize {
    case small, medium, large
    
    var width: CGFloat {
        switch self {
        case .small: return 50
        case .medium: return 60
        case .large: return 80
        }
    }
    
    var height: CGFloat { width * 1.5 }
}
```

---

### Overlays

#### Alert View
**Usage:** Confirmations, warnings, info

```swift
struct AlertView: View {
    let title: String
    let message: String
    let primaryAction: (title: String, action: () -> Void)
    let secondaryAction: (title: String, action: () -> Void)?
    
    var body: some View {
        VStack(spacing: .md) {
            VStack(spacing: .xs) {
                Text(title)
                    .font(.headlineSmall)
                    .foregroundColor(.textPrimary)
                
                Text(message)
                    .font(.bodyMedium)
                    .foregroundColor(.textSecondary)
                    .multilineTextAlignment(.center)
            }
            
            HStack(spacing: .sm) {
                if let secondary = secondaryAction {
                    SecondaryButton(title: secondary.title, action: secondary.action)
                }
                PrimaryButton(title: primaryAction.title, action: primaryAction.action)
            }
        }
        .padding(.lg)
        .background(Color.surfaceLight)
        .cornerRadius(.xl)
        .shadow(.prominent)
    }
}
```

---

## Animation Guidelines

### Animation Timing

#### Duration Standards
```swift
enum AnimationDuration {
    static let instant: TimeInterval = 0.1      // Immediate feedback
    static let quick: TimeInterval = 0.2        // Button presses, highlights
    static let normal: TimeInterval = 0.3       // Standard transitions
    static let moderate: TimeInterval = 0.5     // Card movements
    static let slow: TimeInterval = 0.8         // Dramatic reveals
    static let very_slow: TimeInterval = 1.2    // Victory sequences
}
```

#### Easing Curves
```swift
extension Animation {
    static let quickSnap = Animation.easeIn(duration: 0.1)
    static let buttonPress = Animation.easeInOut(duration: 0.15)
    static let cardMovement = Animation.easeOut(duration: 0.3)
    static let smooth = Animation.easeInOut(duration: 0.3)
    static let bouncy = Animation.spring(response: 0.3, dampingFraction: 0.6)
    static let dramatic = Animation.spring(response: 0.5, dampingFraction: 0.7)
}
```

### Animation Principles

#### 1. Anticipation
**What:** Show intent before action

**Example:** Card lifts slightly before flying to center
```swift
.onTapGesture {
    // Anticipation
    withAnimation(.quickSnap) {
        cardScale = 1.05
    }
    
    // Main action
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
        withAnimation(.cardMovement) {
            playCard()
        }
    }
}
```

#### 2. Follow-Through
**What:** Continue motion naturally after main action

**Example:** Card overshoots slightly then settles
```swift
withAnimation(.bouncy) {
    cardPosition = targetPosition
}
```

#### 3. Squash & Stretch
**What:** Exaggerate deformation for impact

**Example:** Card compresses slightly on landing
```swift
.scaleEffect(x: isLanding ? 1.05 : 1.0, y: isLanding ? 0.95 : 1.0)
```

#### 4. Staging
**What:** Direct attention to important elements

**Example:** Dim background when showing modal
```swift
.background(
    Color.black
        .opacity(showModal ? 0.5 : 0)
        .ignoresSafeArea()
        .animation(.smooth)
)
```

### Core Animation Specifications

#### Card Deal Animation
**Technique:** CAKeyframeAnimation  
**Duration:** 0.3s per card  
**Easing:** Ease-out curve  
**Stagger:** 0.1s between cards

```swift
// Pseudo-code for card dealing
func dealCard(to position: CGPoint, delay: TimeInterval) {
    let path = createPath(from: deckPosition, to: position)
    
    let animation = CAKeyframeAnimation(keyPath: "position")
    animation.path = path
    animation.duration = 0.3
    animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
    animation.beginTime = CACurrentMediaTime() + delay
    animation.fillMode = .forwards
    animation.isRemovedOnCompletion = false
    
    cardLayer.add(animation, forKey: "deal")
}
```

#### Card Flip Animation
**Technique:** CATransform3D rotation  
**Duration:** 0.4s  
**Easing:** Ease-in-out  
**Axis:** Y-axis (horizontal flip)

```swift
func flipCard(faceUp: Bool) {
    let fromAngle: CGFloat = faceUp ? 0 : .pi
    let toAngle: CGFloat = faceUp ? .pi : 0
    
    var perspective = CATransform3DIdentity
    perspective.m34 = -1.0 / 500.0 // Perspective depth
    
    let rotation = CATransform3DRotate(perspective, toAngle, 0, 1, 0)
    
    let animation = CABasicAnimation(keyPath: "transform")
    animation.fromValue = CATransform3DRotate(perspective, fromAngle, 0, 1, 0)
    animation.toValue = rotation
    animation.duration = 0.4
    animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
    
    cardLayer.transform = rotation
    cardLayer.add(animation, forKey: "flip")
}
```

### Metal Particle Systems

#### Confetti Effect (Victory)
**Particle Count:** 200-500  
**Duration:** 3s  
**Emission:** Burst from center  
**Colors:** Red, gold, green, blue (random)  
**Physics:** Gravity + air resistance

```swift
struct ConfettiParticle {
    var position: SIMD2<Float>
    var velocity: SIMD2<Float>
    var rotation: Float
    var rotationSpeed: Float
    var color: SIMD4<Float>
    var lifetime: Float
    var size: Float
}

// Metal shader for particle rendering
func emitConfetti(count: Int, from point: CGPoint) {
    for _ in 0..<count {
        let angle = Float.random(in: 0...(2 * .pi))
        let speed = Float.random(in: 200...400)
        let velocity = SIMD2<Float>(
            cos(angle) * speed,
            sin(angle) * speed - 500 // Initial upward boost
        )
        
        let particle = ConfettiParticle(
            position: SIMD2<Float>(Float(point.x), Float(point.y)),
            velocity: velocity,
            rotation: Float.random(in: 0...(2 * .pi)),
            rotationSpeed: Float.random(in: -5...5),
            color: randomColor(),
            lifetime: 3.0,
            size: Float.random(in: 4...8)
        )
        
        particles.append(particle)
    }
}
```

#### Sparkle Effect (Marriage Declaration)
**Particle Count:** 50-100  
**Duration:** 1s  
**Emission:** Continuous from card  
**Colors:** Gold, white  
**Physics:** Gentle float upward + fade

---

## Responsive Design

### Device Breakpoints

#### iPhone SE (Small)
- Screen: 320×568pt
- Cards: 50×75pt
- Font scale: 0.9×
- Spacing: Compact

#### iPhone Standard
- Screen: 390×844pt
- Cards: 60×90pt
- Font scale: 1.0×
- Spacing: Normal

#### iPhone Pro Max (Large)
- Screen: 430×932pt
- Cards: 70×105pt
- Font scale: 1.1×
- Spacing: Comfortable

#### iPad
- Screen: 1024×768pt (landscape)
- Cards: 80×120pt
- Font scale: 1.0× (absolute sizes)
- Spacing: Generous
- Layout: Optimized for landscape

### Orientation Support

#### iPhone
- **Portrait:** Primary orientation (locked in game)
- **Landscape:** Supported for main menu and settings

#### iPad
- **Both:** Fully supported, layout adapts
- **Landscape:** Preferred for gameplay

### Size Classes

```swift
@Environment(\.horizontalSizeClass) var horizontalSize
@Environment(\.verticalSizeClass) var verticalSize

var isCompact: Bool {
    horizontalSize == .compact && verticalSize == .regular
}

var isRegular: Bool {
    horizontalSize == .regular || verticalSize == .regular
}
```

**Layout Adaptations:**
- **Compact:** Stack layouts, smaller cards, minimal spacing
- **Regular:** Side-by-side layouts, larger cards, generous spacing

---

## Accessibility

### VoiceOver Support

#### Screen Descriptions
**Main Menu:**
```
"Main Menu. TwentyNine card game."
"Start New Game button. Begins a new game."
"Continue Game button. Dimmed. No saved game available."
```

**Game Table:**
```
"Game table. Trick 3 of 8. Your turn."
"Your hand. 8 cards."
"Jack of Spades. Playable. Double tap to select."
"Trump suit is hidden. Not yet revealed."
```

**Bidding:**
```
"Bidding panel. Current bid: 20 by East."
"Bid 21 button. Double tap to bid 21 points."
"Pass button. Double tap to pass this round."
```

#### Implementation
```swift
// Card accessibility
CardView(card: card)
    .accessibilityLabel("\(card.rank.name) of \(card.suit.name)")
    .accessibilityHint(isPlayable ? "Playable. Double tap to play." : "Not playable.")
    .accessibilityAddTraits(isPlayable ? [.isButton] : [])
    .accessibilityRemoveTraits(!isPlayable ? [.isButton] : [])
```

### Dynamic Type

**Text Scaling:** Support all Dynamic Type sizes (XS to XXXL)

```swift
Text("Score: 22")
    .font(.titleMedium)
    .dynamicTypeSize(...DynamicTypeSize.xxxLarge) // Cap at XXXL to prevent layout breaks
```

**Layout Adjustments:**
- Increase spacing at larger sizes
- Stack horizontally compact layouts
- Increase button sizes proportionally

### Reduce Motion

**Detect Setting:**
```swift
@Environment(\.accessibilityReduceMotion) var reduceMotion
```

**Adaptations:**
- Replace card flying with instant position changes
- Fade in/out instead of complex animations
- Disable particle effects
- Keep essential feedback (highlights, selection)

**Example:**
```swift
func playCard() {
    if reduceMotion {
        // Instant: No animation
        cardPosition = targetPosition
    } else {
        // Animated: Full card throw
        withAnimation(.cardMovement) {
            cardPosition = targetPosition
        }
    }
}
```

### Color Contrast

**WCAG AA Compliance:** Minimum 4.5:1 contrast ratio for text

**High Contrast Mode:**
```swift
@Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor

// Add symbols in addition to color
if differentiateWithoutColor {
    // Use suit symbols more prominently
    // Add patterns to cards
    // Increase border thickness
}
```

**Color-Blind Friendly:**
- Hearts/Diamonds: Red + filled symbols (♥♦)
- Spades/Clubs: Black + outlined symbols (♠♣)
- Never rely on color alone (always use symbols)

---

## User Flows

### Flow 1: First-Time User Journey

```
1. App Launch
   ↓
2. Main Menu (first time: brief tutorial tooltip)
   ↓
3. User taps "Tutorial"
   ↓
4. Tutorial: Card Rankings Lesson
   - Shows card hierarchy (J > 9 > A > 10 > K > Q > 8 > 7)
   - Interactive quiz
   ↓
5. Tutorial: Bidding Practice
   - Practice bidding with sample hands
   - Explains bid range and passing
   ↓
6. Tutorial: Trump Mechanics
   - Shows how trump works
   - Practice trick-taking with trump
   ↓
7. Tutorial: Complete Practice Game
   - Play full game with hints
   - AI explains each move
   ↓
8. Tutorial Complete! 🎉
   - Encouragement to play vs Easy AI
   ↓
9. Start First Real Game
```

### Flow 2: Quick Game Start

```
1. Returning User Opens App
   ↓
2. Main Menu
   ↓ (taps "Start New Game")
3. Game Setup
   - Default: Single Player, 3 Easy AI, Standard Rules
   - [User can customize or continue with defaults]
   ↓ (taps "Start Game")
4. Game Table Appears
   ↓
5. Cards Deal (animation)
   ↓
6. Bidding Phase Begins
   - User views hand
   - Places bid or passes
   ↓
7. Trump Selection (if user wins bid)
   ↓
8. Remaining Cards Dealt
   ↓
9. Trick-Taking Phase (8 tricks)
   - User plays cards
   - AI opponents play
   - Tricks won by highest trump/suit
   ↓
10. Scoring Phase
    - Score summary shown
    - Game points updated
    ↓
11. Next Round or Game Over
    - If score < ±6: Next round
    - If score = ±6: Victory/Defeat screen
```

### Flow 3: Configuration & Customization

```
1. Main Menu
   ↓ (taps "Settings")
2. Settings Screen
   ↓ (taps "Rule Configuration")
3. Rule Configuration
   - Toggle Marriage (ON/OFF)
   - Toggle Double (ON/OFF)
   - Toggle Re-Double (ON/OFF)
   - ... (11 total rules)
   ↓
4. Select Preset or Save Custom
   - Standard
   - Bangladesh Classic
   - Advanced
   - Beginner
   - Custom (save current config)
   ↓ (taps "Save" or "Done")
5. Settings Screen
   ↓ (taps "< Back")
6. Main Menu
   ↓ (starts game with new rules)
7. Game Setup
   - Shows selected rule preset
   - Can still customize
   ↓
8. Game starts with configured rules
```

---

## Prototyping & Testing

### Design Tools
**Primary:** Figma (high-fidelity mockups)  
**Secondary:** Sketch, Adobe XD (alternatives)

**Deliverables:**
- Wireframes (low-fidelity)
- High-fidelity mockups (all screens)
- Interactive prototype (user flows)
- Component library (design system)

### User Testing Plan

#### Phase 1: Concept Testing (Week 1-2)
**Goal:** Validate core UI concept

**Participants:** 5-8 users (mix of new and experienced players)

**Tasks:**
- Evaluate main menu clarity
- Understand game table layout
- Identify confusing elements

**Method:** Figma prototype + think-aloud sessions

#### Phase 2: Usability Testing (Week 3-4)
**Goal:** Test playability and ease of use

**Participants:** 10-15 users

**Tasks:**
- Complete tutorial
- Play 1 game start to finish
- Configure custom rules
- Understand scoring

**Method:** Working app prototype + observation

#### Phase 3: Accessibility Testing (Week 5)
**Goal:** Verify accessibility features

**Participants:** 3-5 users with disabilities

**Tasks:**
- Navigate with VoiceOver
- Play with Dynamic Type enabled
- Use with Reduce Motion
- Test color contrast

**Method:** Live app + assisted testing

#### Phase 4: Beta Testing (Week 6-8)
**Goal:** Catch bugs, gather feedback at scale

**Participants:** 50-100 beta testers (TestFlight)

**Tasks:**
- Play multiple games
- Try all rule configurations
- Test different devices
- Report bugs and issues

**Method:** TestFlight + feedback form

### Success Metrics

**Usability Metrics:**
- **Task Completion Rate:** > 90% for core flows
- **Time to Complete Tutorial:** < 15 minutes average
- **Time to Start First Game:** < 2 minutes from app open
- **Error Rate:** < 5% invalid moves per game

**UX Metrics:**
- **System Usability Scale (SUS):** > 70 (good)
- **Net Promoter Score (NPS):** > 30 (good)
- **User Satisfaction:** > 4.0/5.0 average

**Accessibility Metrics:**
- **VoiceOver Navigation:** 100% of screens accessible
- **WCAG Compliance:** AA level minimum
- **Reduce Motion Support:** All critical animations have alternatives

---

## Design Checklist

### Before Implementation

- [ ] All screens designed in Figma
- [ ] Component library created
- [ ] Color palette defined with light/dark modes
- [ ] Typography scale established
- [ ] Spacing system documented
- [ ] Animation specifications written
- [ ] Responsive breakpoints defined
- [ ] Accessibility requirements listed
- [ ] User flows mapped
- [ ] Interactive prototype tested

### During Implementation

- [ ] Design tokens implemented in code
- [ ] Component library coded (Shared/)
- [ ] All screens match designs
- [ ] Animations match specifications
- [ ] Responsive layouts work on all devices
- [ ] Dark mode implemented
- [ ] VoiceOver labels added
- [ ] Dynamic Type supported
- [ ] Reduce Motion respected
- [ ] Color contrast verified

### Before Launch

- [ ] Design QA pass completed
- [ ] Accessibility audit passed
- [ ] Usability testing completed
- [ ] Beta feedback incorporated
- [ ] All critical bugs fixed
- [ ] Polish pass (shadows, spacing, alignment)
- [ ] Screenshots prepared
- [ ] App preview video created
- [ ] Marketing assets ready
- [ ] Final design approval

---

**Last Updated:** November 23, 2025  
**Designer:** Coding With Amit  
**Next Review:** After user testing feedback

