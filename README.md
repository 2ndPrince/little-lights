# LittleLights 🌟

> Bible story mini-games for young children — ages 4–7.

A warm, encouraging mobile app where children experience Bible stories through simple mini-games and short animated story scenes.

---

## What is LittleLights?

LittleLights is a Flutter + Flame educational mini-game collection for young children. Each story pairs a simple, age-appropriate mini-game with a short animated story reveal and a gentle reward system.

**Design values:** No punishment. No timers. No pressure. Only success and encouragement.

---

## MVP — Noah's Ark

The first vertical slice focuses entirely on one story: **Noah's Ark**.

### Experience flow
```
Home → Story Select → Noah Intro → Mini-game → Cutscene → Reward → (repeat)
```

### Mini-game: Animal Matching
- 6 animal cards (3 pairs: lion, elephant, giraffe)
- Tap to select, tap matching animal to pair them
- Matched pair floats into the ark
- All 3 pairs loaded = success

---

## Tech Stack

| Layer | Technology |
|---|---|
| UI Framework | Flutter 3.x |
| Game Engine | Flame 1.x |
| State Management | Riverpod 2.x |
| Navigation | go_router 14.x |
| Local Save | SharedPreferences |
| Audio | audioplayers 6.x |

---

## Project Structure

```
lib/
  app/routes/        → go_router navigation
  app/theme/         → colors, text styles, sizes
  features/          → Flutter screens (home, stories, rewards, settings)
  game/core/         → reusable Flame base classes
  game/noah/         → Noah's Ark mini-game module
  data/models/       → plain Dart data models
  data/repositories/ → SharedPreferences persistence
  providers/         → Riverpod state management
  widgets/           → shared reusable widgets
  constants/         → asset path constants

assets/
  images/stories/noah/   → Noah game art + cutscene frames
  images/ui/             → app-wide UI elements
  audio/music/           → background music
  audio/sfx/             → sound effects
```

---

## Key Documents

| File | Purpose |
|---|---|
| [`PROGRESS.md`](PROGRESS.md) | Current build status + ready tasks |
| [`MVP_NOAH_SPEC.md`](MVP_NOAH_SPEC.md) | Complete Noah vertical slice specification |
| [`ARCHITECTURE.md`](ARCHITECTURE.md) | Layer boundaries, bridge pattern, data models |
| [`GAME_DESIGN.md`](GAME_DESIGN.md) | UX philosophy, game loop, visual/audio direction |
| [`ASSET_GUIDE.md`](ASSET_GUIDE.md) | Asset naming conventions, Flutter vs Flame paths |
| [`MINIGAME_TEMPLATE.md`](MINIGAME_TEMPLATE.md) | Step-by-step template for adding new mini-games |

---

## Architecture — Flutter ↔ Flame Bridge

```
Flutter UI Layer          Flame Game Layer
─────────────────         ─────────────────────
HomeScreen                NoahGame (FlameGame)
StorySelectScreen  ──►    AnimalCard (DragCallbacks)
CutsceneScreen            ArkDropZone
RewardScreen       ◄──    onComplete(GameResult.success)
```

**Rules:**
- Flutter handles all navigation, menus, and state display
- Flame handles all game logic and interactions
- Flame communicates to Flutter via a single callback only
- No Riverpod inside Flame games — data injected via constructor

---

## Version Roadmap

| Version | Scope |
|---|---|
| **v1 (MVP)** | Noah's Ark — full vertical slice |
| **v2** | David + Jonah + Adam, voice narration, EN/KR |
| **v3** | Character collection, sticker book, memory verses |

---

## Getting Started

```bash
# Install dependencies
flutter pub get

# Run on device or simulator
flutter run

# Run tests
flutter test
```

> **Note:** Placeholder assets are used during development. Real art will be dropped in at the polish phase. See [`ASSET_GUIDE.md`](ASSET_GUIDE.md) for the placeholder strategy.

---

## UX Rules (non-negotiable)

- Minimum tap target: **80×80 logical pixels**
- **No countdown timers** — children should never feel rushed
- **No fail screens** — wrong answers bounce back gently
- **No required reading** — visual guidance only
- Max **3 taps to start a game** from home screen
- Session length: **30 seconds – 2 minutes**
