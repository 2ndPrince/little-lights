/// All asset path constants for the LittleLights app.
///
/// Two formats per asset:
/// - Flutter path: full path from project root — used with [Image.asset], [AssetImage]
/// - Flame path: relative to assets/images/ or assets/audio/ — used with Flame loaders
///
/// NEVER hardcode asset path strings in widgets or game classes. Always use these constants.
abstract final class AssetPaths {
  // ── UI ──────────────────────────────────────────────────────────────────

  static const String btnPlay       = 'assets/images/ui/btn_play.png';
  static const String btnBack       = 'assets/images/ui/btn_back.png';
  static const String btnSettings   = 'assets/images/ui/btn_settings.png';
  static const String btnReplay     = 'assets/images/ui/btn_replay.png';
  static const String starReward    = 'assets/images/ui/star_reward.png';
  static const String starEmpty     = 'assets/images/ui/star_empty.png';
  static const String bgHome        = 'assets/images/ui/bg_home.png';
  static const String logo          = 'assets/images/ui/logo.png';

  // ── Noah — Flutter paths (full) ─────────────────────────────────────────

  static const String noahBgSky       = 'assets/images/stories/noah/background/background_sky.png';
  static const String noahBgGround    = 'assets/images/stories/noah/background/background_ground.png';

  static const String noahLion1       = 'assets/images/stories/noah/animals/lion_1.png';
  static const String noahLion2       = 'assets/images/stories/noah/animals/lion_2.png';
  static const String noahElephant1   = 'assets/images/stories/noah/animals/elephant_1.png';
  static const String noahElephant2   = 'assets/images/stories/noah/animals/elephant_2.png';
  static const String noahGiraffe1    = 'assets/images/stories/noah/animals/giraffe_1.png';
  static const String noahGiraffe2    = 'assets/images/stories/noah/animals/giraffe_2.png';

  static const String noahArk         = 'assets/images/stories/noah/ui/ark.png';
  static const String noahArkOpen     = 'assets/images/stories/noah/ui/ark_open.png';
  static const String noahCharacter   = 'assets/images/stories/noah/ui/noah_character.png';
  static const String noahCharHappy   = 'assets/images/stories/noah/ui/noah_happy.png';
  static const String noahCardBg      = 'assets/images/stories/noah/ui/card_bg.png';
  static const String noahBadge       = 'assets/images/stories/noah/ui/badge_noah.png';

  static const String noahScene01     = 'assets/images/stories/noah/cutscene/scene_01.png';
  static const String noahScene02     = 'assets/images/stories/noah/cutscene/scene_02.png';
  static const String noahScene03     = 'assets/images/stories/noah/cutscene/scene_03.png';
  static const String noahScene04     = 'assets/images/stories/noah/cutscene/scene_04.png';

  /// Ordered list of Noah cutscene frames for [CutscenePlayer].
  static const List<String> noahCutsceneFrames = [
    noahScene01, noahScene02, noahScene03, noahScene04,
  ];

  // ── David — Flutter paths (full) ────────────────────────────────────────

  static const String davidBgHill       = 'assets/images/stories/david/background/background_hill.png';
  static const String davidBgSky        = 'assets/images/stories/david/background/background_sky.png';
  static const String davidCharacter    = 'assets/images/stories/david/characters/david_character.png';
  static const String davidGoliath      = 'assets/images/stories/david/characters/goliath_character.png';
  static const String davidStone1       = 'assets/images/stories/david/ui/stone_1.png';
  static const String davidStone2       = 'assets/images/stories/david/ui/stone_2.png';
  static const String davidStone3       = 'assets/images/stories/david/ui/stone_3.png';
  static const String davidBadge        = 'assets/images/stories/david/ui/badge_david.png';
  static const String davidScene01      = 'assets/images/stories/david/cutscene/scene_01.png';
  static const String davidScene02      = 'assets/images/stories/david/cutscene/scene_02.png';
  static const String davidScene03      = 'assets/images/stories/david/cutscene/scene_03.png';
  static const String davidScene04      = 'assets/images/stories/david/cutscene/scene_04.png';

  /// Ordered list of David cutscene frames for [CutscenePlayer].
  static const List<String> davidCutsceneFrames = [
    davidScene01, davidScene02, davidScene03, davidScene04,
  ];

  // ── Audio — Flutter paths (full) ────────────────────────────────────────

  static const String bgmHome        = 'assets/audio/music/bgm_home.mp3';
  static const String bgmNoah        = 'assets/audio/music/bgm_noah.mp3';
  static const String bgmDavid       = 'assets/audio/music/bgm_david.mp3';

  static const String sfxTap         = 'assets/audio/sfx/sfx_tap.mp3';
  static const String sfxMatch       = 'assets/audio/sfx/sfx_match.mp3';
  static const String sfxIncorrect   = 'assets/audio/sfx/sfx_incorrect.mp3';
  static const String sfxLoadArk     = 'assets/audio/sfx/sfx_load_ark.mp3';
  static const String sfxSuccess     = 'assets/audio/sfx/sfx_success.mp3';
  static const String sfxStar        = 'assets/audio/sfx/sfx_star.mp3';
  static const String sfxBadge       = 'assets/audio/sfx/sfx_badge.mp3';

  // ── Noah — Flame paths (relative to assets/images/) ─────────────────────

  static const String flameNoahBgSky      = 'stories/noah/background/background_sky.png';
  static const String flameNoahBgGround   = 'stories/noah/background/background_ground.png';
  static const String flameNoahLion1      = 'stories/noah/animals/lion_1.png';
  static const String flameNoahLion2      = 'stories/noah/animals/lion_2.png';
  static const String flameNoahElephant1  = 'stories/noah/animals/elephant_1.png';
  static const String flameNoahElephant2  = 'stories/noah/animals/elephant_2.png';
  static const String flameNoahGiraffe1   = 'stories/noah/animals/giraffe_1.png';
  static const String flameNoahGiraffe2   = 'stories/noah/animals/giraffe_2.png';
  static const String flameNoahArk        = 'stories/noah/ui/ark.png';
  static const String flameNoahCharacter  = 'stories/noah/ui/noah_character.png';

  // ── Audio — Flame paths (relative to assets/audio/) ─────────────────────

  static const String flameSfxTap       = 'sfx/sfx_tap.mp3';
  static const String flameSfxMatch     = 'sfx/sfx_match.mp3';
  static const String flameSfxIncorrect = 'sfx/sfx_incorrect.mp3';
  static const String flameSfxLoadArk   = 'sfx/sfx_load_ark.mp3';
  static const String flameSfxSuccess   = 'sfx/sfx_success.mp3';
  static const String flameBgmNoah      = 'music/bgm_noah.mp3';

  // ── David — Flame paths (relative to assets/images/) ────────────────────

  static const String flameDavidBgHill     = 'stories/david/background/background_hill.png';
  static const String flameDavidBgSky      = 'stories/david/background/background_sky.png';
  static const String flameDavidCharacter  = 'stories/david/characters/david_character.png';
  static const String flameDavidGoliath    = 'stories/david/characters/goliath_character.png';
  static const String flameDavidStone1     = 'stories/david/ui/stone_1.png';
  static const String flameDavidStone2     = 'stories/david/ui/stone_2.png';
  static const String flameDavidStone3     = 'stories/david/ui/stone_3.png';
  static const String flameBgmDavid        = 'music/bgm_david.mp3';
}
