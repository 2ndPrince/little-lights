# LittleLights — Mini-Game Template

Use this document to scaffold any new mini-game module.
Copy the file structure, fill in the class names, follow the checklist.

---

## Step 1: Create the Folder Structure

Replace `{story}` with the story ID (e.g., `david`, `jonah`, `adam`):

```
lib/game/{story}/
├── {story}_game.dart          ← FlameGame subclass (entry point)
├── {story}_world.dart         ← World setup, component layout
├── components/
│   ├── {primary_object}.dart  ← Main interactive component
│   └── {target_zone}.dart     ← Drop target or interaction zone
├── models/
│   └── {story}_data.dart      ← Pure Dart data models for this game
├── logic/
│   └── {story}_logic.dart     ← Pure functions (testable without Flame)
└── overlays/
    └── {story}_intro_overlay.dart  ← "How to play" overlay (optional)
```

Add asset directories:
```
assets/images/stories/{story}/
├── background/
├── {objects}/
├── ui/
└── cutscene/
```

---

## Step 2: Game States

Every game must implement these states:

```dart
enum {Story}GameState {
  idle,       // before game starts
  intro,      // showing intro overlay
  playing,    // active gameplay
  completed,  // all success conditions met
}
```

Add story-specific intermediate states as needed (e.g., `pairMatched`, `pairLoaded`).

---

## Step 3: FlameGame Subclass

```dart
// lib/game/{story}/{story}_game.dart

import 'package:flame/game.dart';
import '../core/base/game_result.dart';
import '../core/systems/audio_manager.dart';
import '{story}_world.dart';

/// Mini-game for the {Story} story.
/// Receives all data via constructor. Signals completion via [onComplete].
class {Story}Game extends FlameGame {
  /// Called when the game is successfully completed.
  final void Function(GameResult result) onComplete;

  /// Audio manager injected from Flutter shell.
  final AudioManager audioManager;

  // Add any other constructor data here (e.g., content, difficulty)

  {Story}Game({
    required this.onComplete,
    required this.audioManager,
  });

  late {Story}GameState _state;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _state = {Story}GameState.idle;

    // Load assets
    // await images.load(AssetPaths.flame{Story}Background);

    // Add world
    await add({Story}World(onSuccess: _handleSuccess));

    // Show intro overlay (optional)
    overlays.add('{Story}Intro');
    _state = {Story}GameState.intro;
  }

  /// Called by world/components when all success conditions are met.
  void _handleSuccess() {
    if (_state == {Story}GameState.completed) return; // guard against double-fire
    _state = {Story}GameState.completed;
    audioManager.playSfx(AssetPaths.flameSfxSuccess);
    // Brief delay for celebration animation before signaling Flutter
    Future.delayed(const Duration(milliseconds: 800), () {
      onComplete(GameResult.success);
    });
  }

  /// Resets game to initial state for replay.
  void reset() {
    removeAll(children);
    onLoad();
  }
}
```

---

## Step 4: World Class

```dart
// lib/game/{story}/{story}_world.dart

import 'package:flame/components.dart';

/// Sets up the game world: background, interactive components, layout.
class {Story}World extends World {
  final VoidCallback onSuccess;

  {Story}World({required this.onSuccess});

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Add background
    // await add(SpriteComponent(sprite: await Sprite.load(...)));

    // Add interactive components
    // await add({PrimaryObject}(onMatchComplete: _onMatchComplete));
    // await add({TargetZone}(onItemReceived: _onItemReceived));
  }

  void _checkCompletion() {
    // Call success logic — use pure function from logic/ file
    // if ({Story}Logic.isComplete(...)) onSuccess();
  }
}
```

---

## Step 5: Interactive Component

```dart
// lib/game/{story}/components/{primary_object}.dart

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import '../../core/components/draggable_component.dart';

/// A draggable [description of what this is].
class {PrimaryObject} extends SpriteComponent with DragCallbacks {
  final String objectId;
  final VoidCallback? onDropped;

  {PrimaryObject}({
    required this.objectId,
    this.onDropped,
    super.position,
    super.size,
  });

  // Track origin for snap-back on failed drop
  late Vector2 _origin;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _origin = position.clone();
    // sprite = await Sprite.load(AssetPaths.flame{Object});
    size = Vector2(100, 100); // minimum 80x80 logical pixels
  }

  @override
  void onDragStart(DragStartEvent event) {
    super.onDragStart(event);
    priority = 10; // bring to front during drag
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    position += event.localDelta;
  }

  @override
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);
    priority = 0;
    // Target zone detection handled by drop zone component
    // If no valid drop: snap back
    _snapBack();
  }

  void _snapBack() {
    // Animate back to _origin
    // Use SequenceEffect or MoveEffect
    position = _origin;
  }
}
```

---

## Step 6: Pure Logic File

Extract all game logic to pure Dart functions — no Flame imports, fully testable.

```dart
// lib/game/{story}/logic/{story}_logic.dart

import '../models/{story}_data.dart';

/// Pure game logic for {Story}. No Flame imports. Fully unit-testable.
class {Story}Logic {
  /// Returns true if [a] and [b] are a valid pair.
  static bool isValidPair({Story}Item a, {Story}Item b) {
    return a.pairId == b.pairId && a.id != b.id;
  }

  /// Returns true when all required items have been successfully placed.
  static bool isComplete(List<{Story}Item> items) {
    return items.every((item) => item.isPlaced);
  }

  // Add more pure functions as needed
}
```

---

## Step 7: Intro Overlay (Optional)

```dart
// lib/game/{story}/overlays/{story}_intro_overlay.dart

import 'package:flutter/material.dart';

/// Shows a brief instruction before gameplay starts.
/// Displayed as a Flame overlay — rendered by Flutter, not Flame.
class {Story}IntroOverlay extends StatelessWidget {
  final VoidCallback onStart;

  const {Story}IntroOverlay({required this.onStart, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Large illustration or character image
          // One short sentence (max 8 words)
          Text(
            '{Instruction here}',           // Keep it short, no reading required
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 32),
          // Large start button — min 80x80dp
          ElevatedButton(
            onPressed: onStart,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(160, 80),
            ),
            child: const Text('Start'),
          ),
        ],
      ),
    );
  }
}
```

Register the overlay in the game's `onLoad()`:
```dart
overlays.addEntry(
  '{Story}Intro',
  (context, game) => {Story}IntroOverlay(
    onStart: () {
      game.overlays.remove('{Story}Intro');
      game._state = {Story}GameState.playing;
    },
  ),
);
```

---

## Step 8: Wire into BaseGameScreen

In `app/routes/app_router.dart`:

```dart
GoRoute(
  path: '/stories/{story}/game',
  builder: (context, state) {
    final audioService = context.read(audioProvider);
    return BaseGameScreen(
      gameFactory: () => {Story}Game(
        onComplete: (result) {}, // set inside BaseGameScreen via onGameComplete
        audioManager: AudioManager(audioService),
      ),
      onGameComplete: (result) {
        if (result == GameResult.success) {
          context.go('/stories/{story}/cutscene');
        }
      },
    );
  },
),
```

---

## Step 9: Register Assets in pubspec.yaml

```yaml
flutter:
  assets:
    - assets/images/stories/{story}/background/
    - assets/images/stories/{story}/{objects}/
    - assets/images/stories/{story}/ui/
    - assets/images/stories/{story}/cutscene/
```

---

## Step 10: Pre-Launch Checklist

Before marking a mini-game as done, verify every item:

### UX
- [ ] All interactive objects are ≥ 80×80 logical pixels
- [ ] Drag hit area is ≥ 20dp larger than visual bounds
- [ ] No countdown timer visible
- [ ] Wrong action gives gentle feedback — no harsh sound, no fail screen
- [ ] Success triggers before Flutter navigation (≥ 500ms celebration)
- [ ] Game is understandable without reading any text
- [ ] Tested on 375pt wide screen (iPhone SE equivalent)

### Technical
- [ ] `onComplete(GameResult.success)` fires exactly once on completion
- [ ] Double-fire is guarded (state check before calling callback)
- [ ] Game disposes cleanly when screen is popped (no audio leaks)
- [ ] All assets loaded in `onLoad()` before game starts
- [ ] Assets declared in `pubspec.yaml`
- [ ] Asset path constants in `AssetPaths` class
- [ ] No Riverpod imports in game module
- [ ] No `Navigator` calls in game module

### Testing
- [ ] Logic functions in `{story}_logic.dart` have unit tests
- [ ] `flutter test test/unit/{story}_logic_test.dart` passes

---

## Quick Reference: Noah as the Example

Noah's Ark is the canonical implementation. When in doubt:
```
lib/game/noah/noah_game.dart              ← reference FlameGame
lib/game/noah/logic/matching_logic.dart   ← reference logic file
lib/game/noah/components/animal_card.dart ← reference interactive component
```
