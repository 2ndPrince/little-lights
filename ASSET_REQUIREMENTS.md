# LittleLights — Asset Requirements

> Hand this file to an artist or AI image/audio generator.
> Every asset listed here is currently a placeholder (1×1 pixel PNG or silent MP3).
> Replace each file at the exact path shown — the app will pick it up automatically.
>
> **Art direction:** Read `ART_DIRECTION.md` for the full visual identity guide before generating any asset.
> The mandatory AI prompt base phrase is: *"soft children's storybook illustration, warm pastel colors, rounded shapes, gentle lighting, simple friendly character design"*

## Art Style Guide (apply to all images)

- **Style:** Soft Flat Storybook — hybrid of flat illustration + soft watercolor warmth
- **Palette:** Warm cream `#FFF8EC`, sky blue `#C8E6F5`, soft green `#B5D99C`, accent orange `#F4A261`, soft brown `#C9A27C` — never pure black, never pure white
- **Shapes:** Rounded, soft edges, no sharp corners
- **Characters:** Large heads, simple dot/oval eyes, soft curved smile, 2–3 heads tall (storybook proportions)
- **Mood:** Calm, encouraging, safe — if it looks exciting it is wrong; if it looks calming it is correct
- **Target age:** 4–7 years old
- **No text in images** (text is handled by the app)
- **Forbidden styles:** Anime, realistic painting, 3D renders, pixel art, dark fantasy, comic book style

---

## Audio Style Guide (apply to all audio)

- **Format:** MP3, 44100 Hz, stereo, 128–192 kbps
- **Mood:** Warm, gentle, playful — no harsh sounds
- **BGM:** Loopable (loop point must be seamless), no abrupt ending
- **SFX:** Short, punchy, positive — under 2 seconds each
- **No voice/narration** in MVP — music and effects only

---

## 1. Global UI Images

| File name | Save to | Used in | Size (px) | Description |
|---|---|---|---|---|
| `logo.png` | `assets/images/ui/logo.png` | HomeScreen — center | 400 × 200 | App logo "LittleLights" — warm sun or glowing lantern motif, soft rounded lettering |
| `bg_home.png` | `assets/images/ui/bg_home.png` | HomeScreen — full background | 1080 × 1920 | Soft pastel outdoor scene — rolling hills, soft clouds, warm sky. No characters. |
| `btn_play.png` | `assets/images/ui/btn_play.png` | HomeScreen — Play button, also used as placeholder thumbnail for locked stories | 320 × 160 | Large rounded orange button with a play triangle icon |
| `btn_back.png` | `assets/images/ui/btn_back.png` | All screens — back navigation | 80 × 80 | Simple left-arrow icon, white on transparent, rounded |
| `btn_settings.png` | `assets/images/ui/btn_settings.png` | HomeScreen — gear/settings icon | 80 × 80 | Soft gear or cog icon, warm brown on transparent |
| `btn_replay.png` | `assets/images/ui/btn_replay.png` | RewardScreen — Play Again button | 80 × 80 | Circular replay arrow icon, orange on transparent |
| `star_reward.png` | `assets/images/ui/star_reward.png` | RewardScreen — earned star (×1–3) | 144 × 144 | Gold filled star, soft glow, rounded points |
| `star_empty.png` | `assets/images/ui/star_empty.png` | RewardScreen — unearned star slot | 144 × 144 | Same star outline, grey/muted, no glow |

---

## 2. Noah's Ark — Animal Cards (Game)

> Rendered inside the Flame game at **100×100 logical pixels** on screen.
> Export at **200×200 px** (2× for retina).
> Transparent background (PNG).
> Each animal should be a cute full-body or head+body view facing slightly right.

| File name | Save to | Animal | Notes |
|---|---|---|---|
| `lion_1.png` | `assets/images/stories/noah/animals/lion_1.png` | Lion (card 1 of pair) | Male lion, mane, friendly smile |
| `lion_2.png` | `assets/images/stories/noah/animals/lion_2.png` | Lion (card 2 of pair) | Identical or slightly mirrored — must look like a matching pair |
| `elephant_1.png` | `assets/images/stories/noah/animals/elephant_1.png` | Elephant (card 1 of pair) | Grey, big ears, upturned trunk |
| `elephant_2.png` | `assets/images/stories/noah/animals/elephant_2.png` | Elephant (card 2 of pair) | Matching pair |
| `giraffe_1.png` | `assets/images/stories/noah/animals/giraffe_1.png` | Giraffe (card 1 of pair) | Long neck, spots, gentle expression |
| `giraffe_2.png` | `assets/images/stories/noah/animals/giraffe_2.png` | Giraffe (card 2 of pair) | Matching pair |

---

## 3. Noah's Ark — Backgrounds (Game)

> These fill the Flame game canvas — rendered at full screen size.
> Export at **1080 × 1920 px** (portrait). No transparency needed.

| File name | Save to | Used in | Description |
|---|---|---|---|
| `background_sky.png` | `assets/images/stories/noah/background/background_sky.png` | Noah game background (top half) + Noah intro overlay | Soft blue sky with fluffy white clouds, maybe a rainbow hint. Warm and peaceful. |
| `background_ground.png` | `assets/images/stories/noah/background/background_ground.png` | Noah game background (bottom half) | Green rolling ground/hills near water. Simple, not distracting. |

---

## 4. Noah's Ark — UI & Characters

| File name | Save to | Used in | Size (px) | Description |
|---|---|---|---|---|
| `ark.png` | `assets/images/stories/noah/ui/ark.png` | Story selection card thumbnail + Flame game ark zone | 560 × 360 | Wooden ark on water, rounded hull, brown tones, friendly proportions. Transparent background. |
| `ark_open.png` | `assets/images/stories/noah/ui/ark_open.png` | Flame game — ark door open state (when pair is loaded) | 560 × 360 | Same ark with door/ramp visibly open |
| `noah_character.png` | `assets/images/stories/noah/ui/noah_character.png` | Flame game — Noah standing near ark | 200 × 300 | Friendly bearded man in simple robes, smiling, arms open. Transparent background. |
| `noah_happy.png` | `assets/images/stories/noah/ui/noah_happy.png` | Flame game — Noah celebration pose | 200 × 300 | Same Noah character, arms raised in celebration |
| `card_bg.png` | `assets/images/stories/noah/ui/card_bg.png` | Animal card background texture | 200 × 200 | Soft wooden or parchment texture tile — warm beige tones |
| `badge_noah.png` | `assets/images/stories/noah/ui/badge_noah.png` | RewardScreen — Noah completion badge | 320 × 320 | Circular badge. Ark icon in center, golden border, "Ark Builder" label optional. Transparent background. |

---

## 5. Noah's Ark — Cutscene Frames

> These are full-screen story frames shown after the mini-game, one at a time (600ms each).
> Export at **1080 × 1920 px** portrait. No transparency needed.
> Together they tell a 4-frame mini-story. Each frame should flow naturally into the next.

| File name | Save to | Frame # | Scene description |
|---|---|---|---|
| `scene_01.png` | `assets/images/stories/noah/cutscene/scene_01.png` | Frame 1 | Noah stands outside the ark, animals lined up behind him. Sky is sunny and bright. |
| `scene_02.png` | `assets/images/stories/noah/cutscene/scene_02.png` | Frame 2 | Animals walking up the ramp into the ark — lion, elephant, giraffe visible. |
| `scene_03.png` | `assets/images/stories/noah/cutscene/scene_03.png` | Frame 3 | Dark clouds gather, rain begins to fall. Noah is inside the ark, door closing. |
| `scene_04.png` | `assets/images/stories/noah/cutscene/scene_04.png` | Frame 4 | Ark floating on calm water. Rainbow in the sky. Noah waves from a window. Happy ending. |

---

## 6. David and Goliath — Backgrounds (Game)

> Full screen Flame game canvas. Export at **1080 × 1920 px** portrait. No transparency needed.

| File name | Save to | Used in | Description |
|---|---|---|---|
| `background_hill.png` | `assets/images/stories/david/background/background_hill.png` | David game background + intro overlay | Rolling green hillside with a river/stream at the bottom. Soft blue sky. Sunny and peaceful. |
| `background_sky.png` | `assets/images/stories/david/background/background_sky.png` | David intro overlay fallback | Soft blue sky with gentle clouds. Same palette as Noah sky. |

---

## 7. David and Goliath — Characters

> Transparent background (PNG).

| File name | Save to | Size (px) | Description |
|---|---|---|---|
| `david_character.png` | `assets/images/stories/david/characters/david_character.png` | 200 × 300 | Young shepherd boy, small frame, simple tunic, sling in hand, confident soft smile. Olive skin. |
| `goliath_character.png` | `assets/images/stories/david/characters/goliath_character.png` | 160 × 320 | Very large rounded warrior. Simple cartoonish armor. Slightly confused expression — NOT scary or threatening. Same soft style as Noah characters. |

---

## 8. David and Goliath — UI

| File name | Save to | Used in | Size (px) | Description |
|---|---|---|---|
| `stone_1.png` | `assets/images/stories/david/ui/stone_1.png` | Flame game — tappable stone #1 | 160 × 160 | Smooth rounded river pebble, grey-brown tones. Friendly. Transparent background. |
| `stone_2.png` | `assets/images/stories/david/ui/stone_2.png` | Flame game — tappable stone #2 | 160 × 160 | Same as stone_1 — slight shape variation OK |
| `stone_3.png` | `assets/images/stories/david/ui/stone_3.png` | Flame game — tappable stone #3 | 160 × 160 | Same as stone_1 — slight shape variation OK |
| `badge_david.png` | `assets/images/stories/david/ui/badge_david.png` | RewardScreen — David completion badge | 320 × 320 | Circular badge. Sling or star icon in center, golden border. "Brave Heart" label optional. Transparent background. |

---

## 9. David and Goliath — Cutscene Frames

> Full-screen story frames shown after the mini-game. Export at **1080 × 1920 px** portrait. No transparency.

| File name | Save to | Frame # | Scene description |
|---|---|---|---|
| `scene_01.png` | `assets/images/stories/david/cutscene/scene_01.png` | Frame 1 | David stands by the river, picking up stones. Goliath visible in the distance on a hill. |
| `scene_02.png` | `assets/images/stories/david/cutscene/scene_02.png` | Frame 2 | David swings his sling. Brave expression. Bright sunny sky behind him. |
| `scene_03.png` | `assets/images/stories/david/cutscene/scene_03.png` | Frame 3 | Goliath tumbles backwards — cartoonish, not violent. Big swirly eyes. |
| `scene_04.png` | `assets/images/stories/david/cutscene/scene_04.png` | Frame 4 | David and the people celebrate. Rainbow or sunshine. Joyful, peaceful ending. |

---

## 10. Font

| File name | Save to | Used in | Requirements |
|---|---|---|---|
| `rounded_font.ttf` | `assets/fonts/rounded_font.ttf` | All text in the app | Rounded, friendly, highly legible. Minimum weight: Regular + Bold. Suggested free options: **Nunito**, **Fredoka One**, **Baloo 2**, **Quicksand**. Must be OFL/free license. |

---

## 11. Audio — Background Music

| File name | Save to | Used in | Duration | Description |
|---|---|---|---|---|
| `bgm_home.mp3` | `assets/audio/music/bgm_home.mp3` | HomeScreen (loops while on screen) | 60–90 sec loop | Gentle, warm, welcoming. Soft piano or acoustic guitar with light percussion. Child-friendly. Seamless loop. |
| `bgm_noah.mp3` | `assets/audio/music/bgm_noah.mp3` | Noah mini-game (loops during gameplay) | 60–90 sec loop | Playful and adventurous but calm. Animal-themed if possible (marimba, light woodwinds). Seamless loop. |
| `bgm_david.mp3` | `assets/audio/music/bgm_david.mp3` | David mini-game (loops during gameplay) | 60–90 sec loop | Brave and hopeful but gentle. Soft drums, simple melody, not dramatic. Seamless loop. |

---

## 12. Audio — Sound Effects

| File name | Save to | Triggered when | Duration | Description |
|---|---|---|---|---|
| `sfx_tap.mp3` | `assets/audio/sfx/sfx_tap.mp3` | Child taps an animal card (selects it) | < 0.3 sec | Soft, light tap sound — like a gentle xylophone note or wood block |
| `sfx_match.mp3` | `assets/audio/sfx/sfx_match.mp3` | Two matching animal cards are paired correctly | < 0.5 sec | Cheerful ascending two-note chime — happy, bright |
| `sfx_incorrect.mp3` | `assets/audio/sfx/sfx_incorrect.mp3` | Two non-matching cards are tapped | < 0.5 sec | Soft, gentle "womp" or low note — NOT harsh or scary. Should feel like "try again" not "you failed" |
| `sfx_load_ark.mp3` | `assets/audio/sfx/sfx_load_ark.mp3` | Matched pair is loaded into the ark | < 0.7 sec | Satisfying wooden thud or door-closing sound — warm, solid |
| `sfx_success.mp3` | `assets/audio/sfx/sfx_success.mp3` | All pairs matched — game complete | 1.5–2 sec | Full celebration jingle — ascending notes, triumphant but gentle. Not too loud. |
| `sfx_star.mp3` | `assets/audio/sfx/sfx_star.mp3` | Star animates in on RewardScreen | < 0.5 sec | Single bright sparkle/twinkle sound |
| `sfx_badge.mp3` | `assets/audio/sfx/sfx_badge.mp3` | Badge slides in on RewardScreen | < 0.7 sec | Soft "reveal" shimmer sound — like a gentle fanfare hit |

---

## Summary Counts

| Category | Count | Status |
|---|---|---|
| UI images | 8 | ⚠️ All placeholders |
| Noah animal cards | 6 | ⚠️ All placeholders |
| Noah backgrounds | 2 | ⚠️ All placeholders |
| Noah UI + characters | 6 | ⚠️ All placeholders |
| Noah cutscene frames | 4 | ⚠️ All placeholders |
| David backgrounds | 2 | ⚠️ All placeholders |
| David characters | 2 | ⚠️ All placeholders |
| David UI + stones | 4 | ⚠️ All placeholders |
| David cutscene frames | 4 | ⚠️ All placeholders |
| Font | 1 | ⚠️ Placeholder (replace with Nunito or similar) |
| BGM tracks | 3 | ⚠️ All silent |
| SFX clips | 7 | ⚠️ All silent |
| **Total** | **49** | **0 real assets** |

---

## How to Replace an Asset

1. Generate or obtain the asset matching the spec above
2. Save it to the exact file path shown in the table
3. The app loads it automatically — no code changes needed
4. Run `flutter run -d chrome` to verify it looks correct

> Note: PNG files must use RGB or RGBA colour space. Avoid CMYK.
> Audio must be MP3 — do not use WAV, AAC, or OGG (audioplayers web support).
