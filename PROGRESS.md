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

## Current Phase: Phase 0 Complete → Phase 1 Starting

### ✅ Phase 0 — Foundation (DONE)
- [x] Project folder structure created (`lib/`, `assets/`, `test/`)
- [x] `.github/copilot-instructions.md`
- [x] `GAME_DESIGN.md`
- [x] `ARCHITECTURE.md`
- [x] `ASSET_GUIDE.md`
- [x] `MINIGAME_TEMPLATE.md`
- [x] `MVP_NOAH_SPEC.md`

---

## Phase 1 — Parallel Implementation Tracks

### 🟢 Ready to start NOW (no dependencies)

These 4 tasks have zero dependencies and can be worked in parallel by separate agents:

#### `t1-pubspec` — Create pubspec.yaml
```
flutter create little_lights (or add pubspec manually)
Dependencies: flame, flutter_riverpod, go_router,
              shared_preferences, audioplayers, equatable
Dev: flutter_test, flutter_lints
```

#### `t2-game-result` — GameResult enum
```
File: lib/game/core/base/game_result.dart
enum GameResult { success, retry }
One class, one file, no imports needed.
```

#### `t3-animal-pair-model` — AnimalPair data model
```
File: lib/game/noah/models/animal_pair.dart
       lib/game/noah/models/noah_content.dart
AnimalPair: { id, pairId, assetPath (Flame relative), displayName }
NoahContent.animalPairs: 3 pairs — lion, elephant, giraffe
Pure Dart. No Flutter, no Flame imports.
```

#### `t4-models` — Core data models
```
lib/data/models/story.dart         → enum StoryId + Story class
lib/data/models/story_progress.dart → StoryProgress class
lib/data/models/reward.dart        → Reward class
All extend Equatable. See ARCHITECTURE.md for field specs.
```

---

### 🔵 Track 1 — App Shell (starts after t1-pubspec)

| Task ID | Title | Depends on |
|---|---|---|
| `t1-pubspec` | Create pubspec.yaml | — |
| `t1-theme` | App theme (colors, styles, sizes) | t1-pubspec |
| `t1-router` | go_router all routes stubbed | t1-pubspec |
| `t1-home` | HomeScreen | t1-theme, t1-router |
| `t1-story-select` | StorySelectionScreen + StoryCard | t1-home |
| `t1-intro` | StoryIntroScreen (reusable) | t1-theme |
| `t1-cutscene` | CutsceneScreen + CutscenePlayer | t1-theme |
| `t1-reward` | RewardScreen + celebration | t1-theme |
| `t1-settings` | SettingsScreen | t1-theme |
| `t1-parent-gate` | ParentGateSheet | t1-theme |

### 🔵 Track 2 — Game Engine Foundation (starts after t2-game-result)

| Task ID | Title | Depends on |
|---|---|---|
| `t2-game-result` | GameResult enum | — |
| `t2-base-game-screen` | BaseGameScreen Flutter↔Flame bridge | t2-game-result |
| `t2-audio-service` | AudioService + AudioManager | t2-game-result |
| `t2-draggable-component` | DraggableComponent base mixin | t2-game-result |

### 🔵 Track 3 — Noah Gameplay (starts after t3-animal-pair-model + t2-draggable-component)

| Task ID | Title | Depends on |
|---|---|---|
| `t3-animal-pair-model` | AnimalPair model + Noah content | — |
| `t3-matching-logic` | MatchingLogic pure functions | t3-animal-pair-model |
| `t3-animal-card` | AnimalCard Flame component | t2-draggable-component, t3-animal-pair-model |
| `t3-ark-drop-zone` | ArkDropZone Flame component | t3-animal-pair-model |
| `t3-noah-game` | NoahGame FlameGame state machine | t2-base-game-screen, t3-matching-logic |
| `t3-noah-world` | NoahWorld layout | t3-animal-card, t3-ark-drop-zone, t3-noah-game |
| `t3-noah-intro-overlay` | Noah intro overlay | t3-noah-game |

### 🔵 Track 4 — Save + Reward (starts after t4-models)

| Task ID | Title | Depends on |
|---|---|---|
| `t4-models` | Story, StoryProgress, Reward models | — |
| `t4-stories-registry` | stories_registry.dart (4 stories) | t4-models |
| `t4-repository` | ProgressRepository (SharedPreferences) | t4-models |
| `t4-providers` | Riverpod providers | t4-repository, t4-stories-registry |

### 🔵 Track 5 — Assets (starts after t1-pubspec)

| Task ID | Title | Depends on |
|---|---|---|
| `t5-pubspec-assets` | Asset dirs in pubspec.yaml | t1-pubspec |
| `t5-placeholder-images` | Colored rect placeholder PNGs | t5-pubspec-assets |
| `t5-placeholder-audio` | Silent MP3 placeholders | t5-pubspec-assets |
| `t5-asset-paths` | lib/constants/asset_paths.dart | t5-pubspec-assets |

### 🔵 Track 6 — Testing (starts after t4-models)

| Task ID | Title | Depends on |
|---|---|---|
| `t6-helpers` | MockProgressRepository + test providers | t4-models |
| `t6-matching-logic-test` | Unit test matching_logic.dart | t3-matching-logic |
| `t6-repository-test` | Unit test progress_repository.dart | t4-repository, t6-helpers |
| `t6-provider-test` | Unit test progress_provider | t4-providers, t6-helpers |
| `t6-widget-tests` | Widget tests StoryCard + RewardScreen | t1-reward, t1-story-select, t6-helpers |

### 🏁 Integration Milestone

| Task ID | Title | Depends on |
|---|---|---|
| `int-e2e-noah` | Full Noah E2E flow on device | All tracks complete |
| `int-audio` | Audio integration | int-e2e-noah, t2-audio-service |
| `int-device-qa` | Device QA + touch audit | int-audio, t6-widget-tests |

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
