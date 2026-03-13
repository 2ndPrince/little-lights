# LittleLights — Asset Guide

This is the contract between all developers and agents working on this project.
Asset paths in code must match this document exactly.

---

## Directory Structure

```
assets/
├── images/
│   ├── ui/                              # App-wide UI elements
│   │   ├── btn_play.png
│   │   ├── btn_back.png
│   │   ├── btn_settings.png
│   │   ├── btn_replay.png
│   │   ├── star_reward.png
│   │   ├── star_empty.png
│   │   ├── bg_home.png
│   │   └── logo.png
│   │
│   └── stories/
│       └── noah/
│           ├── background/
│           │   ├── background_sky.png
│           │   └── background_ground.png
│           ├── animals/
│           │   ├── lion_1.png           # First of the lion pair
│           │   ├── lion_2.png           # Second of the lion pair
│           │   ├── elephant_1.png
│           │   ├── elephant_2.png
│           │   ├── giraffe_1.png
│           │   └── giraffe_2.png
│           ├── ui/
│           │   ├── ark.png
│           │   ├── ark_open.png         # Ark with doors open (loading state)
│           │   ├── noah_character.png
│           │   ├── noah_happy.png
│           │   ├── card_bg.png          # Animal card background frame
│           │   └── badge_noah.png       # Noah completion badge
│           └── cutscene/
│               ├── scene_01.png         # Noah standing near ark
│               ├── scene_02.png         # Animals entering ark
│               ├── scene_03.png         # Rain / clouds appearing
│               └── scene_04.png         # Happy completion / rainbow hint
│
├── audio/
│   ├── music/
│   │   ├── bgm_home.mp3                 # Home + story select BGM
│   │   └── bgm_noah.mp3                 # Noah game + cutscene BGM
│   └── sfx/
│       ├── sfx_tap.mp3                  # Generic button tap
│       ├── sfx_match.mp3                # Animal pair matched
│       ├── sfx_incorrect.mp3            # Wrong tap (soft)
│       ├── sfx_load_ark.mp3             # Pair loaded into ark
│       ├── sfx_success.mp3              # Game completed
│       ├── sfx_star.mp3                 # Star awarded
│       └── sfx_badge.mp3               # Badge unlocked
│
└── fonts/
    └── rounded_font.ttf                 # Child-friendly rounded typeface
```

---

## Naming Convention Rules

| Category | Pattern | Example |
|---|---|---|
| UI buttons | `btn_{action}.png` | `btn_play.png` |
| Backgrounds | `bg_{location}.png` or `background_{element}.png` | `bg_home.png` |
| Character sprites | `{name}_{state}.png` | `noah_happy.png` |
| Animal cards | `{animal}_{1 or 2}.png` | `lion_1.png` |
| Story badge | `badge_{storyId}.png` | `badge_noah.png` |
| Cutscene frames | `scene_{02d}.png` | `scene_01.png`, `scene_02.png` |
| BGM | `bgm_{context}.mp3` | `bgm_noah.mp3` |
| SFX | `sfx_{event}.mp3` | `sfx_match.mp3` |

**Rules:**
- Always lowercase, always snake_case
- No spaces, no capital letters, no special characters except underscores
- Cutscene frames must be zero-padded 2 digits (`scene_01` not `scene_1`)

---

## How Flutter Loads Assets

Flutter requires the **full path from project root**:

```dart
// ✅ Correct
Image.asset('assets/images/stories/noah/ui/ark.png')
AssetImage('assets/images/ui/star_reward.png')

// ❌ Wrong — missing assets/ prefix
Image.asset('images/stories/noah/ui/ark.png')
```

All Flutter paths are constants in `lib/constants/asset_paths.dart`.

---

## How Flame Loads Assets

Flame resolves **relative to `assets/images/`** for images and **relative to `assets/audio/`** for audio:

```dart
// ✅ Correct — inside a FlameGame or Component
final sprite = await images.load('stories/noah/ui/ark.png');
// resolves to: assets/images/stories/noah/ui/ark.png

await FlameAudio.play('sfx/sfx_match.mp3');
// resolves to: assets/audio/sfx/sfx_match.mp3

// ❌ Wrong — don't include assets/images/ prefix in Flame
final sprite = await images.load('assets/images/stories/noah/ui/ark.png');
```

Flame paths are also declared in `lib/constants/asset_paths.dart` with a `flame` prefix on the constant name:

```dart
class AssetPaths {
  // Flutter paths (full)
  static const String noahArk          = 'assets/images/stories/noah/ui/ark.png';
  static const String sfxMatch         = 'assets/audio/sfx/sfx_match.mp3';

  // Flame paths (relative)
  static const String flameNoahArk     = 'stories/noah/ui/ark.png';
  static const String flameSfxMatch    = 'sfx/sfx_match.mp3';
}
```

---

## pubspec.yaml Declarations

Declare all directories (not individual files):

```yaml
flutter:
  assets:
    - assets/images/ui/
    - assets/images/stories/noah/background/
    - assets/images/stories/noah/animals/
    - assets/images/stories/noah/ui/
    - assets/images/stories/noah/cutscene/
    - assets/audio/music/
    - assets/audio/sfx/
  fonts:
    - family: RoundedFont
      fonts:
        - asset: assets/fonts/rounded_font.ttf
```

**When adding a new story**, add its 4 image subdirectories to `pubspec.yaml`.

---

## Placeholder Asset Strategy

During development, use placeholder assets so all tracks can run simultaneously.

### Image Placeholders
Each placeholder is a **colored rectangle with a label** at the correct output dimensions.
Create them as PNG files using any graphics tool or script.

| Asset | Placeholder color | Dimensions |
|---|---|---|
| Animal cards (lion, etc.) | Orange `#F4A261` | 120×120 px |
| Ark | Brown `#8B6347` | 200×300 px |
| Noah character | Tan `#D4A76A` | 100×200 px |
| Backgrounds | Sky blue `#C8E6F5` | 1080×1920 px (or 375×667 pt) |
| Cutscene frames | Soft green `#B5D99C` | 1080×1920 px |
| UI buttons | Warm yellow `#F9E4B7` | 200×80 px |
| Badges | Gold `#FFD700` | 120×120 px |

### Audio Placeholders
All audio slots must be filled with a **1-second silent MP3** during development.
This prevents asset-not-found errors at runtime.

Create silent MP3:
```bash
# Using ffmpeg (install via homebrew):
ffmpeg -f lavfi -i anullsrc=r=44100:cl=stereo -t 1 -q:a 9 -acodec libmp3lame silent.mp3
# Then copy to each required audio slot
```

### Verifying All Assets Are Present
```bash
flutter pub get && flutter run --debug
# Zero asset errors in console = placeholder pipeline complete
```

---

## Resolution Requirements (Final Art)

### Images
| Usage | Minimum | Preferred |
|---|---|---|
| UI icons / buttons | 2x (`@2.0x`) | 3x (`@3.0x`) |
| Character sprites | 2x | 3x |
| Backgrounds | 1080×1920 px | 1242×2688 px |
| Animal cards | 240×240 px | 360×360 px |
| Cutscene frames | 1080×1920 px | Full bleed |
| Badges | 240×240 px | 360×360 px |

Flutter selects resolution automatically based on device pixel ratio when you provide `@2.0x` and `@3.0x` variants:
```
assets/images/stories/noah/animals/lion_1.png         ← 1x (fallback)
assets/images/stories/noah/animals/2.0x/lion_1.png    ← 2x
assets/images/stories/noah/animals/3.0x/lion_1.png    ← 3x
```

### Audio
| Type | Format | Max size |
|---|---|---|
| BGM (background music) | MP3 (128kbps) | 2 MB |
| SFX (sound effects) | MP3 (128kbps) | 200 KB |
| All audio | Sample rate: 44100 Hz | Stereo |

---

## Adding Assets for a New Story (Checklist)

When adding a story beyond Noah, follow this checklist:

- [ ] Create `assets/images/stories/{storyId}/` with 4 subdirs: `background/`, `animals/` or `objects/`, `ui/`, `cutscene/`
- [ ] Add `.gitkeep` to each new directory immediately
- [ ] Add all 4 new directory entries to `pubspec.yaml`
- [ ] Create placeholder images for every listed asset
- [ ] Create placeholder silent MP3 for `bgm_{storyId}.mp3`
- [ ] Add new asset path constants to `lib/constants/asset_paths.dart`
- [ ] Run `flutter pub get` and `flutter run` — confirm zero asset errors
- [ ] Replace placeholders with final art when ready
