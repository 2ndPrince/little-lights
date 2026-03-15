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

  // ── Jonah — Flutter paths (full) ────────────────────────────────────────

  static const String jonahBgOcean  = 'assets/images/stories/jonah/background/background_ocean.png';
  static const String jonahBadge    = 'assets/images/stories/jonah/ui/badge_jonah.png';
  static const String jonahScene01  = 'assets/images/stories/jonah/cutscene/scene_01.png';
  static const String jonahScene02  = 'assets/images/stories/jonah/cutscene/scene_02.png';
  static const String jonahScene03  = 'assets/images/stories/jonah/cutscene/scene_03.png';
  static const String jonahScene04  = 'assets/images/stories/jonah/cutscene/scene_04.png';

  /// Ordered list of Jonah cutscene frames for [CutscenePlayer].
  static const List<String> jonahCutsceneFrames = [
    jonahScene01, jonahScene02, jonahScene03, jonahScene04,
  ];

  // ── Jonah — Flame paths (relative to assets/images/) ────────────────────

  static const String flameJonahBgOcean = 'stories/jonah/background/background_ocean.png';
  static const String flameJonahCloud1  = 'stories/jonah/ui/cloud_1.png';
  static const String flameJonahCloud2  = 'stories/jonah/ui/cloud_2.png';
  static const String flameJonahCloud3  = 'stories/jonah/ui/cloud_3.png';
  static const String flameJonahBoat    = 'stories/jonah/characters/jonah_boat.png';
  /// Reuses Noah BGM as a placeholder until a dedicated Jonah track is recorded.
  static const String flameBgmJonah     = 'music/bgm_noah.mp3';

  // ── Adam — Flutter paths (full) ─────────────────────────────────────────

  static const String adamBgGarden = 'assets/images/stories/adam/background/background_garden.png';
  static const String adamBadge    = 'assets/images/stories/adam/ui/badge_adam.png';
  static const String adamScene01  = 'assets/images/stories/adam/cutscene/scene_01.png';
  static const String adamScene02  = 'assets/images/stories/adam/cutscene/scene_02.png';
  static const String adamScene03  = 'assets/images/stories/adam/cutscene/scene_03.png';
  static const String adamScene04  = 'assets/images/stories/adam/cutscene/scene_04.png';

  /// Ordered list of Adam cutscene frames for [CutscenePlayer].
  static const List<String> adamCutsceneFrames = [
    adamScene01, adamScene02, adamScene03, adamScene04,
  ];

  // ── Adam — Flame paths (relative to assets/images/) ─────────────────────

  static const String flameAdamBgGarden   = 'stories/adam/background/background_garden.png';
  static const String flameAdamLion       = 'stories/adam/animals/adam_lion.png';
  static const String flameAdamElephant   = 'stories/adam/animals/adam_elephant.png';
  static const String flameAdamGiraffe    = 'stories/adam/animals/adam_giraffe.png';
  static const String flameAdamBird       = 'stories/adam/animals/adam_bird.png';
  static const String flameAdamCharacter  = 'stories/adam/characters/adam_character.png';
  /// Reuses home BGM as a placeholder until a dedicated Adam track is recorded.
  static const String flameBgmAdam        = 'music/bgm_home.mp3';

  // ── Moses — Flutter paths (full) ────────────────────────────────────────

  static const String mosesBgDesert  = 'assets/images/stories/moses/background/background_desert.png';
  static const String mosesWallLeft  = 'assets/images/stories/moses/ui/water_wall_left.png';
  static const String mosesWallRight = 'assets/images/stories/moses/ui/water_wall_right.png';
  static const String mosesIsraelites = 'assets/images/stories/moses/characters/israelites.png';
  static const String mosesBadge     = 'assets/images/stories/moses/ui/badge_moses.png';
  static const String mosesScene01   = 'assets/images/stories/moses/cutscene/scene_01.png';
  static const String mosesScene02   = 'assets/images/stories/moses/cutscene/scene_02.png';
  static const String mosesScene03   = 'assets/images/stories/moses/cutscene/scene_03.png';
  static const String mosesScene04   = 'assets/images/stories/moses/cutscene/scene_04.png';

  /// Ordered list of Moses cutscene frames for [CutscenePlayer].
  static const List<String> mosesCutsceneFrames = [
    mosesScene01, mosesScene02, mosesScene03, mosesScene04,
  ];

  // ── Moses — Flame paths (relative to assets/images/) ────────────────────

  static const String flameMosesBgDesert   = 'stories/moses/background/background_desert.png';
  static const String flameMosesWallLeft   = 'stories/moses/ui/water_wall_left.png';
  static const String flameMosesWallRight  = 'stories/moses/ui/water_wall_right.png';
  static const String flameMosesIsraelites = 'stories/moses/characters/israelites.png';
  /// Reuses Noah BGM as a placeholder until a dedicated Moses track is recorded.
  static const String flameBgmMoses        = 'music/bgm_noah.mp3';

  // ── Daniel — Flutter paths (full) ───────────────────────────────────────

  static const String danielBgCave   = 'assets/images/stories/daniel/background/background_cave.png';
  static const String danielLion1    = 'assets/images/stories/daniel/characters/lion_1.png';
  static const String danielLion2    = 'assets/images/stories/daniel/characters/lion_2.png';
  static const String danielLion3    = 'assets/images/stories/daniel/characters/lion_3.png';
  static const String danielBadge    = 'assets/images/stories/daniel/ui/badge_daniel.png';
  static const String danielScene01  = 'assets/images/stories/daniel/cutscene/scene_01.png';
  static const String danielScene02  = 'assets/images/stories/daniel/cutscene/scene_02.png';
  static const String danielScene03  = 'assets/images/stories/daniel/cutscene/scene_03.png';
  static const String danielScene04  = 'assets/images/stories/daniel/cutscene/scene_04.png';

  /// Ordered list of Daniel cutscene frames for [CutscenePlayer].
  static const List<String> danielCutsceneFrames = [
    danielScene01, danielScene02, danielScene03, danielScene04,
  ];

  // ── Daniel — Flame paths (relative to assets/images/) ───────────────────

  static const String flameDanielBgCave  = 'stories/daniel/background/background_cave.png';
  static const String flameDanielLion1   = 'stories/daniel/characters/lion_1.png';
  static const String flameDanielLion2   = 'stories/daniel/characters/lion_2.png';
  static const String flameDanielLion3   = 'stories/daniel/characters/lion_3.png';
  /// Reuses David BGM as a placeholder until a dedicated Daniel track is recorded.
  static const String flameBgmDaniel     = 'music/bgm_david.mp3';

  // ── Samaritan — Flutter paths (full) ────────────────────────────────────

  static const String samaritanBgRoad    = 'assets/images/stories/samaritan/background/background_road.png';
  static const String samaritanWounded   = 'assets/images/stories/samaritan/characters/wounded_man.png';
  static const String samaritanCharacter = 'assets/images/stories/samaritan/characters/samaritan.png';
  static const String samaritanBandage   = 'assets/images/stories/samaritan/ui/item_bandage.png';
  static const String samaritanWater     = 'assets/images/stories/samaritan/ui/item_water.png';
  static const String samaritanBread     = 'assets/images/stories/samaritan/ui/item_bread.png';
  static const String samaritanBadge     = 'assets/images/stories/samaritan/ui/badge_samaritan.png';
  static const String samaritanScene01   = 'assets/images/stories/samaritan/cutscene/scene_01.png';
  static const String samaritanScene02   = 'assets/images/stories/samaritan/cutscene/scene_02.png';
  static const String samaritanScene03   = 'assets/images/stories/samaritan/cutscene/scene_03.png';
  static const String samaritanScene04   = 'assets/images/stories/samaritan/cutscene/scene_04.png';

  /// Ordered list of Samaritan cutscene frames for [CutscenePlayer].
  static const List<String> samaritanCutsceneFrames = [
    samaritanScene01, samaritanScene02, samaritanScene03, samaritanScene04,
  ];

  // ── Samaritan — Flame paths (relative to assets/images/) ────────────────

  static const String flameSamaritanBgRoad    = 'stories/samaritan/background/background_road.png';
  static const String flameSamaritanWounded   = 'stories/samaritan/characters/wounded_man.png';
  static const String flameSamaritanBandage   = 'stories/samaritan/ui/item_bandage.png';
  static const String flameSamaritanWater     = 'stories/samaritan/ui/item_water.png';
  static const String flameSamaritanBread     = 'stories/samaritan/ui/item_bread.png';
  /// Reuses home BGM as a placeholder until a dedicated Samaritan track is recorded.
  static const String flameBgmSamaritan       = 'music/bgm_home.mp3';

  // ── Zacchaeus — Flutter paths (full) ────────────────────────────────────

  static const String zacchaeusBackground  = 'assets/images/stories/zacchaeus/background/background_street.png';
  static const String zacchaeusCharacter   = 'assets/images/stories/zacchaeus/characters/zacchaeus.png';
  static const String zacchaeusJesus       = 'assets/images/stories/zacchaeus/characters/jesus.png';
  static const String zacchaesuBranch1     = 'assets/images/stories/zacchaeus/ui/branch_1.png';
  static const String zacchaesuBranch2     = 'assets/images/stories/zacchaeus/ui/branch_2.png';
  static const String zacchaesuBranch3     = 'assets/images/stories/zacchaeus/ui/branch_3.png';
  static const String zacchaesuBadge       = 'assets/images/stories/zacchaeus/ui/badge_zacchaeus.png';
  static const String zacchaeusScene01     = 'assets/images/stories/zacchaeus/cutscene/scene_01.png';
  static const String zacchaeusScene02     = 'assets/images/stories/zacchaeus/cutscene/scene_02.png';
  static const String zacchaeusScene03     = 'assets/images/stories/zacchaeus/cutscene/scene_03.png';
  static const String zacchaeusScene04     = 'assets/images/stories/zacchaeus/cutscene/scene_04.png';

  /// Ordered list of Zacchaeus cutscene frames for [CutscenePlayer].
  static const List<String> zacchaesuCutsceneFrames = [
    zacchaeusScene01, zacchaeusScene02, zacchaeusScene03, zacchaeusScene04,
  ];

  // ── Zacchaeus — Flame paths (relative to assets/images/) ────────────────

  static const String flameZacchaeusBackground = 'stories/zacchaeus/background/background_street.png';
  static const String flameZacchaeusCharacter  = 'stories/zacchaeus/characters/zacchaeus.png';
  static const String flameZacchaesuBranch1    = 'stories/zacchaeus/ui/branch_1.png';
  static const String flameZacchaesuBranch2    = 'stories/zacchaeus/ui/branch_2.png';
  static const String flameZacchaesuBranch3    = 'stories/zacchaeus/ui/branch_3.png';
  /// Reuses home BGM as a placeholder until a dedicated Zacchaeus track is recorded.
  static const String flameBgmZacchaeus        = 'music/bgm_home.mp3';

  // ── Feeding — Flutter paths (full) ──────────────────────────────────────

  static const String feedingBgHillside = 'assets/images/stories/feeding/background/background_hillside.png';
  static const String feedingBoy        = 'assets/images/stories/feeding/characters/boy.png';
  static const String feedingLoaf1      = 'assets/images/stories/feeding/ui/loaf_1.png';
  static const String feedingLoaf2      = 'assets/images/stories/feeding/ui/loaf_2.png';
  static const String feedingLoaf3      = 'assets/images/stories/feeding/ui/loaf_3.png';
  static const String feedingLoaf4      = 'assets/images/stories/feeding/ui/loaf_4.png';
  static const String feedingLoaf5      = 'assets/images/stories/feeding/ui/loaf_5.png';
  static const String feedingFish1      = 'assets/images/stories/feeding/ui/fish_1.png';
  static const String feedingFish2      = 'assets/images/stories/feeding/ui/fish_2.png';
  static const String feedingBadge      = 'assets/images/stories/feeding/ui/badge_feeding.png';
  static const String feedingScene01    = 'assets/images/stories/feeding/cutscene/scene_01.png';
  static const String feedingScene02    = 'assets/images/stories/feeding/cutscene/scene_02.png';
  static const String feedingScene03    = 'assets/images/stories/feeding/cutscene/scene_03.png';
  static const String feedingScene04    = 'assets/images/stories/feeding/cutscene/scene_04.png';

  /// Ordered list of Feeding cutscene frames for [CutscenePlayer].
  static const List<String> feedingCutsceneFrames = [
    feedingScene01, feedingScene02, feedingScene03, feedingScene04,
  ];

  // ── Feeding — Flame paths (relative to assets/images/) ──────────────────

  static const String flameFeedingBgHillside = 'stories/feeding/background/background_hillside.png';
  static const String flameFeedingBoy        = 'stories/feeding/characters/boy.png';
  static const String flameFeedingLoaf1      = 'stories/feeding/ui/loaf_1.png';
  static const String flameFeedingLoaf2      = 'stories/feeding/ui/loaf_2.png';
  static const String flameFeedingLoaf3      = 'stories/feeding/ui/loaf_3.png';
  static const String flameFeedingLoaf4      = 'stories/feeding/ui/loaf_4.png';
  static const String flameFeedingLoaf5      = 'stories/feeding/ui/loaf_5.png';
  static const String flameFeedingFish1      = 'stories/feeding/ui/fish_1.png';
  static const String flameFeedingFish2      = 'stories/feeding/ui/fish_2.png';
  /// Reuses Noah BGM as a placeholder until a dedicated Feeding track is recorded.
  static const String flameBgmFeeding        = 'music/bgm_noah.mp3';

  // ── Creation — Flutter paths (full) ─────────────────────────────────────

  static const String creationBgVoid      = 'assets/images/stories/creation/background/background_void.png';
  static const String creationLight       = 'assets/images/stories/creation/ui/element_light.png';
  static const String creationSky         = 'assets/images/stories/creation/ui/element_sky.png';
  static const String creationLand        = 'assets/images/stories/creation/ui/element_land.png';
  static const String creationStars       = 'assets/images/stories/creation/ui/element_stars.png';
  static const String creationBirds       = 'assets/images/stories/creation/ui/element_birds.png';
  static const String creationAnimals     = 'assets/images/stories/creation/ui/element_animals.png';
  static const String creationBadge       = 'assets/images/stories/creation/ui/badge_creation.png';
  static const String creationScene01     = 'assets/images/stories/creation/cutscene/scene_01.png';
  static const String creationScene02     = 'assets/images/stories/creation/cutscene/scene_02.png';
  static const String creationScene03     = 'assets/images/stories/creation/cutscene/scene_03.png';
  static const String creationScene04     = 'assets/images/stories/creation/cutscene/scene_04.png';

  /// Ordered list of Creation cutscene frames for [CutscenePlayer].
  static const List<String> creationCutsceneFrames = [
    creationScene01, creationScene02, creationScene03, creationScene04,
  ];

  // ── Creation — Flame paths (relative to assets/images/) ─────────────────

  static const String flameCreationBgVoid   = 'stories/creation/background/background_void.png';
  static const String flameCreationLight    = 'stories/creation/ui/element_light.png';
  static const String flameCreationSky      = 'stories/creation/ui/element_sky.png';
  static const String flameCreationLand     = 'stories/creation/ui/element_land.png';
  static const String flameCreationStars    = 'stories/creation/ui/element_stars.png';
  static const String flameCreationBirds    = 'stories/creation/ui/element_birds.png';
  static const String flameCreationAnimals  = 'stories/creation/ui/element_animals.png';
  /// Reuses home BGM as a placeholder until a dedicated Creation track is recorded.
  static const String flameBgmCreation      = 'music/bgm_home.mp3';
}
