# LittleLights — Game Design Document

## Design Philosophy

LittleLights is a warm, encouraging space where young children experience Bible stories through play.
Every design decision should make a 4-year-old feel **capable, safe, and delighted**.

The experience has two parts that work together:
1. **Play** — assemble a puzzle to unlock the story
2. **Learn** — see the story told through illustrated scenes with simple lesson captions

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
Story Selection     (tap a story card)
    ↓
Story Intro         (one image + one short sentence + big Start button)
    ↓
Puzzle Game         (assemble 4-piece jigsaw of a symbolic scene)
    ↓
Lesson Screen       (3 story scenes with 1-sentence lesson captions; tap to advance)
    ↓
Reward              (star + badge + celebration)
    ↓
Story Selection     (next story now unlocked)
```

The loop is linear. There is no branching, no failure exit, no dead end.

---

## The Puzzle Mechanic

### Why one universal mechanic?
- **Consistency** — children aged 4–7 learn by repetition. The same pattern across all 10 stories builds confidence and reduces confusion.
- **Story-first** — the puzzle is a gateway to the story, not the story itself. The lesson scenes do the teaching.
- **Cost-efficient** — every puzzle image is an illustration already created for the story. No extra assets needed.

### How it works
1. A symbolic scene from the story (`scene_01`) is split into **4 pieces (2×2 grid)** at runtime.
2. Pieces are placed randomly around the screen. Ghost outlines show where each piece belongs.
3. Child **drags** each piece to its target position. Pieces snap when within 30px of the target.
4. **Correct placement:** piece snaps, sparkle animation, happy sound.
5. **Wrong position:** piece gently returns to where it was. No penalty.
6. When all 4 pieces are in place: celebration animation → transition to Lesson Screen.

### Puzzle rules
- **12 pieces** for all stories (3 columns × 4 rows). Simple enough for age 4, satisfying enough for age 7.
- **Rectangular pieces** — matches portrait image proportions naturally (each piece ~180×240px at 540×960).
- **Ghost outlines** always visible — child never has to guess where pieces go.
- **No timer.** Child should never feel rushed.
- **No fail state.** Pieces always float back to their last position if dropped incorrectly.
- **Minimum piece size: 150×150 logical pixels.** Easy to grab on any device.

---

## The Lesson Screen

After the puzzle completes:

1. The assembled puzzle image glows briefly with a soft celebration.
2. **"Story Time! ✨"** appears — then fades to first lesson scene.
3. Three full-screen illustrated scenes (`scene_02`, `scene_03`, `scene_04`) are shown one by one.
4. Each scene has a **one-sentence caption** at the bottom in large, readable type.
5. Child taps anywhere to advance to the next scene.
6. After the third scene → auto-transition to Reward Screen.

### Lesson captions (per story)

| Story | Scene 2 | Scene 3 | Scene 4 |
|---|---|---|---|
| Noah | "Noah obeyed God and built the ark, even when others laughed." | "The animals came two by two — God cared for every creature." | "God put a rainbow in the sky as a promise of His love." |
| David | "When everyone was afraid, young David stepped forward." | "David trusted that God was stronger than any giant." | "One small act of courage can change everything." |
| Jonah | "Jonah ran away, but you cannot hide from God's love." | "Inside the great fish, Jonah prayed and asked for help." | "God gave Jonah a second chance. He always does." |
| Adam & Eve | "In the beginning, God made a beautiful garden full of life." | "God gave Adam the gift of naming every animal." | "Everything God made was very good." |
| Moses | "The Israelites were trapped — sea ahead, army behind." | "Moses raised his staff and trusted God completely." | "The sea parted! God always makes a way." |
| Daniel | "Daniel prayed to God every day, even when it was dangerous." | "Daniel was thrown to the lions, but he was not afraid." | "God sent an angel, and Daniel was safe. Faith protects us." |
| Good Samaritan | "A man was hurt on the road. Others walked right past." | "A Samaritan stopped to help, even though they were strangers." | "Loving your neighbor means helping anyone who needs you." |
| Zacchaeus | "Zacchaeus climbed a tree just to catch a glimpse of Jesus." | "Jesus called out — 'Come down, I want to visit you today!'" | "Being truly seen and loved changed Zacchaeus's heart forever." |
| Feeding 5,000 | "Thousands were hungry and there was almost no food." | "A boy shared his small lunch — 5 loaves and 2 fish." | "Jesus blessed it, and everyone ate until they were full." |
| Creation | "In six days, God made light, sky, land, stars, creatures, and people." | "Each day God looked at what He made and said, 'It is good.'" | "On the seventh day, God rested and called it holy." |

---

## UX Rules (non-negotiable)

- **Minimum tap/drag target: 80×80 logical pixels.** Puzzle pieces: 150×150 minimum.
- **No punishment mechanics.** Dropped pieces return to position. No fail screens. No lives lost.
- **No countdown timers.** Children should never feel rushed.
- **No required reading.** Lesson captions are bonus — the illustration communicates first.
- **Session length target: 30 seconds – 2 minutes.**
- **3-tap-to-game rule.** Child must reach and start a puzzle in 3 taps from the home screen.

---

## Feedback Rules

| Event | Response |
|---|---|
| Piece placed correctly | Snap + sparkle + happy sound |
| Piece dropped incorrectly | Gentle float back to origin + soft sound |
| All pieces placed | Full celebration → glow → transition to lesson |
| Lesson scene tap | Smooth cross-fade to next scene |
| Reward earned | Stars burst outward, badge bounces in |

**No red X. No "wrong" text. No score counter. No lives.**

---

## Story Roster (Chronological Order)

| # | StoryId | Story | Bible Reference | Theme | Puzzle Scene | Status |
|---|---|---|---|---|---|---|
| 1 | `creation` | Creation | Genesis 1 | Wonder / Gratitude | The completed creation | 🔜 Wave 7 |
| 2 | `adam` | Adam & Eve | Genesis 2–3 | Stewardship / Care | Adam in the garden with animals | ✅ Assets ready |
| 3 | `noah` | Noah's Ark | Genesis 6–9 | Obedience / Trust | Noah with animals boarding ark | ✅ Assets ready |
| 4 | `moses` | Moses & the Red Sea | Exodus 14 | Trust / Courage | The sea parting | 🔜 Wave 7 |
| 5 | `david` | David & Goliath | 1 Samuel 17 | Courage | David facing Goliath | ✅ Assets ready |
| 6 | `jonah` | Jonah | Jonah 1–3 | Obedience / Second chances | Jonah and the great fish | ✅ Assets ready |
| 7 | `daniel` | Daniel & the Lions | Daniel 6 | Courage / Faith | Daniel praying in the den | 🔜 Wave 7 |
| 8 | `samaritan` | Good Samaritan | Luke 10 | Kindness / Helping | Samaritan helping the wounded man | 🔜 Wave 7 |
| 9 | `feeding` | Feeding the 5,000 | Mark 6 | Generosity / Trust | Jesus blessing the loaves and fish | 🔜 Wave 7 |
| 10 | `zacchaeus` | Zacchaeus | Luke 19 | Forgiveness / Change | Zacchaeus in the tree | 🔜 Wave 7 |

---

## What NOT to build (MVP)

- No account system or login
- No cloud save or backend
- No in-app purchases or monetization
- No difficulty modes (no 9-piece or 16-piece puzzles yet)
- No voice narration (placeholder OK, full recording = v2)
- No advanced particle systems
- No procedural content
- No analytics or tracking

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
