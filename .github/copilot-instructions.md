# LittleLights — Copilot Instructions

> **Copilot CLI version:** 0.0.420 | **Model:** Claude Sonnet 4.6
> **How to resume:** Read `PROGRESS.md` → pick a ready task → check `ARCHITECTURE.md` before writing any file.

These rules apply to every file in this project. Follow them strictly.

---

## Quick Reference — Key Docs

| File | When to read it |
|---|---|
| `PROGRESS.md` | **First** — current task status, what's ready to start |
| `MVP_NOAH_SPEC.md` | Before touching any Noah screen or game code |
| `ARCHITECTURE.md` | Before creating any new file — confirms correct layer/location |
| `GAME_DESIGN.md` | Before any UX or mechanic decision |
| `ASSET_GUIDE.md` | Before any asset path string |
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
| Navigation | go_router ^13.x |
| Local persistence | shared_preferences ^2.x |
| Audio | audioplayers ^6.x |
| Value equality | equatable ^2.x |

**Never suggest:** Firebase, cloud sync, in-app purchases, video players, heavy animation libraries, or accounts system.

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
