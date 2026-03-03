# ⏳ memento

### Your life, counted.

A mortality ticker that lives in your Mac toolbar. See your remaining days, weeks, and life percentage — always.

**Free · macOS 13+**

---

<p align="center">
  <img src="https://img.shields.io/badge/platform-macOS%2013%2B-blueviolet?style=flat-square" />
  <img src="https://img.shields.io/badge/swift-5.9-orange?style=flat-square" />
  <img src="https://img.shields.io/badge/price-free-brightgreen?style=flat-square" />
  <img src="https://img.shields.io/badge/dependencies-0-blue?style=flat-square" />
</p>

---

## Features

### Everything at a glance

Six thoughtfully crafted components working together.

| Feature | Description |
|---|---|
| **Life Calculator** | Pure math: days remaining, weeks left, life percentage, fun units, and your precise age string. |
| **Popover View** | Click the ticker to see your age, stats, life-in-weeks grid, fun units, and quick settings. |
| **Settings** | Set birthday, country, gender, display format, and launch-at-login. 63 countries with WHO data. |
| **Rotating Status** | Four rotating display formats cycle through your menu bar — percentage, days, weeks, and custom. |
| **Life in Weeks** | Canvas-rendered 52-column grid. Every week of your life, visualized. Lived weeks filled, future weeks empty. |
| **Snarky Quotes** | Weekday-keyed commentary and existential nudges. Because nothing motivates like dark humor. |

---

## Life in Weeks

### See every week. All of them.

52 columns. One row per year. Filled = lived. Empty = ahead of you.

Each row = 1 year. Each dot = 1 week.

---

## Daily Motivation

### Snarky. Honest. Necessary.

Weekday-keyed quotes that hit different when your life is counting down. 65 unique quotes — personalized with your actual numbers.

> **Monday** — "Another Monday. That's 1 of your ~2,400 remaining. Use it or it's gone."

> **Wednesday** — "Halfway through the week. Also roughly halfway through your life. Coincidence?"

> **Friday** — "TGIF? Sure. But you only get about 2,400 of these. Make the weekend count."

---

## By the Numbers

| 63 | WHO | M/F | $0 |
|:---:|:---:|:---:|:---:|
| Countries | Data Source | Gender-specific | Price |

---

## Getting Started

### Prerequisites

- macOS 13 (Ventura) or later
- Xcode 15+

### Build & Run

```bash
# Clone the repo
git clone https://github.com/Guy-M-Builds/MortalityBar.git
cd MortalityBar

# Option 1: Open in Xcode
open MortalityBar.xcodeproj
# Hit ⌘R to build & run

# Option 2: Using xcodegen (if you need to regenerate the project)
brew install xcodegen
xcodegen generate
open MortalityBar.xcodeproj
```

The app appears in your menu bar (no dock icon). Click the hourglass to open the popover.

### First Launch

Set your birthday, country, and gender. The countdown begins immediately.

---

## Tech Stack

- **Swift 5.9+ / SwiftUI** — pure SwiftUI, no AppDelegate
- **MenuBarExtra** with `.window` style
- **Canvas** for the life-in-weeks grid (single render pass for ~4,680 squares)
- **@AppStorage** for persistence
- **SMAppService** for launch-at-login
- **Zero third-party dependencies**

---

## Project Structure

```
MortalityBar/
├── MortalityBarApp.swift        # @main, MenuBarExtra declaration
├── AppState.swift               # ObservableObject: settings + timer + status text
├── LifeExpectancyData.swift     # 63 countries, WHO/World Bank life expectancy data
├── LifeCalculator.swift         # Days/weeks/% remaining, fun units, age string
├── RotatingStatusText.swift     # Four rotating menu bar display formats
├── PopoverView.swift            # Main dropdown UI
├── LifeInWeeksGridView.swift    # Canvas-rendered 52-column grid
├── SettingsView.swift           # Birthday, country, gender, display, launch-at-login
└── Quotes.swift                 # 65 weekday-keyed + dynamic Reaper quotes
```

---

## Time is the only resource you can't get back.

Start counting. Start living.

Free forever · No account needed · macOS 13+

---

<p align="center">
  Made by <a href="https://github.com/Guy-M-Builds">Guy</a><br/>
  Life expectancy data from WHO/World Bank · Built for macOS
</p>
