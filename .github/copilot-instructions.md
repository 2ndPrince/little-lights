# LittleLights — Copilot Instructions

> **How to resume:** Read `PROGRESS.md` → pick a ready task → check `ARCHITECTURE.md` before writing any file.

These rules apply to every file in this project. Follow them strictly.

---

## Quick Reference — Key Docs

| File | When to read it |
|---|---|
| `PROGRESS.md` | **First** — current task status, what's ready to start |
| `ARCHITECTURE.md` | Before creating any new file — confirms correct layer/location |
| `GAME_DESIGN.md` | Before any UX or mechanic decision |
| `ASSET_GUIDE.md` | Before any asset path string |

---

## Project Identity

- **App name:** LittleLights
- **Type:** Mobile Bible story app with jigsaw puzzle + illustrated lesson flow
- **Target users:** Children aged 4–7
- **Platform:** iOS + Android (Flutter)
- **Core mechanic:** ONE universal jigsaw puzzle game for ALL stories. No per-story mini-games.
- **Story order:** Chronological (Creation → Adam → Noah → Moses → David → Jonah → Daniel → Samaritan → Feeding → Zacchaeus)
- **Puzzle:** 12 pieces (3×4 grid), rectangular pieces, ghost outlines, snap-to-place, no timer, no fail state

---

## Tech Stack (exact versions matter)

| Layer | Package |
|---|---|
| UI framework | Flutter 3.x |
| Game engine | flame ^1.x |
| State management | flutter_riverpod ^2.x |
| Navigation | go_router ^14.x |
| Local persistence | shared_preferences ^2.x |
| Audio | audioplayers ^6.x |
| Value equality | equatable ^2.x |

**Never suggest:** Firebase, cloud sync, in-app purchases, video players, heavy animation libraries, or accounts system.

---

## Project Tooling

| Tool | Purpose |
|---|---|
| `dart mcp-server` | **Primary** — use before coding to inspect structure, symbols, analysis |
| `flutter analyze` | Static analysis — run after every major step; fix all warnings |
| `flutter test` | Unit + widget tests — must stay green; run after every change |

---

## Agent Rules (apply to every implementation task)

### Before writing any code — use MCP first
1. **Inspect project structure via MCP** — resolve symbols, check existing patterns, read pubspec
2. **Identify the existing architecture pattern** for the area you are touching
3. **Follow the same state management approach** — Riverpod providers, not `setState` in feature screens
4. **Follow the same widget composition style** — extract private `_SubWidget` classes, keep `build()` under 50 lines
5. **Do not introduce new architecture patterns** — if unsure, match the closest existing file
6. **Search pub.dev via MCP** before adding any new package

### After each major step — gate before continuing
- Run `flutter analyze` — fix all in-scope warnings before proceeding
- Check **Flutter lifecycle issues**: no `BuildContext` use after `await` without `mounted` guard
- Check **null safety**: no `!` force-unwraps without a null guard, no `dynamic` types
- Run `flutter test` — all tests must pass before finishing

---

## Architecture Rules

### Layer boundaries — never cross these

1. **Flutter layer** handles: screens, navigation, menus, settings, reward display, lesson display, parent gate.
2. **Flame layer** handles: puzzle game loop, drag interactions, piece snap animations, in-game audio triggers.
3. **Data layer** handles: models, repositories, SharedPreferences persistence.
4. **Provider layer** (Riverpod) handles: app state, progress, settings.

### Absolute rules

- **No Riverpod inside Flame games.** Pass all data to Flame via constructor. Flame signals completion via callback only.
- **No `Navigator.push` anywhere.** All navigation uses `context.go()` or `context.push()` via go_router.
- **No business logic in UI widgets.** Widgets display state; providers/repositories own logic.
- **No game logic in Flutter screens.** Flutter screens only render and route.
- **Flame game → Flutter communication = one callback:** `void Function(GameResult result)`. Nothing else.
- **ONE puzzle game for ALL stories.** `PuzzleGame` accepts a `PuzzleContent` — never create a story-specific game class.

### Flutter ↔ Flame bridge pattern

```dart
// Always wrap Flame in BaseGameScreen — never use GameWidget directly in a route
class BaseGameScreen extends StatefulWidget {
  final FlameGame Function() gameFactory;
  final void Function(GameResult) onGameComplete;
}

// PuzzleGame is the ONLY FlameGame subclass for story gameplay
// It accepts PuzzleContent and signals via onComplete callback
PuzzleGame(content: puzzleContentRegistry[storyId]!, onComplete: callback)
```

---

## File & Folder Conventions

```
lib/
  app/routes/             → go_router config only
  app/theme/              → colors, text styles, sizes — no logic
  features/               → one folder per Flutter screen/feature
    puzzle/               → PuzzleGameScreen (universal, accepts StoryId)
    lesson/               → LessonScreen (universal, accepts StoryId)
    {story}/              → only StoryIntroScreen per story (thin wrapper)
  game/core/              → reusable Flame base classes and systems
  game/puzzle/            → THE universal puzzle game (all stories use this)
    components/           → PuzzlePieceComponent
    puzzle_game.dart
    puzzle_world.dart
    puzzle_logic.dart
    puzzle_content.dart
  data/models/            → plain Dart model classes
  data/repositories/      → persistence only (SharedPreferences)
  providers/              → Riverpod providers
  widgets/                → shared reusable Flutter widgets
  constants/
    asset_paths.dart      → all asset path strings
    puzzle_content_registry.dart → maps StoryId → PuzzleContent
```

**One class per file.** File name = snake_case of class name.

**DO NOT create story-specific game folders** (no `lib/game/noah/`, `lib/game/david/` etc.). All puzzle logic lives in `lib/game/puzzle/`.

---

## Naming Conventions

| Type | Convention | Example |
|---|---|---|
| Files | snake_case | `puzzle_game.dart` |
| Classes | PascalCase | `PuzzleGame`, `PuzzleContent` |
| Providers | camelCase + Provider suffix | `progressProvider` |
| Assets | snake_case with category prefix | `sfx_snap.mp3`, `scene_01.png` |
| SharedPreferences keys | snake_case with prefix | `progress_noah_completed` |
| Routes | parametric lowercase | `/puzzle/:storyId`, `/lesson/:storyId` |

---

## Asset Path Rules

**Flutter** loads assets with full path from project root:
```dart
Image.asset('assets/images/stories/noah/cutscene/scene_01.png')
```

**Flame** loads assets relative to `assets/images/`:
```dart
await images.load('stories/noah/cutscene/scene_01.png')
await FlameAudio.play('sfx/sfx_snap.mp3')
```

All asset paths must be declared as constants in `lib/constants/asset_paths.dart`. Never hardcode paths.

### Puzzle asset convention (per story)
- `scene_01` → puzzle image (split at runtime, no new assets needed)
- `scene_02` → lesson slide 1
- `scene_03` → lesson slide 2
- `scene_04` → lesson slide 3

---

## UX Rules (non-negotiable)

- **Minimum drag target: 150×150 logical pixels** for puzzle pieces.
- **Minimum tap target: 80×80 logical pixels** for all other interactions.
- **No punishment mechanics.** Misplaced pieces float back to origin. No fail screen. No lives.
- **No countdown timers.** Children should never feel rushed.
- **No required reading.** Lesson captions are bonus — illustrations communicate first.
- **Session length target: 30 seconds – 2 minutes.**
- **3-tap-to-game rule.** Child must reach and start a puzzle in 3 taps from home screen.

---

## Code Style

- Prefer `const` constructors everywhere possible.
- Use `final` for all fields.
- No `dynamic` types — be explicit.
- Prefer named parameters for constructors with 2+ parameters.
- Keep `build()` methods under 50 lines — extract to sub-widgets.
- No inline `TODO` comments — use the issue tracker.
- Every public class and method gets a one-line doc comment.

---

## What NOT to build (MVP)

- No account system or login
- No cloud save or backend
- No in-app purchases or monetization
- No difficulty modes (no 9-piece puzzles yet)
- No voice narration (placeholder OK, full recording = v2)
- No advanced particle systems
- No analytics or tracking
- **No story-specific Flame games** — one `PuzzleGame` handles everything

These rules apply to every file in this project. Follow them strictly.

---

## Quick Reference — Key Docs

| File | When to read it |
|---|---|
| `PROGRESS.md` | **First** — current task status, what's ready to start |
| `MVP_NOAH_SPEC.md` | Before touching any Noah screen or game code |
| `ARCHITECTURE.md` | Before creating any new file — confirms correct layer/location |
| `GAME_DESIGN.md` | Before any UX or mechanic decision |
| `ART_DIRECTION.md` | Before describing, speccing, or reviewing any visual/audio asset |
| `ASSET_GUIDE.md` | Before any asset path string |
| `ASSET_REQUIREMENTS.md` | Full asset list with file paths and technical specs |
| `MINIGAME_TEMPLATE.md` | When creating a new mini-game module |

---

## Project Identity

- **App name:** LittleLights
- **Type:** Mobile educational mini-game collection
- **Target users:** Children aged 4–7
- **Platform:** iOS + Android (Flutter)
- **MVP scope:** One vertical slice — Noah's Ark story only. Build reusably, not broadly.

---

## Tech Stack (exact versions matter)

| Layer | Package |
|---|---|
| UI framework | Flutter 3.x |
| Game engine | flame ^1.x |
| State management | flutter_riverpod ^2.x |
| Navigation | go_router ^14.x |
| Local persistence | shared_preferences ^2.x |
| Audio | audioplayers ^6.x |
| Value equality | equatable ^2.x |

**Never suggest:** Firebase, cloud sync, in-app purchases, video players, heavy animation libraries, or accounts system.

---

## Project Tooling

| Tool | Purpose |
|---|---|
| `dart mcp-server` | **Primary** — use before coding to inspect structure, symbols, analysis issues, runtime state |
| `flutter analyze` | Static analysis — run after every major step; fix all in-scope warnings before moving on |
| `flutter test` | Unit + widget tests — must stay green; run after every change |
| Widget tests | All new widgets need at least a smoke test |

**MCP config:** `.mcp.json` in project root — `dart mcp-server` (Dart SDK 3.9+).

---

## Agent Rules (apply to every implementation task)

### Before writing any code — use MCP first
1. **Inspect project structure via MCP** — resolve symbols, check existing patterns, read pubspec
2. **Identify the existing architecture pattern** for the area you are touching
3. **Follow the same state management approach** — Riverpod providers, not `setState` in feature screens
4. **Follow the same widget composition style** — extract private `_SubWidget` classes, keep `build()` under 50 lines
5. **Do not introduce new architecture patterns** — if unsure, match the closest existing file
6. **Search pub.dev via MCP** before adding any new package

### After each major step — gate before continuing
- Run analysis via MCP (or `flutter analyze`) — fix all in-scope warnings before proceeding
- Check for **Flutter lifecycle issues**: no `BuildContext` use after `await` without `mounted` guard; no `initState` async calls without `mounted` check
- Check for **async/context misuse**: `Navigator`/`go_router` calls after `await` must check `if (!mounted) return;`
- Check for **widget rebuild performance**: `const` constructors used where possible; `ConsumerWidget` only watches what it needs
- Check **null safety**: no `!` force-unwraps without a null guard, no `dynamic` types
- Run `flutter test` — all tests must pass before finishing

---

## Architecture Rules

### Layer boundaries — never cross these

1. **Flutter layer** handles: screens, navigation, menus, settings, reward display, cutscene display, parent gate.
2. **Flame layer** handles: mini-game logic, game loop, drag/drop interactions, in-game animations, in-game audio triggers.
3. **Data layer** handles: models, repositories, SharedPreferences persistence.
4. **Provider layer** (Riverpod) handles: app state, progress, settings — sits between Flutter UI and data layer.

### Absolute rules

- **No Riverpod inside Flame games.** Pass all data to Flame via constructor. Flame signals completion via callback only.
- **No `Navigator.push` anywhere.** All navigation uses `context.go()` or `context.push()` via go_router.
- **No business logic in UI widgets.** Widgets display state; providers/repositories own logic.
- **No game logic in Flutter screens.** Flutter screens only render and route.
- **Flame game → Flutter communication = one callback:** `void Function(GameResult result)`. Nothing else.

### Flutter ↔ Flame bridge pattern

```dart
// Always wrap Flame in BaseGameScreen — never use GameWidget directly in a route
class BaseGameScreen extends StatefulWidget {
  final FlameGame Function() gameFactory;
  final void Function(GameResult) onGameComplete;
}

// Inside any FlameGame subclass — signal completion like this:
void _onSuccess() {
  onComplete?.call(GameResult.success); // Flutter takes over from here
}
```

---

## File & Folder Conventions

```
lib/
  app/routes/        → go_router config only
  app/theme/         → colors, text styles, sizes — no logic
  features/          → one folder per Flutter screen/feature
  game/core/         → reusable Flame base classes and systems
  game/noah/         → Noah's Ark game module (self-contained)
  data/models/       → plain Dart model classes
  data/repositories/ → persistence only (SharedPreferences)
  providers/         → Riverpod providers
  widgets/           → shared reusable Flutter widgets
  constants/         → asset_paths.dart and other constants
```

**One class per file.** File name = snake_case of class name.

---

## Naming Conventions

| Type | Convention | Example |
|---|---|---|
| Files | snake_case | `noah_game.dart` |
| Classes | PascalCase | `NoahGame` |
| Providers | camelCase + Provider suffix | `progressProvider` |
| Assets | snake_case with category prefix | `sfx_match.mp3`, `btn_play.png` |
| SharedPreferences keys | snake_case with prefix | `progress_noah_completed` |
| Routes | lowercase with slashes | `/game/noah` |

---

## Asset Path Rules

**Flutter** loads assets with full path from project root:
```dart
AssetImage('assets/images/ui/btn_play.png')
Image.asset('assets/images/stories/noah/ui/ark.png')
```

**Flame** loads assets relative to `assets/images/` or `assets/audio/`:
```dart
await images.load('stories/noah/ui/ark.png')         // resolves to assets/images/stories/noah/ui/ark.png
await FlameAudio.play('sfx/sfx_match.mp3')           // resolves to assets/audio/sfx/sfx_match.mp3
```

All asset paths must be declared as constants in `lib/constants/asset_paths.dart`. Never hardcode paths in widgets or game classes.

---

## UX Rules (non-negotiable)

- **Minimum tap target size: 80×80 logical pixels.** No exceptions.
- **No punishment mechanics.** Wrong answers get gentle feedback + item returns. No fail screens. No lives lost.
- **No countdown timers.** Children should never feel rushed.
- **No required reading.** All instructions must be communicable via visuals alone.
- **Session length target: 30 seconds – 2 minutes.** If a game takes longer, simplify it.
- **3-tap-to-game rule.** Child must be able to reach and start a mini-game in 3 taps from the home screen.

---

## Code Style

- Prefer `const` constructors everywhere possible.
- Use `final` for all fields.
- No `dynamic` types — be explicit.
- Prefer named parameters for constructors with 2+ parameters.
- Keep `build()` methods under 50 lines — extract to sub-widgets.
- No inline `TODO` comments — use the issue tracker.
- Every public class and method gets a one-line doc comment.

---

## What NOT to build (MVP)

- No account system or login
- No cloud save or backend
- No in-app purchases or monetization
- No difficulty modes
- No voice narration (placeholder OK, full recording = v2)
- No advanced particle systems
- No procedural content
- No analytics or tracking

---

## Reusability First

Every system built for Noah must be reusable for future stories (David, Jonah, Adam):
- `BaseGameScreen` — wraps any Flame game
- `StoryIntroScreen` — reusable intro template
- `CutscenePlayer` — plays any PNG sequence
- `RewardScreen` — shows any star/badge combo
- `ProgressRepository` — saves any story's progress

When adding Noah-specific code, ask: "Could this accept a parameter instead of being hardcoded to Noah?" If yes, make it generic.
