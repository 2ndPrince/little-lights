# LittleLights — Wave 7 Execution Guide

> **Purpose:** Agent-ready prompts for parallel/sequential implementation of the unified puzzle mechanic.
> **Default mode:** One phase at a time. User approves before the next phase starts.
> **Fast path:** Say "implement all" or "implement batch X" to run phases in parallel.

---

## Dependency Graph

```
Phase 0 (Infrastructure)
    ↓
Phase 1 (Story 1: Creation)   ← approve before next
    ↓
Phase 2 (Story 2: Adam & Eve) ← approve before next
    ↓
Phase 3 (Story 3: Noah)       ← approve before next
    ↓
Phase 4 (Story 4: Moses)      ← approve before next
    ↓
Phase 5 (Story 5: David)      ← ...
    ↓
Phase 6 (Story 6: Jonah)
    ↓
Phase 7 (Story 7: Daniel)
    ↓
Phase 8 (Story 8: Good Samaritan)
    ↓
Phase 9 (Story 9: Feeding the 5,000)
    ↓
Phase 10 (Story 10: Zacchaeus)
    ↓
Phase 11 (Cleanup: delete old mini-game code)
```

**Parallel-safe batches** (all need Phase 0 complete first):
- Batch A: Phases 1–3 (Creation, Adam, Noah) — Adam and Noah have real assets ✅
- Batch B: Phases 4–6 (Moses, David, Jonah) — David and Jonah have real assets ✅
- Batch C: Phases 7–10 (Daniel, Samaritan, Feeding, Zacchaeus)

---

## Phase 0 — Universal Puzzle Infrastructure

**Run once. All story phases depend on this.**

### Agent prompt

```
Project: /Users/youngseoklee/Documents/ysle-tech/little-lights
Task: Build the universal puzzle infrastructure for LittleLights Wave 7.

## Context
LittleLights is pivoting from 10 different mini-games to ONE universal jigsaw puzzle game.
Every story uses the same PuzzleGame with different PuzzleContent (image + lessons + captions).
Read ARCHITECTURE.md and GAME_DESIGN.md before writing any code.

## What to build

### 1. lib/data/models/story.dart — update StoryId enum ORDER (critical for unlock sequence)
New order (chronological): creation, adam, noah, moses, david, jonah, daniel, samaritan, feeding, zacchaeus
Change: enum StoryId { creation, adam, noah, moses, david, jonah, daniel, samaritan, feeding, zacchaeus }
Also add StoryTheme.generosity and StoryTheme.wonder if not present.

### 2. lib/game/puzzle/puzzle_content.dart
Data model for a story's puzzle configuration:
```dart
class PuzzleContent {
  final StoryId storyId;
  final String puzzleImageFlamePath;     // Flame path to scene_01
  final List<String> lessonFlutterPaths; // Flutter paths: [scene_02, scene_03, scene_04]
  final List<String> lessonCaptions;     // 3 captions, one per lesson scene
  final int columns;                     // default 3
  final int rows;                        // default 4 (3×4 = 12 pieces)
  const PuzzleContent({...});
}
```

### 3. lib/constants/puzzle_content_registry.dart
Map<StoryId, PuzzleContent> with entries for ALL 10 stories.
Use AssetPaths constants for all paths.
Captions from GAME_DESIGN.md lesson captions table.

### 4. lib/game/puzzle/puzzle_logic.dart
Pure Dart logic (no Flutter, no Flame):
- PuzzlePiece model: id (int), column, row, isPlaced
- PuzzleLogic(int columns, int rows): generates pieces list
- bool placePiece(int id): marks piece as placed, returns true
- bool get allPlaced: true when all pieces are placed
- void reset(): resets all pieces to unplaced
Unit tests in test/game/puzzle/puzzle_logic_test.dart (min 8 tests)

### 5. lib/game/puzzle/components/puzzle_piece_component.dart
Flame component for a single draggable puzzle piece:
- Extends PositionComponent with DragCallbacks, TapCallbacks
- Constructor: (Sprite fullImage, int col, int row, int totalCols, int totalRows, Vector2 targetPosition, VoidCallback onPlaced)
- Renders the correct slice of the full image using srcPosition/srcSize on a SpriteComponent
- On drag end: if within 30px of targetPosition → snap, call onPlaced, play sfx_snap
- If not within 30px → float back to last valid position (simple lerp animation)
- Visual: slightly elevated shadow while dragging (scale 1.05)

### 6. lib/game/puzzle/puzzle_world.dart
Flame World that manages the puzzle layout:
- Constructor: (Image puzzleImage, PuzzleContent content, void Function(int pieceId) onPiecePlaced)
- Calculates piece size from image dimensions and grid
- Places ghost outlines (RectangleComponent, 0.2 opacity) at target positions
- Scatters pieces randomly in a safe zone (not overlapping targets)
- Exposes List<PuzzlePieceComponent> get pieces

### 7. lib/game/puzzle/puzzle_game.dart  
FlameGame subclass — universal, works for all 10 stories:
- Constructor: (PuzzleContent content, void Function(GameResult) onComplete)
- onLoad: loads scene_01 image, creates PuzzleWorld, plays BGM
- _handlePiecePlaced(int id): updates PuzzleLogic, plays sfx_tap
- When allPlaced: plays sfx_success, 1.5s delay, calls onComplete(GameResult.success)
- static const String introOverlayKey = 'puzzleIntro'
- NO Riverpod. NO Navigator. Data in via constructor, result out via callback.

### 8. lib/game/puzzle/overlays/puzzle_intro_overlay.dart
Flutter overlay shown before puzzle starts:
- Shows story title, a "Let's go!" button
- Tapping the button calls game.overlays.remove(key) to start the puzzle
- Uses existing app theme colors/text styles

### 9. lib/features/puzzle/puzzle_game_screen.dart
Flutter ConsumerWidget wrapping PuzzleGame via BaseGameScreen:
- Accepts StoryId via constructor
- Looks up PuzzleContent from puzzleContentRegistry
- On GameResult.success: markComplete via progressProvider, then context.go('/lesson/${storyId.name}')

### 10. lib/features/lesson/lesson_screen.dart
New Flutter StatefulWidget for the lesson flow:
- Accepts StoryId, looks up PuzzleContent from registry
- Shows puzzle assembled image briefly (1.5s) with celebration overlay
- Then shows lesson scenes full-screen, one at a time, with caption
- Caption: centered text at bottom, dark overlay behind it, large font (24sp+)
- Tap anywhere → next scene; after last scene → context.go('/stories/${storyId.name}/reward')
- Progress indicator dots (3 dots, current highlighted)

### 11. lib/app/routes/app_router.dart — route changes
REPLACE the 40 story-specific game/cutscene routes with parametric routes:
- GoRoute(path: '/puzzle/:storyId', builder: → PuzzleGameScreen(storyId: ...))
- GoRoute(path: '/lesson/:storyId', builder: → LessonScreen(storyId: ...))
Keep all intro routes and reward routes (they're fine as-is per story).
Keep cutscene route as legacy (can be removed in cleanup).

### 12. lib/providers/progress_provider.dart — update initial state
Change initial unlocked story from StoryId.noah to StoryId.creation.
The _applyUnlockRules uses StoryId.values order, which now starts with creation.

### 13. lib/features/stories/story_selection_screen.dart
Update _routeFor() switch to route ALL stories to '/puzzle/${id.name}'
(i.e., delete all the intro-specific cases, just return '/stories/${id.name}/intro')
Actually keep intro routing — the intro screen then routes to '/puzzle/${id.name}'.

### 14. lib/constants/asset_paths.dart — add puzzle/lesson paths if any are missing

## Definition of Done
- flutter analyze: 0 issues
- flutter test: all tests pass (add puzzle_logic_test.dart)
- PuzzleGame can be instantiated with any PuzzleContent
- LessonScreen can show any story's lesson slides
- Routes: /puzzle/:storyId and /lesson/:storyId both resolve
- Commit: "feat: Wave 7 — universal puzzle infrastructure"
  Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>
```

---

## Phase 1 — Story 1: Creation

**Asset status: ❌ scene_01–04 are 1×1 placeholders → must regenerate**

### What this phase does
1. Regenerates `scene_01–04` for Creation using Gemini
2. Wires Creation's intro screen to route to `/puzzle/creation`
3. Verifies full flow: Story Intro → Puzzle → Lesson → Reward

### Agent prompt

```
Project: /Users/youngseoklee/Documents/ysle-tech/little-lights
Task: Wire Story 1 (Creation) into the Wave 7 puzzle system.
Prerequisite: Phase 0 infrastructure is complete and committed.

GEMINI_API_KEY is in .env file at project root.

## Step 1: Regenerate Creation assets (scene_01–04 are 1×1 placeholders)

Use Python + Gemini API (model: gemini-2.5-flash-preview-04-17, responseModalities: ["IMAGE","TEXT"]) to generate:

assets/images/stories/creation/cutscene/scene_01.png
Prompt: "Children's Bible story illustration, the moment of Creation — a beautiful dark void
with a brilliant burst of golden light appearing in the center, surrounded by swirling deep
blues and purples, stars forming, magical and awe-inspiring but gentle and warm, simple flat
art style for children age 4-7, no text, 540x960 portrait"

assets/images/stories/creation/cutscene/scene_02.png
Prompt: "Children's Bible story illustration, six panels showing the days of Creation —
light, sky, land and sea, sun moon stars, birds and fish, animals and people, each panel
glowing warmly, simple flat art for children, pastel colors, no text"

assets/images/stories/creation/cutscene/scene_03.png
Prompt: "Children's Bible story illustration, God looks over a completed beautiful world —
sun rising over mountains, ocean twinkling, animals playing, birds flying, garden in
foreground, golden light everywhere, 'It is good', simple flat art, warm pastel colors,
no text, suitable for children age 4-7"

assets/images/stories/creation/cutscene/scene_04.png
Prompt: "Children's Bible story illustration, the seventh day of rest — God resting,
peaceful garden scene, animals sleeping, Adam and Eve resting under a tree, soft morning
light, rainbow above, everything peaceful and complete, simple flat art, warm pastel colors,
children age 4-7, no text"

Compress any images over 400KB using PIL (quality 85 JPEG intermediate → PNG).

## Step 2: Update lib/features/creation/creation_story_intro_screen.dart
Change startRoute to AppRoutes.puzzleGame (or '/puzzle/creation') — whichever was defined in Phase 0.

## Step 3: Verify PuzzleContent entry for creation in puzzle_content_registry.dart is correct.

## Step 4: Run flutter analyze + flutter test. Fix any issues.

## Step 5: Commit "feat: Story 1 (Creation) — puzzle wired, assets regenerated"
Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>
```

---

## Phase 2 — Story 2: Adam & Eve

**Asset status: ✅ scene_01–04 are real Gemini images**

### Agent prompt

```
Project: /Users/youngseoklee/Documents/ysle-tech/little-lights
Task: Wire Story 2 (Adam & Eve) into the Wave 7 puzzle system.
Prerequisite: Phase 0 infrastructure complete and committed.

## Step 1: Adam & Eve assets are already real — verify file sizes > 10KB
Run: wc -c assets/images/stories/adam/cutscene/scene_01.png
If < 10000 bytes → regenerate using Gemini (see Phase 1 for API pattern).

Regeneration prompts (if needed):
scene_01: "Children's Bible, Adam and Eve in the Garden of Eden surrounded by animals —
lion, elephant, giraffe, birds, lush garden, golden light, warm pastels, simple flat art
for children age 4-7, no text"
scene_02: "Children's Bible, Adam giving names to animals one by one, pointing at a
friendly elephant, garden background, joyful, simple flat art, pastel colors, no text"
scene_03: "Children's Bible, God walking with Adam and Eve in the garden, warm afternoon
light, peaceful, friendly animals nearby, simple flat art for children, no text"
scene_04: "Children's Bible, Adam and Eve looking at the whole garden with wonder —
colorful flowers, animals, fruit trees, everything beautiful, simple flat art, children
age 4-7, no text"

## Step 2: Update lib/features/adam/adam_story_intro_screen.dart
Change startRoute to '/puzzle/adam'.

## Step 3: Verify PuzzleContent entry for adam in puzzle_content_registry.dart.

## Step 4: flutter analyze + flutter test. Fix any issues.

## Step 5: Commit "feat: Story 2 (Adam & Eve) — puzzle wired"
Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>
```

---

## Phase 3 — Story 3: Noah's Ark

**Asset status: ✅ real**

### Agent prompt

```
Project: /Users/youngseoklee/Documents/ysle-tech/little-lights
Task: Wire Story 3 (Noah's Ark) into the Wave 7 puzzle system.
Prerequisite: Phase 0 complete.

## Step 1: Verify assets/images/stories/noah/cutscene/scene_01.png > 10KB. Should be fine.

## Step 2: Update lib/features/noah/noah_story_intro_screen.dart
Change startRoute to '/puzzle/noah'.

## Step 3: Verify PuzzleContent entry for noah in puzzle_content_registry.dart.

## Step 4: flutter analyze + flutter test.

## Step 5: Commit "feat: Story 3 (Noah's Ark) — puzzle wired"
Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>
```

---

## Phase 4 — Story 4: Moses & the Red Sea

**Asset status: ❌ placeholders → must regenerate**

### Agent prompt

```
Project: /Users/youngseoklee/Documents/ysle-tech/little-lights
Task: Wire Story 4 (Moses) into Wave 7. Regenerate scene_01–04.
Prerequisite: Phase 0 complete.

GEMINI_API_KEY in .env.

## Step 1: Regenerate Moses assets

scene_01: "Children's Bible story illustration, Moses standing at the edge of the Red Sea,
arms raised with his staff, two towering walls of blue-green water parting on either side,
Israelites visible behind him ready to cross, dramatic golden sky, simple flat art for
children age 4-7, no text, 540x960 portrait"

scene_02: "Children's Bible story illustration, Israelite families trapped between the Red
Sea and Pharaoh's army — worried faces but still hopeful, Moses looking at the sky in prayer,
warm colors, simple flat art for children, no text"

scene_03: "Children's Bible story illustration, Moses stretching his staff over the sea,
powerful swirling water beginning to part revealing a sandy path, golden light breaking
through, awe and wonder, simple flat art, pastel colors, children age 4-7, no text"

scene_04: "Children's Bible story illustration, Israelite families joyfully walking through
the parted sea — children running, parents smiling, fish visible in the water walls, distant
other shore visible ahead, hopeful sunrise colors, simple flat art, no text"

Compress if > 400KB.

## Step 2: Update lib/features/moses/moses_story_intro_screen.dart
Change startRoute to '/puzzle/moses'.

## Step 3: Verify PuzzleContent entry for moses in registry.

## Step 4: flutter analyze + flutter test.

## Step 5: Commit "feat: Story 4 (Moses) — puzzle wired, assets regenerated"
Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>
```

---

## Phase 5 — Story 5: David & Goliath

**Asset status: ✅ real**

### Agent prompt

```
Project: /Users/youngseoklee/Documents/ysle-tech/little-lights
Task: Wire Story 5 (David & Goliath) into Wave 7 puzzle system.
Prerequisite: Phase 0 complete.

## Step 1: Verify david scene_01.png > 10KB.

## Step 2: Update lib/features/david/david_story_intro_screen.dart
Change startRoute to '/puzzle/david'.

## Step 3: Verify PuzzleContent entry for david in registry.

## Step 4: flutter analyze + flutter test.

## Step 5: Commit "feat: Story 5 (David) — puzzle wired"
Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>
```

---

## Phase 6 — Story 6: Jonah

**Asset status: ✅ real**

### Agent prompt

```
Project: /Users/youngseoklee/Documents/ysle-tech/little-lights
Task: Wire Story 6 (Jonah) into Wave 7 puzzle system.
Prerequisite: Phase 0 complete.

## Step 1: Verify jonah scene_01.png > 10KB.

## Step 2: Update lib/features/jonah/jonah_story_intro_screen.dart
Change startRoute to '/puzzle/jonah'.

## Step 3: Verify PuzzleContent entry for jonah in registry.

## Step 4: flutter analyze + flutter test.

## Step 5: Commit "feat: Story 6 (Jonah) — puzzle wired"
Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>
```

---

## Phase 7 — Story 7: Daniel & the Lions

**Asset status: ❌ placeholders → must regenerate**

### Agent prompt

```
Project: /Users/youngseoklee/Documents/ysle-tech/little-lights
Task: Wire Story 7 (Daniel) into Wave 7. Regenerate scene_01–04.
Prerequisite: Phase 0 complete.
GEMINI_API_KEY in .env.

## Step 1: Regenerate Daniel assets

scene_01: "Children's Bible story illustration, Daniel kneeling in prayer inside the lions'
den, three friendly cartoon lions around him, warm torchlight from above, an angel glowing
softly overhead, Daniel looks peaceful not afraid, simple flat art for children age 4-7,
warm golden tones, no text, 540x960 portrait"

scene_02: "Children's Bible story, Daniel praying by his window three times a day, city of
Babylon visible through window, warm afternoon light, peaceful and determined expression,
simple flat art for children, pastel colors, no text"

scene_03: "Children's Bible story, Daniel being lowered into the dark lions' den by two
guards, King Darius watching with a worried face, torchlight flickering, Daniel looking calm
and trusting, simple flat art, children age 4-7, no text"

scene_04: "Children's Bible story, Daniel emerging from the lions' den the next morning —
King Darius reaching down joyfully to help him up, lions lying peacefully in the background,
bright morning sunlight, celebration, simple flat art, warm colors, no text"

Compress if > 400KB.

## Step 2: Update lib/features/daniel/daniel_story_intro_screen.dart
Change startRoute to '/puzzle/daniel'.

## Step 3: Verify PuzzleContent entry for daniel in registry.

## Step 4: flutter analyze + flutter test.

## Step 5: Commit "feat: Story 7 (Daniel) — puzzle wired, assets regenerated"
Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>
```

---

## Phase 8 — Story 8: Good Samaritan

**Asset status: ❌ placeholders → must regenerate**

### Agent prompt

```
Project: /Users/youngseoklee/Documents/ysle-tech/little-lights
Task: Wire Story 8 (Good Samaritan) into Wave 7. Regenerate scene_01–04.
Prerequisite: Phase 0 complete.
GEMINI_API_KEY in .env.

## Step 1: Regenerate Good Samaritan assets

scene_01: "Children's Bible story illustration, the Good Samaritan kneeling on a dusty road
helping a wounded man, bandaging his arm with care, warm afternoon sun, olive trees in
background, kind gentle expression, simple flat art for children age 4-7, pastel colors,
no text, 540x960 portrait"

scene_02: "Children's Bible story, a man traveling alone on a hilly road is surrounded by
robbers — gentle non-scary depiction, confused and sad expression, distant city visible,
simple flat art for children, warm pastel tones, no text"

scene_03: "Children's Bible story, a priest and a Levite each walk past the wounded man
on the road without helping, man watching them go, sad but gentle scene, simple flat art
for children, pastel colors, no text"

scene_04: "Children's Bible story, the Good Samaritan loading the healed man onto a donkey
to take him to an inn, both smiling, sunset colors, palm trees, warmth and kindness visible,
simple flat art for children age 4-7, no text"

Compress if > 400KB.

## Step 2: Update lib/features/samaritan/samaritan_story_intro_screen.dart
Change startRoute to '/puzzle/samaritan'.

## Step 3: Verify PuzzleContent entry for samaritan in registry.

## Step 4: flutter analyze + flutter test.

## Step 5: Commit "feat: Story 8 (Good Samaritan) — puzzle wired, assets regenerated"
Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>
```

---

## Phase 9 — Story 9: Feeding the 5,000

**Asset status: ❌ placeholders → must regenerate**

### Agent prompt

```
Project: /Users/youngseoklee/Documents/ysle-tech/little-lights
Task: Wire Story 9 (Feeding the 5,000) into Wave 7. Regenerate scene_01–04.
Prerequisite: Phase 0 complete.
GEMINI_API_KEY in .env.

## Step 1: Regenerate Feeding the 5,000 assets

scene_01: "Children's Bible story illustration, Jesus holding up bread and fish on a sunny
hillside, thousands of people sitting on the grass around him, disciples carrying baskets,
golden afternoon light, joyful expressions, simple flat art for children age 4-7, no text,
540x960 portrait"

scene_02: "Children's Bible story, thousands of tired hungry people sitting on a hillside
at sunset, Jesus and the disciples talking in the foreground looking concerned, warm pastel
colors, simple flat art for children, no text"

scene_03: "Children's Bible story, a small boy holding out his little basket with 5 round
loaves of bread and 2 fish to Jesus, Jesus smiling warmly and taking the gift, disciples
watching in surprise, simple flat art, warm colors, children age 4-7, no text"

scene_04: "Children's Bible story, disciples carrying many overflowing baskets of bread and
fish to the crowd, everyone eating happily, children laughing, sunset colors, celebration,
12 leftover baskets in the foreground, simple flat art, pastel colors, no text"

Compress if > 400KB.

## Step 2: Update lib/features/feeding/feeding_story_intro_screen.dart
Change startRoute to '/puzzle/feeding'.

## Step 3: Verify PuzzleContent entry for feeding in registry.

## Step 4: flutter analyze + flutter test.

## Step 5: Commit "feat: Story 9 (Feeding the 5000) — puzzle wired, assets regenerated"
Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>
```

---

## Phase 10 — Story 10: Zacchaeus

**Asset status: ❌ placeholders → must regenerate**

### Agent prompt

```
Project: /Users/youngseoklee/Documents/ysle-tech/little-lights
Task: Wire Story 10 (Zacchaeus) into Wave 7. Regenerate scene_01–04.
Prerequisite: Phase 0 complete.
GEMINI_API_KEY in .env.

## Step 1: Regenerate Zacchaeus assets

scene_01: "Children's Bible story illustration, little Zacchaeus sitting high up in a
sycamore tree, Jesus below looking up at him with a warm smile and pointing, a crowd of
people around them looking surprised, colorful robes, warm afternoon sunlight through
leaves, simple flat art for children age 4-7, no text, 540x960 portrait"

scene_02: "Children's Bible story, tiny Zacchaeus standing on tiptoes behind a crowd trying
to see Jesus walk by, can't see over peoples' heads, funny and sympathetic expression,
colorful market street, simple flat art for children, no text"

scene_03: "Children's Bible story, Zacchaeus climbing a sycamore tree eagerly, reaching
for a branch, leaves all around, Jesus visible in the distance on the road below, determined
happy face, simple flat art, warm greens and browns, no text"

scene_04: "Children's Bible story, Zacchaeus and Jesus eating together at a table inside
Zacchaeus's home, Zacchaeus happily giving gold coins to poor people outside the window,
transformation and joy visible, warm interior, simple flat art for children age 4-7, no text"

Compress if > 400KB.

## Step 2: Update lib/features/zacchaeus/zacchaeus_story_intro_screen.dart
Change startRoute to '/puzzle/zacchaeus'.

## Step 3: Verify PuzzleContent entry for zacchaeus in registry.

## Step 4: flutter analyze + flutter test.

## Step 5: Commit "feat: Story 10 (Zacchaeus) — puzzle wired, assets regenerated"
Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>
```

---

## Phase 11 — Cleanup

**Only run after all 10 story phases are approved and complete.**

### Agent prompt

```
Project: /Users/youngseoklee/Documents/ysle-tech/little-lights
Task: Clean up all old story-specific mini-game code now superseded by the universal PuzzleGame.

## Delete these directories entirely:
lib/game/noah/
lib/game/david/
lib/game/jonah/
lib/game/adam/
lib/game/moses/
lib/game/daniel/
lib/game/samaritan/
lib/game/zacchaeus/
lib/game/feeding/
lib/game/creation/

## Delete these files:
lib/features/noah/noah_game_screen.dart
lib/features/david/david_game_screen.dart
lib/features/jonah/jonah_game_screen.dart
lib/features/adam/adam_game_screen.dart
lib/features/moses/moses_game_screen.dart
lib/features/daniel/daniel_game_screen.dart
lib/features/samaritan/samaritan_game_screen.dart
lib/features/zacchaeus/zacchaeus_game_screen.dart
lib/features/feeding/feeding_game_screen.dart
lib/features/creation/creation_game_screen.dart
(also any *_intro_overlay.dart files that referenced old games)

## Remove from app_router.dart:
All old story-specific game imports and routes now replaced by parametric routes.
Keep: intro routes, reward routes, /puzzle/:storyId, /lesson/:storyId

## Remove from pubspec.yaml:
Old character/item/background sprite asset directories that are no longer used:
(keep cutscene/ directories; remove characters/, ui/ item sprites, background/ if not used)

## Run: flutter analyze + flutter test (all must pass)

## Commit: "chore: Wave 7 cleanup — remove 10 old mini-game implementations"
Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>
```

---

## Quick Reference

| Phase | Story | Assets | Approx effort |
|---|---|---|---|
| 0 | Infrastructure | — | Large (60+ min) |
| 1 | Creation | Regen 4 | Medium |
| 2 | Adam & Eve | Real ✅ | Small |
| 3 | Noah's Ark | Real ✅ | Small |
| 4 | Moses | Regen 4 | Medium |
| 5 | David | Real ✅ | Small |
| 6 | Jonah | Real ✅ | Small |
| 7 | Daniel | Regen 4 | Medium |
| 8 | Good Samaritan | Regen 4 | Medium |
| 9 | Feeding 5,000 | Regen 4 | Medium |
| 10 | Zacchaeus | Regen 4 | Medium |
| 11 | Cleanup | — | Small |
