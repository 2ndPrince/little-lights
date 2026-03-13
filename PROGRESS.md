# LittleLights — Progress & Session Handoff

> **Resume instructions:** Open this project in your IDE. GitHub Copilot will automatically load `.github/copilot-instructions.md`. Read this file + `MVP_NOAH_SPEC.md` first, then pick a task from the "Ready to start" section below.

---

## Key Documents (read before coding)

| File | What it contains |
|---|---|
| `.github/copilot-instructions.md` | All coding rules, architecture laws, naming conventions |
| `ARCHITECTURE.md` | Layer diagram, bridge pattern, routes, data models, asset path rules |
| `GAME_DESIGN.md` | UX philosophy, Noah game spec, visual/audio direction |
| `ASSET_GUIDE.md` | Asset naming, Flutter vs Flame path distinction, placeholder strategy |
| `MINIGAME_TEMPLATE.md` | Step-by-step template for any new mini-game |
| `MVP_NOAH_SPEC.md` | **Start here** — complete Noah vertical slice spec + Definition of Done |

---

## Current Phase: Wave 3 Complete → Integration Sprint

### ✅ Phase 0 — Foundation (DONE)
- [x] Project folder structure + all 6 doc files

### ✅ Wave 1 — Core models & pubspec (DONE)
- [x] `pubspec.yaml` — all 6 deps, 7 asset dirs
- [x] `GameResult`, `AnimalPair`, `NoahContent`

### ✅ Wave 2 — Data layer + game engine core (DONE)
- [x] App theme (AppColors, AppSizes, AppTextStyles, AppTheme)
- [x] `go_router` — 8 routes with AppRoutes constants
- [x] `main.dart` — async bootstrap with SharedPreferences + ProviderScope
- [x] `BaseGameScreen` — Flutter↔Flame bridge
- [x] `AudioService` + `AudioManager` + `audioProvider`
- [x] `DraggableComponent` mixin
- [x] `MatchingLogic`, `ArkDropZone`
- [x] `ProgressRepository` + `progressProvider` + `sharedPreferencesProvider`
- [x] `stories_registry.dart`, `asset_paths.dart`
- [x] Test helpers (`MockProgressRepository`, `makeTestContainer`)

### ✅ Wave 3 — Flutter screens + Noah game + assets (DONE)
- [x] `HomeScreen` — Play button, gear icon, BGM on load
- [x] `StorySelectionScreen` + `StoryCard` (locked/unlocked/completed)
- [x] `StoryIntroScreen` (reusable) + `NoahStoryIntroScreen`
- [x] `CutsceneScreen` — frame sequence, tap-to-skip, Timer dispose
- [x] `RewardScreen` — ScaleTransition star + SlideTransition badge
- [x] `SettingsScreen` — sound toggle
- [x] `ParentGateSheet` — 2-second hold-to-unlock, reset progress
- [x] `AnimalCard` — tap-to-select, shake/bounce feedback
- [x] `NoahGame` — full state machine
- [x] `NoahWorld` — 6-card grid + ArkDropZone layout
- [x] 26 placeholder PNGs + 9 silent audio files + font
- [x] 17 unit tests passing (matching logic + repository)
- [x] `.gitignore` added

---

## Phase 1 — Parallel Implementation Tracks

### 🟠 Wave 4 — Integration Sprint (NEXT)

All source files exist. Now wire them together and run on a device.

| Task ID | Title | Status |
|---|---|---|
| `t3-noah-intro-overlay` | Noah intro Flame overlay (pre-game) | **Ready** |
| `t6-provider-test` | Unit tests for `progressProvider` | **Ready** |
| `t6-widget-tests` | Widget tests: StoryCard + RewardScreen | **Ready** |
| `int-e2e-noah` | Full Noah E2E: Home→Game→Cutscene→Reward | Needs above |
| `int-audio` | Verify BGM/SFX on device | Needs int-e2e-noah |
| `int-device-qa` | Manual touch-target + child-UX QA | Needs int-audio |

#### Critical wiring needed for `int-e2e-noah`
`NoahGameScreen` stub exists in router (`/game/noah`) but is not yet wired to `NoahGame` via `BaseGameScreen`.
This is the last seam before a runnable app:
```dart
// lib/features/noah/noah_game_screen.dart
class NoahGameScreen extends StatelessWidget {
  Widget build(BuildContext context) => BaseGameScreen(
    gameFactory: () => NoahGame(onComplete: (result) {
      if (result == GameResult.success) context.go(AppRoutes.cutscene, extra: CutsceneArgs(...));
    }),
  );
}
```

---

## MVP Definition of Done

From `MVP_NOAH_SPEC.md`:
- [ ] App launches to HomeScreen
- [ ] Child reaches game in 3 taps
- [ ] All 3 animal pairs matchable and loadable
- [ ] Cutscene plays (4 frames, auto-advance)
- [ ] Star + badge reward screen
- [ ] Progress saved to SharedPreferences
- [ ] Completion persists across app restart
- [ ] David card unlocked after Noah completion
- [ ] Sound toggle works and persists
- [ ] Tested on 375pt screen

---

## Version Roadmap

| Version | Scope |
|---|---|
| **MVP (v1)** | Noah vertical slice — this file |
| **v2** | David + Jonah + Adam stories, voice narration, EN/KR |
| **v3** | Character collection, sticker book, memory verses |

---

*Last updated: 2026-03-13. Update this file when tasks are completed.*
