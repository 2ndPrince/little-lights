# LittleLights — Progress & Session Handoff

> **Resume instructions:** Open this project in your IDE. GitHub Copilot will automatically load `.github/copilot-instructions.md`. Read this file first, then resume from the **Next Steps** section below.

---

## Key Documents (read before coding)

| File | What it contains |
|---|---|
| `.github/copilot-instructions.md` | All coding rules, architecture laws, naming conventions, MCP workflow |
| `ARCHITECTURE.md` | Layer diagram, bridge pattern, routes, data models, asset path rules |
| `GAME_DESIGN.md` | UX philosophy, Noah game spec, visual/audio direction |
| `ASSET_GUIDE.md` | Asset naming, Flutter vs Flame path distinction, placeholder strategy |
| `MINIGAME_TEMPLATE.md` | Step-by-step template for any new mini-game |
| `MVP_NOAH_SPEC.md` | Complete Noah vertical slice spec + Definition of Done |

---

## Tooling

- `dart mcp-server` configured in `.mcp.json` — use before coding to inspect structure, symbols, analysis
- `flutter analyze` — currently **0 issues**
- `flutter test` — currently **32/32 passing**
- GitHub: https://github.com/2ndPrince/little-lights (latest commit on `main`)

---

## ✅ MVP Complete — Verified 2026-03-13

All 44 Noah MVP todos are done. The following was **verified by reading source code** — not inferred from prior notes.

### MVP Definition of Done — Audited Status

| Check | Status | Evidence |
|---|---|---|
| App launches to HomeScreen | ✅ | `main.dart` → `ProviderScope` → `appRouter` initialLocation `/` → `HomeScreen` |
| Child reaches game in **3 taps** | ✅ | Tap 1: `_PlayButton` → `/stories`; Tap 2: `StoryCard.onTap` → `/stories/noah/intro`; Tap 3: `_LetsGoButton` → `/stories/noah/game` |
| All 3 animal pairs matchable | ✅ | `NoahContent.animalPairs` has 6 cards; `NoahGame._handleCardTap` drives state machine |
| Correct match gives positive feedback | ✅ | `AnimalCard.triggerMatchFeedback()` — scale bounce + green colour |
| Wrong match gives gentle feedback | ✅ | `AnimalCard.triggerWrongFeedback()` — shrink pulse; card returns to default, no penalty |
| All pairs loaded → completion | ✅ | `MatchingLogic.allPairsLoaded` → `_onAllPairsLoaded` → 1500ms delay → `onComplete.call(GameResult.success)` |
| Cutscene plays (4 frames, tap-to-skip) | ✅ | `CutsceneScreen` — 600ms/frame Timer, `onTap → _navigate()`, `mounted` guard present |
| Reward screen with star + badge animation | ✅ | `RewardScreen` — `CurvedAnimation(elasticOut)` for stars, `Tween<Offset>` slide for badge |
| Progress saved on completion | ✅ | `NoahGameScreen` (ConsumerWidget) calls `progressProvider.notifier.markComplete(StoryId.noah, stars: 1)` → `ProgressRepository.saveProgress` → SharedPreferences |
| Progress persists after app restart | ✅ | `main.dart` awaits `SharedPreferences.getInstance()` before `runApp`; `ProgressNotifier._loadAll()` reads on `build()` |
| David card unlocks after Noah | ✅ | `ProgressNotifier._applyUnlockRules()` iterates `StoryId.values` linearly; unlocks `david` when `noah.isCompleted == true` |
| Sound toggle works | ✅ | `SettingsScreen` → `settingsProvider.notifier.setSoundEnabled(bool)` → writes SharedPreferences + calls `audioProvider.setEnabled(bool)` |
| Sound setting persists after restart | ✅ | `SettingsNotifier.build()` reads `SharedPreferences.getBool(_keySoundEnabled)` synchronously at startup |
| Layout fits 375pt screen | ✅ | Card grid: 3×100px + 2×20px gap = 340px; startX=17.5pt. Ark zone: 280px centered. All tap targets ≥ 80×80. |
| `flutter analyze` clean | ✅ | 0 issues (3 pre-existing deprecations fixed 2026-03-13) |
| All tests pass | ✅ | 32/32: 9 matching logic, 8 repository, 8 provider, 7 widget |

---

## Known Gaps (not blockers, document before Wave 5)

| Gap | Location | Impact |
|---|---|---|
| **Tap-to-select, not drag-and-drop** | `NoahGame`, `AnimalCard` | Spec says drag; impl uses tap-to-match. `DraggableComponent` mixin exists but is unused. Simpler UX — acceptable for MVP. |
| **`onGameComplete` on `BaseGameScreen` is unused** | `base_game_screen.dart:14` | The actual completion signal goes `NoahGame.onComplete → NoahGameScreen closure`. The `onGameComplete` field is a required no-op. Refactor in Wave 5 or remove the field. |
| **`NoahGameState.intro` is defined but never set** | `noah_game.dart` | State jumps `idle → playing` skipping `intro`. Field reserved for future use — harmless. |
| **`StorySelectionScreen._routeFor` returns `noahIntro` for all non-Noah stories** | `story_selection_screen.dart:25` | If David/Jonah/Adam were unlocked, tapping them would navigate to Noah's intro. Safe for MVP (those stories are locked), but must be fixed in Wave 5. |
| **`/parent` route is a `_StubScreen`** | `app_router.dart` | Parent gate navigates to a placeholder. Functional parent gate sheet exists but the dedicated parent section screen is not built. |
| **Placeholder assets throughout** | `assets/images/`, `assets/audio/` | All 26 PNGs are 1×1 coloured squares. All 9 MP3s are silent 426-byte files. Game renders with coloured rectangles + text labels. Needs real art for production. |
| **No end-to-end integration test** | `test/` | Only unit + widget tests exist. No automated test that walks the full Home→Game→Reward flow. |

---

## Next Steps — Wave 5: David and Goliath

7 todos are queued in the SQL database (`w5-models` through `w5-tests`). David validates that the reusable framework works for a second story.

**Implementation order (dependency-safe):**
1. `w5-models` + `w5-assets` — parallel (no deps)
2. `w5-logic` + `w5-flame` — after models
3. `w5-overlay` + `w5-screens` — after flame
4. `w5-tests` — last

**Game concept:** Child taps 3 stones to collect them from the riverbank. After all 3 collected, David throws and Goliath falls. No drag required — tap mechanic only (same simplicity as Noah). Theme: courage.

**Key reuse points (verify these work for David):**
- `BaseGameScreen` — wraps any Flame game ✅
- `StoryIntroScreen` — accepts any title/illustration/route ✅
- `CutsceneScreen` — accepts any frame list ✅
- `RewardScreen` — accepts any badge/stars/routes ✅
- `ProgressRepository` — already stores david progress ✅
- `progressProvider._applyUnlockRules` — already unlocks david after noah ✅

---

## Version Roadmap

| Version | Scope | Status |
|---|---|---|
| **v1.0** | Noah's Ark | ✅ Complete |
| **v1.1** | David & Goliath | ✅ Complete |
| **v1.2** | Jonah + Adam & Eve + TestFlight | ✅ Live (build 2, Mar 2026) |
| **v1.3** | Moses, Daniel, Good Samaritan | 🔜 Wave 6 |
| **v1.4** | Zacchaeus, Feeding 5,000, Creation | 🔜 Wave 6 |
| **v2** | Voice narration (EN/KR) + parent progress screen | Backlog |
| **v3** | Character collection, sticker book, memory verses | Backlog |

---

## 🔜 Wave 6 — 6 New Stories

### Story designs (see plan.md for full details)

| # | Story | Mechanic | New technique |
|---|---|---|---|
| 5 | Moses & the Red Sea | Swipe water walls apart | First **swipe gesture** in app |
| 6 | Daniel & the Lions | Tap each lion to feed it | Tap + state change (growl → calm) |
| 7 | Good Samaritan | Drag 3 items onto wounded man | Multi-item positional drag |
| 8 | Zacchaeus | Tap branches top→bottom in order | **Sequential ordered** tap |
| 9 | Feeding the 5,000 | Drag loaves & fish into baskets | Drag with fill/overflow animation |
| 10 | Creation | Tap element → place in day slot | Sorting/matching sequence |

### Implementation notes
- Extend `StoryId` enum: `moses`, `daniel`, `samaritan`, `zacchaeus`, `feeding`, `creation`
- Add 4 routes per story to `app_router.dart` (24 new routes total)
- Add constants to `asset_paths.dart`
- All screens reuse `BaseGameScreen`, `StoryIntroScreen`, `CutsceneScreen`, `RewardScreen`
- Total new assets: ~60 images (generate with Gemini AI)
- Moses swipe mechanic needs a new `DragComponent` or gesture detector in Flame

---
