# LittleLights — Noah's Ark MVP Spec

## Purpose

This document specifies the complete Noah's Ark MVP vertical slice.

This is not just a content demo. It is a **system validation slice** that proves:
- App flow works end-to-end
- Flutter + Flame integration is correct
- Child-friendly UX is achievable
- Reward and cutscene flow is reusable
- Local save works correctly
- Architecture is extensible to future stories

**Definition:** MVP is done when one child can pick up the device, start the Noah story, play the game, see the cutscene, receive the reward, and the completion is still there when the app restarts.

---

## MVP Scope

### In Scope
- HomeScreen
- StorySelectionScreen (Noah card only; others shown as locked)
- Noah story intro screen
- Noah mini-game (animal matching, 3 pairs)
- Success celebration animation (in-game)
- Cutscene (4-frame PNG sequence, ~10–20 seconds)
- RewardScreen (1 star + Noah badge)
- Progress save (SharedPreferences)
- Settings screen (sound on/off)
- Parent gate (hold-gesture access)

### Out of Scope (MVP)
- David, Jonah, Adam stories (placeholders only — locked cards)
- Voice narration
- Multiple languages
- Cloud save or accounts
- Monetization
- Advanced particle effects
- Difficulty modes

---

## Full MVP Flow

```
1. App launches → HomeScreen
2. Tap "Play" → StorySelectionScreen
3. Tap Noah card (unlocked) → Noah Intro Screen
4. Tap "Start" → Noah GameScreen (Flame)
5. Match 3 animal pairs → drag each pair into ark
6. All 3 pairs loaded → in-game celebration animation
7. Transition → CutsceneScreen (4 frames, ~15 seconds)
8. CutsceneScreen completes → RewardScreen
9. RewardScreen shows: 1 star + Noah badge + celebration
10. Tap "Done" or "Replay" → StorySelectionScreen
11. Noah card now shows completed state; David card now unlocked
12. Close and reopen app → completion state preserved
```

Total taps to start gameplay from home screen: **3 taps maximum.**

---

## Screens

### 1. HomeScreen
- Large friendly logo / title
- Single "Play" button (min 160×80dp)
- Small gear icon (holds to access parent gate)
- Warm pastel background
- BGM: `bgm_home.mp3` starts here

### 2. StorySelectionScreen
- Grid of story cards (4 cards: Noah unlocked, others locked)
- Each card: thumbnail + story title + star indicator
- Tapping locked card: gentle shake, no navigation
- Tapping Noah card → Noah intro screen

### 3. Noah Intro Screen (StoryIntroScreen widget — reusable)
- Large illustration of Noah and ark
- One sentence: **"Help Noah bring the animals into the ark."**
- Large "Start" button (min 160×80dp)
- BGM: crossfade from `bgm_home.mp3` to `bgm_noah.mp3`
- Back button returns to story selection

### 4. Noah GameScreen
See Game Spec below.

### 5. CutsceneScreen (CutscenePlayer widget — reusable)
- Displays PNG frames in sequence
- Frame duration: ~1.5 seconds each (4 frames = ~15 seconds total)
- Tap anywhere to skip
- Auto-advances to RewardScreen
- BGM: continues `bgm_noah.mp3`

### 6. RewardScreen
- 1 gold star animates in (scale up + sparkle)
- Noah badge animates in (bounce + glow)
- "Wonderful!" or similar encouraging text (min 24sp)
- Two buttons: "Play Again" (replay game) + "Done" (return to story select)
- SFX: `sfx_star.mp3` → `sfx_badge.mp3`

### 7. SettingsScreen
- Sound on/off toggle
- "Back" button
- Accessible from HomeScreen gear icon (behind parent gate)

### 8. ParentGateSheet
- Bottom sheet that appears after 2-second hold on settings icon
- "Hold to confirm you're a parent" instruction
- After gate: show parent options (sound toggle, reset progress)
- Reset progress shows confirmation before executing

---

## Noah Mini-Game Spec

### Concept
Children help Noah by matching animal pairs and dragging them into the ark.

### Layout
```
┌─────────────────────────────┐
│  [Sound]              [ark] │  ← top area: minimal UI
│                             │
│      🦁    🐘    🦒         │  ← row 1: 3 animals
│                             │
│      🦁    🦒    🐘         │  ← row 2: 3 matching animals (shuffled)
│                             │
└─────────────────────────────┘
```

Ark is positioned in the upper-right or top-center. Animals fill the center play area.

### Interaction Flow
1. Child **taps** an animal → it highlights (scale up slightly, glow border)
2. Child **taps** the matching animal → match detected
3. Matched pair **bounces together** → sparkle SFX (`sfx_match.mp3`)
4. Pair **slides toward ark** and fades into ark → SFX (`sfx_load_ark.mp3`)
5. Ark **door animates** slightly (or shakes happily)
6. Repeat for remaining 2 pairs
7. All 3 loaded → completion celebration → `sfx_success.mp3`

### Drag-or-Tap Choice
MVP implementation should support **tap-to-select + tap-to-match** as the primary interaction (simpler, more reliable for small children). Drag-to-ark is secondary/additive.

### Animal Pairs (MVP)
| Pair | Animal 1 asset | Animal 2 asset |
|---|---|---|
| Lion | `lion_1.png` | `lion_2.png` |
| Elephant | `elephant_1.png` | `elephant_2.png` |
| Giraffe | `giraffe_1.png` | `giraffe_2.png` |

### Game States
```dart
enum NoahGameState {
  idle,          // before first tap
  intro,         // intro overlay showing
  playing,       // active gameplay
  pairSelected,  // one animal tapped, awaiting second
  pairMatched,   // two animals matched, animating
  pairLoaded,    // pair arrived in ark
  completed,     // all 3 pairs loaded
}
```

### Feedback Rules

| Action | Visual | Audio |
|---|---|---|
| Animal tapped (selected) | Scale 1.15 + soft glow border | `sfx_tap.mp3` |
| Matching animal tapped | Both bounce + sparkle | `sfx_match.mp3` |
| Non-matching animal tapped | Gentle shake + deselect first | `sfx_incorrect.mp3` |
| Pair loads into ark | Slide + fade + ark shakes | `sfx_load_ark.mp3` |
| All pairs loaded | Full celebration | `sfx_success.mp3` |

No red X. No "wrong" text. No score. No timer.

### Touch Target Sizes
- Animal card: **100×100 logical pixels** (never below 80×80)
- Ark zone: entire upper area (large, forgiving)

### Success Condition
All 3 pairs matched and loaded into the ark (`NoahGameState.completed`).

### No Failure State
- Wrong tap → gentle feedback → try again
- No lives, no strikes, no countdown
- Game can only end in success

---

## Cutscene Spec

### Frame Sequence
| Frame | Duration | Content |
|---|---|---|
| `scene_01.png` | 1.5s | Noah standing beside the ark, smiling |
| `scene_02.png` | 1.5s | Animals approaching or entering the ark |
| `scene_03.png` | 1.5s | Clouds gathering, gentle rain beginning |
| `scene_04.png` | 1.5s | Ark floating on water, bright sky, animals visible in window |

Total: ~6 seconds minimum. Can extend to ~15–20 seconds with transition delays.

### Rules
- Skippable at any time (tap anywhere = skip to reward)
- Auto-advances on last frame after 1-second pause
- BGM continues playing (no gap)
- No text required (visual storytelling only)

---

## Reward Spec

| Item | Value | Condition |
|---|---|---|
| Star | 1 | Completing the game (always) |
| Badge | Noah Badge | First time completing Noah |

### Celebration Animation Sequence
1. Screen fades in from black (0.3s)
2. Star scales from 0 → 1.2 → 1.0 (0.4s) + `sfx_star.mp3`
3. Badge slides in from bottom (0.3s) + `sfx_badge.mp3`
4. Sparkles burst from star (0.5s)
5. Buttons fade in: "Play Again" + "Done" (0.3s)

---

## Local Save Spec

### What to Save
```
progress_noah_completed     → bool   (true after first completion)
progress_noah_stars         → int    (1 after completion)
settings_sound_enabled      → bool   (default: true)
```

### When to Save
- Immediately after `RewardScreen` is shown (not on game completion — prevents save on crash)
- Sound setting saved immediately on toggle

### Unlock Logic
After `progress_noah_completed = true`:
- `StoryId.david` becomes unlocked on next `StorySelectionScreen` load
- David's story card changes from locked → unlocked state

---

## Reusable Systems (Must Be Generic)

Every system built for Noah must work for all future stories without code changes:

| System | Generic parameter |
|---|---|
| `BaseGameScreen` | Any `FlameGame` |
| `StoryIntroScreen` | Story title, illustration asset, instruction text |
| `CutscenePlayer` | List of frame asset paths, frame duration |
| `RewardScreen` | Stars count, badge asset path, badge name |
| `ProgressRepository` | Any `StoryId` |
| `AudioManager` | Any asset path |

---

## Definition of Done

The MVP is complete when all of these are true:

- [ ] App launches to HomeScreen without crash
- [ ] Child can tap into Noah story in 3 taps from HomeScreen
- [ ] Game is playable with placeholder assets (no real art required)
- [ ] All 3 animal pairs can be matched and loaded
- [ ] Success triggers after all 3 pairs are loaded
- [ ] Cutscene plays (4 frames, auto-advances)
- [ ] RewardScreen shows star and badge
- [ ] Progress saves to SharedPreferences
- [ ] App can be closed and reopened — Noah shows as completed
- [ ] David's story card shows as unlocked after Noah completion
- [ ] Sound toggle works and persists
- [ ] Parent gate requires 2-second hold
- [ ] No crash on any screen
- [ ] Tested on device (not just simulator)
- [ ] Tested on 375pt width screen (iPhone SE equivalent)

---

## Future Story Template

When building David, Jonah, or Adam:
1. Copy `lib/game/noah/` → `lib/game/{story}/`
2. Create story-specific asset directories
3. Replace Noah-specific logic with story logic
4. Add route to `app_router.dart`
5. Register story in `stories_registry.dart`
6. Add progress keys to `ProgressRepository`
7. Follow `MINIGAME_TEMPLATE.md` checklist
