# LittleLights — Game Design Document

## Design Philosophy

LittleLights is a warm, encouraging space where young children experience Bible stories through play.
Every design decision should make a 4-year-old feel **capable, safe, and delighted**.

---

## Target Audience

- **Primary:** Children aged 4–7
- **Secondary:** Parents who want faith-based, screen-time-worthy content
- **Context:** Played with or without a parent present, on a tablet or phone

---

## Core Experience Goals

1. A child can start playing without reading anything
2. Every session ends in success — never failure
3. The child feels emotionally connected to the Bible story
4. A parent feels confident about the content and experience
5. Sessions are short enough to fit real family life (30 sec – 2 min)

---

## Game Loop

```
Home Screen
    ↓
Story Selection  (tap a story card)
    ↓
Story Intro      (one image + one short sentence + big Start button)
    ↓
Mini-Game        (play until success)
    ↓
Cutscene         (10–20 second animated story moment)
    ↓
Reward           (star + badge + celebration)
    ↓
Story Selection  (next story now unlocked)
```

The loop is linear. There is no branching, no failure exit, no dead end.

---

## Mini-Game Design Rules

### The 3-Mechanic Rule
Each mini-game uses **at most 3 types of interaction**. If it needs more, cut it.

### Interaction Types (approved for MVP age group)
- Tap to select
- Drag to target
- Tap at timing (single tap)
- Swipe to move

### Never use:
- Multi-finger gestures
- Complex combos
- Precise timing under pressure
- Anything requiring text reading
- Any form of countdown timer

### Feedback Rules

| Event | Response |
|---|---|
| Correct action | Bounce animation + sparkle + happy sound |
| Incorrect action | Gentle shake + soft sound + item returns to origin |
| Progress milestone | Subtle celebration (no scoring, just encouragement) |
| Completion | Full celebration → auto-transition to cutscene |

**No red X. No "wrong" text. No score counter. No lives.**

### Touch Target Rules
- Minimum: **80×80 logical pixels**
- Preferred: 100×100 for primary interactive objects
- Hit area should be 20dp larger than visual bounds for drag targets
- Objects must not overlap in default state

---

## Story Structure

Each story has:
1. **Theme** — one core value (kindness, courage, trust, forgiveness, obedience, helping)
2. **Mini-game** — a simple mechanic that reinforces the theme through action
3. **Cutscene** — a 10–20 second animated story moment using layered PNG animation
4. **Reward** — 1 completion star + 1 story-specific badge

### Story Roster

| # | Story | Theme | Mini-game Type | Status |
|---|---|---|---|---|
| 1 | Noah's Ark | Obedience / Trust | Tap to match animal pairs → ark | ✅ Live |
| 2 | David and Goliath | Courage | Tap to sling stones at Goliath | ✅ Live |
| 3 | Jonah | Obedience / Second chances | Tap storm clouds to calm the sea | ✅ Live |
| 4 | Adam and Eve | Stewardship / Care | Tap animals to name them | ✅ Live |
| 5 | Moses & the Red Sea | Trust / Courage | Swipe water walls apart to open a path | 🔜 Wave 6 |
| 6 | Daniel & the Lions | Courage / Faith | Tap each lion to feed it — all fed = safe | 🔜 Wave 6 |
| 7 | Good Samaritan | Kindness / Helping | Drag bandage, water, bread to wounded man | 🔜 Wave 6 |
| 8 | Zacchaeus | Forgiveness / Change | Tap branches in order to climb down to Jesus | 🔜 Wave 6 |
| 9 | Feeding the 5,000 | Generosity / Trust | Drag loaves & fish into crowd baskets | 🔜 Wave 6 |
| 10 | Creation | Wonder / Gratitude | Tap each day's element to place it in its slot | 🔜 Wave 6 |

---

## Noah's Ark — Game Spec

### Concept
Help Noah bring the animals into the ark by matching pairs.

### Mechanic
1. 6 animal cards appear on screen (3 pairs: lion, elephant, giraffe)
2. Child taps one animal to select it
3. Child taps or drags the matching animal to pair them
4. Matched pair floats together toward the ark and disappears inside
5. Repeat until all 3 pairs are loaded
6. Ark doors close → success celebration

### Animal Set (MVP)
- Lion pair
- Elephant pair
- Giraffe pair

### States
```
idle → intro → playing → pair_selected → pair_matched → pair_loaded → completed → reward → exit
```

### Difficulty (MVP: fixed, very easy)
- 3 pairs only (6 cards total)
- Cards are large and clearly distinct
- No time pressure
- No penalty for wrong tap — selection simply deselects

### Success Condition
All 3 pairs matched and loaded into ark.

### Cutscene Content (after success)
1. Noah stands near the closed ark (happy expression)
2. Rain/clouds begin to appear in sky
3. Ark floats gently on water
4. Final frame: bright sky, rainbow hint, cheerful animals visible in ark window

---

## Visual Direction

### Palette
```
Primary background:  #FFF8EC  (warm cream)
Sky/calm blue:       #C8E6F5
Ground/grass:        #B5D99C
Accent warm:         #F4A261  (orange)
Accent green:        #A8D8A8
Accent yellow:       #F9E4B7
Text (dark):         #3D2B1F
Text (light):        #FFFFFF
```

### Shape Language
- All UI elements use rounded corners (radius ≥ 16dp)
- Characters have soft, rounded outlines (no sharp angles)
- Buttons are large, pill-shaped or circular
- No hard shadows — use soft drop shadows or glows only

### Character Style
- Friendly, smiling faces
- Simple eyes (large, expressive)
- Pastel-colored clothing
- No realistic rendering — aim for gentle illustrated style

---

## Audio Direction

### Background Music
- Soft, looping instrumental
- Gentle tempo (60–80 BPM)
- No jarring transitions between screens
- BGM fades smoothly when entering game, fades back on exit

### Sound Effects
| Event | Sound character |
|---|---|
| Animal matched | Soft chime + sparkle |
| Animal loaded to ark | Warm thud + brief fanfare |
| Wrong tap | Soft "boing" — never harsh or alarming |
| Game completion | 3-note ascending chime |
| Star awarded | Bright twinkling sound |
| Button tap | Soft pop |

### Volume Defaults
- BGM: 60% volume
- SFX: 80% volume
- Both controllable in settings; state persists across sessions

---

## Cutscene Direction

### Technical Approach
- PNG sequence (not video, not Lottie)
- 8–12 frames per cutscene
- Frame duration: ~1.5 seconds per frame (total: 12–18 seconds)
- Simple layered movement: characters slide in, elements fade, gentle parallax
- Always skippable with a tap anywhere
- Auto-advances to reward screen on completion

### Do Not Use
- MP4 / video files
- Heavy particle systems
- Full skeletal animation
- Real-time 3D

---

## Reward System

### MVP Reward per Story
- **1 star** (always awarded on completion)
- **1 badge** (story-specific, unlocked permanently)
- Gentle celebration animation (stars burst outward, badge bounces in)

### Progress Rules
- Progress is **linear**: story 2 unlocks only after story 1 is complete
- Progress is **permanent**: no way to un-earn a star (reset only via parent gate)
- Stars and badges are displayed on the story selection screen

---

## Parent Gate

### Purpose
Prevent accidental access to settings that could reset progress.

### Implementation
- Requires a **2-second press-and-hold** on a small gear/lock icon
- No PIN or complex verification for MVP
- Parent section contains: sound on/off, reset progress, future language setting

---

## MVP Non-Goals

Do not build:
- Scoring or leaderboards
- Competitive mechanics
- Stressful timers or countdowns
- Punishment animations or "fail" states
- Account creation or login
- Monetization (no ads, no IAP)
- Narration audio (v2 feature)
- Multiple languages (v2 feature)
