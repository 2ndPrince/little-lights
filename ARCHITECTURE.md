# LittleLights — Architecture Document

## Layer Overview

```
┌─────────────────────────────────────────────────────────┐
│                    Flutter UI Layer                       │
│  HomeScreen · StorySelectScreen · StoryIntroScreen        │
│  CutsceneScreen · RewardScreen · SettingsScreen           │
│  ParentGateSheet                                          │
└───────────────────────┬─────────────────────────────────┘
                        │ go_router navigation
                        │ Riverpod watch/read
┌───────────────────────▼─────────────────────────────────┐
│                   Provider Layer (Riverpod)               │
│  progressProvider · settingsProvider · audioProvider      │
│  currentStoryProvider                                     │
└──────────┬────────────────────────┬─────────────────────┘
           │ reads/writes           │ provides AudioService
┌──────────▼──────────┐   ┌────────▼────────────────────┐
│    Data Layer        │   │     Game Layer (Flame)        │
│  models/             │   │  game/core/base/              │
│  repositories/local/ │   │  game/noah/                   │
│  data/shared/        │   │  (future: david/ jonah/ adam/)│
│  SharedPreferences   │   │  ← constructor-injected data  │
└─────────────────────┘   │  → completion callback only   │
                           └────────────────────────────────┘
```

**Rules:**
- Flutter UI never imports from `game/` except `BaseGameScreen`
- Flame games never import from `providers/` or `features/`
- Data layer is pure Dart — no Flutter, no Flame imports

---

## Navigation (go_router)

### Route Map
```
/                         → HomeScreen
/stories                  → StorySelectionScreen
/stories/noah/intro       → StoryIntroScreen (noah)
/stories/noah/game        → BaseGameScreen (wraps NoahGame)
/stories/noah/cutscene    → CutsceneScreen (noah)
/stories/noah/reward      → RewardScreen (noah)
/settings                 → SettingsScreen
/parent                   → ParentSectionScreen (behind ParentGate)
```

### Route Parameter Convention
Story-specific routes use `storyId` as a path segment, not a query param.
All route paths are declared as constants in `lib/app/routes/app_router.dart`.

### Navigation Rules
- Use `context.go('/stories')` for replacing the stack (back button safe)
- Use `context.push('/stories/noah/game')` when back navigation should return to intro
- Never use `Navigator.of(context).push()` — always go_router
- Game completion does NOT navigate from inside Flame — it fires `onGameComplete(GameResult)` callback, and the Flutter widget navigates

---

## Flutter ↔ Flame Bridge

### BaseGameScreen
The single integration point between Flutter and Flame.

```dart
/// Wraps a Flame game in a Flutter screen with lifecycle management.
class BaseGameScreen extends StatefulWidget {
  /// Factory function so the game is created fresh on each mount.
  final FlameGame Function() gameFactory;

  /// Called when the game signals completion. Flutter handles routing.
  final void Function(GameResult result) onGameComplete;

  const BaseGameScreen({
    required this.gameFactory,
    required this.onGameComplete,
    super.key,
  });
}
```

### Data flow into Flame
Pass all required data to the game via its constructor. Never read providers inside Flame.

```dart
// In app_router.dart
GoRoute(
  path: '/stories/noah/game',
  builder: (context, state) => BaseGameScreen(
    gameFactory: () => NoahGame(
      pairs: NoahContent.animalPairs,       // data injected here
      onComplete: (result) { ... },
    ),
    onGameComplete: (result) {
      if (result == GameResult.success) {
        context.go('/stories/noah/cutscene');
      }
    },
  ),
),
```

### GameResult enum
```dart
enum GameResult { success, retry }
```

Only `success` triggers forward navigation. `retry` resets the game in-place.

---

## State Management (Riverpod)

### Provider Registry

| Provider | Class | State Type | Responsibility |
|---|---|---|---|
| `progressProvider` | `ProgressNotifier` | `Map<StoryId, StoryProgress>` | Completion, stars, unlock logic |
| `settingsProvider` | `SettingsNotifier` | `AppSettings` | Sound on/off, future: language |
| `audioProvider` | `Provider<AudioService>` | singleton | BGM/SFX playback |
| `currentStoryProvider` | `StateProvider<StoryId?>` | `StoryId?` | Which story is active |

### Progress State Rules
- `StoryId.noah` is always unlocked by default
- `StoryId.david` unlocks when `noah` is completed
- `StoryId.jonah` unlocks when `david` is completed
- `StoryId.adam` unlocks when `jonah` is completed
- Unlock logic lives in `ProgressNotifier`, not in UI

### Provider initialization
```dart
// main.dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: const LittleLightsApp(),
    ),
  );
}
```

---

## Data Layer

### Models

```dart
// data/models/story.dart
enum StoryId { noah, david, jonah, adam }

class Story extends Equatable {
  final StoryId id;
  final String titleFallback;   // English; replaced by i18n key in v2
  final String thumbnailPath;   // asset path constant
  final String bgmPath;         // asset path constant
  final StoryTheme theme;
}

// data/models/story_progress.dart
class StoryProgress extends Equatable {
  final StoryId storyId;
  final bool isUnlocked;
  final bool isCompleted;
  final int starsEarned;        // MVP: always 1 on completion
}

// data/models/reward.dart
class Reward extends Equatable {
  final StoryId storyId;
  final int stars;
  final String badgeId;
  final String badgeName;
  final String badgeIconPath;
}
```

### Repository

```dart
abstract class IProgressRepository {
  Future<StoryProgress?> loadProgress(StoryId storyId);
  Future<void> saveProgress(StoryProgress progress);
  Future<void> resetAll();
  Future<bool> getSoundEnabled();
  Future<void> setSoundEnabled(bool value);
}
```

Implementation uses `SharedPreferences`.

### SharedPreferences Key Schema
```
progress_noah_completed       → bool  (default: false)
progress_noah_stars           → int   (default: 0)
progress_david_completed      → bool  (default: false)
progress_david_stars          → int   (default: 0)
progress_jonah_completed      → bool  (default: false)
progress_jonah_stars          → int   (default: 0)
progress_adam_completed       → bool  (default: false)
progress_adam_stars           → int   (default: 0)
settings_sound_enabled        → bool  (default: true)
```

Keys are declared as constants in `ProgressRepository`. Never hardcode key strings elsewhere.

---

## Audio Architecture

### AudioService (singleton via `audioProvider`)

```dart
class AudioService {
  /// Starts looping background music. Silently swaps if already playing.
  Future<void> playBgm(String assetPath);

  /// Stops BGM with optional fade.
  Future<void> stopBgm({bool fade = true});

  /// Fires a one-shot sound effect.
  Future<void> playSfx(String assetPath);

  /// Toggles all audio based on settings.
  void setEnabled(bool enabled);
}
```

### Rules
- BGM continues playing across screen transitions; only changes when entering a story
- SFX never block BGM
- AudioService is created once in `ProviderScope` and disposed on app exit
- Flame games use `AudioService` passed via constructor — never call `FlameAudio` directly

---

## Asset Loading — Critical Distinction

| Context | Method | Path format |
|---|---|---|
| Flutter widget | `Image.asset(path)` | `'assets/images/stories/noah/ui/ark.png'` |
| Flutter widget | `AssetImage(path)` | `'assets/images/stories/noah/ui/ark.png'` |
| Flame component | `await images.load(path)` | `'stories/noah/ui/ark.png'` ← relative to `assets/images/` |
| Flame audio | `FlameAudio.play(path)` | `'sfx/sfx_match.mp3'` ← relative to `assets/audio/` |

All paths declared in `lib/constants/asset_paths.dart`:

```dart
class AssetPaths {
  // Flutter (full path)
  static const String btnPlay       = 'assets/images/ui/btn_play.png';
  static const String noahArk       = 'assets/images/stories/noah/ui/ark.png';

  // Flame (relative path)
  static const String flameNoahArk  = 'stories/noah/ui/ark.png';
  static const String sfxMatch      = 'sfx/sfx_match.mp3';
}
```

---

## Game Module Structure (per story)

Each story's game is a self-contained module:

```
game/noah/
  noah_game.dart          ← FlameGame subclass; entry point
  noah_world.dart         ← World, component layout, game setup
  components/
    animal_card.dart      ← DragCallbacks, pair ID, sprite
    ark_drop_zone.dart    ← DropTarget, match detection
    noah_character.dart   ← Idle/happy sprite animation
  models/
    animal_pair.dart      ← Pure data: {id, pairId, assetPath}
  logic/
    matching_logic.dart   ← Pure functions: isMatch(), allPairsLoaded()
  overlays/
    noah_intro_overlay.dart ← "Help Noah bring the animals" UI
```

**Self-containment rule:** `game/noah/` only imports from `game/core/`. It never imports from `features/`, `providers/`, or other game modules.

---

## Reusable Game Systems (game/core/)

| System | File | Purpose |
|---|---|---|
| Bridge | `base/base_game_screen.dart` | Flutter widget hosting any FlameGame |
| Result | `base/game_result.dart` | Enum: success / retry |
| Drag | `components/draggable_component.dart` | Reusable DragCallbacks mixin |
| Audio | `systems/audio_manager.dart` | In-game audio wrapper (receives AudioService) |
| HUD | `overlays/game_hud_overlay.dart` | Optional sound button overlay |

---

## CutscenePlayer

Reusable Flutter widget — not Flame.

```dart
class CutscenePlayer extends StatefulWidget {
  final List<String> framePaths;   // asset paths (Flutter format)
  final Duration frameDuration;    // default: 1500ms
  final VoidCallback onComplete;   // called on last frame or tap-to-skip
}
```

Used in `CutsceneScreen`. Frame list comes from story content registry.

---

## Testing Strategy

| Layer | Tool | What to test |
|---|---|---|
| Data models | `flutter test` | Equality, serialization |
| Repository | `flutter test` + mock SharedPreferences | save/load/reset/defaults |
| Providers | `flutter test` + ProviderContainer | state transitions, unlock logic |
| Widgets | `flutter test` + WidgetTester | render states, navigation triggers |
| Flame games | Manual / device | Drag interaction, visual feedback |

Flame game logic (matching, completion detection) should be extracted to pure Dart functions in `logic/` files and tested without Flame.
