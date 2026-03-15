import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../constants/asset_paths.dart';
import '../../features/adam/adam_game_screen.dart';
import '../../features/adam/adam_story_intro_screen.dart';
import '../../features/creation/creation_game_screen.dart';
import '../../features/creation/creation_story_intro_screen.dart';
import '../../features/cutscene/cutscene_screen.dart';
import '../../features/daniel/daniel_game_screen.dart';
import '../../features/daniel/daniel_story_intro_screen.dart';
import '../../features/david/david_game_screen.dart';
import '../../features/david/david_story_intro_screen.dart';
import '../../features/feeding/feeding_game_screen.dart';
import '../../features/feeding/feeding_story_intro_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/jonah/jonah_game_screen.dart';
import '../../features/jonah/jonah_story_intro_screen.dart';
import '../../features/moses/moses_game_screen.dart';
import '../../features/moses/moses_story_intro_screen.dart';
import '../../features/noah/noah_game_screen.dart';
import '../../features/noah/noah_story_intro_screen.dart';
import '../../features/rewards/reward_screen.dart';
import '../../features/samaritan/samaritan_game_screen.dart';
import '../../features/samaritan/samaritan_story_intro_screen.dart';
import '../../features/settings/settings_screen.dart';
import '../../features/stories/story_selection_screen.dart';
import '../../features/zacchaeus/zacchaeus_game_screen.dart';
import '../../features/zacchaeus/zacchaeus_story_intro_screen.dart';

/// All app route paths as constants.
abstract final class AppRoutes {
  static const String home           = '/';
  static const String stories        = '/stories';
  static const String noahIntro      = '/stories/noah/intro';
  static const String noahGame       = '/stories/noah/game';
  static const String noahCutscene   = '/stories/noah/cutscene';
  static const String noahReward     = '/stories/noah/reward';
  static const String davidIntro     = '/stories/david/intro';
  static const String davidGame      = '/stories/david/game';
  static const String davidCutscene  = '/stories/david/cutscene';
  static const String davidReward    = '/stories/david/reward';
  static const String jonahIntro     = '/stories/jonah/intro';
  static const String jonahGame      = '/stories/jonah/game';
  static const String jonahCutscene  = '/stories/jonah/cutscene';
  static const String jonahReward    = '/stories/jonah/reward';
  static const String adamIntro      = '/stories/adam/intro';
  static const String adamGame       = '/stories/adam/game';
  static const String adamCutscene   = '/stories/adam/cutscene';
  static const String adamReward     = '/stories/adam/reward';
  static const String mosesIntro     = '/stories/moses/intro';
  static const String mosesGame      = '/stories/moses/game';
  static const String mosesCutscene  = '/stories/moses/cutscene';
  static const String mosesReward    = '/stories/moses/reward';
  static const String danielIntro    = '/stories/daniel/intro';
  static const String danielGame     = '/stories/daniel/game';
  static const String danielCutscene = '/stories/daniel/cutscene';
  static const String danielReward   = '/stories/daniel/reward';
  static const String samaritanIntro    = '/stories/samaritan/intro';
  static const String samaritanGame     = '/stories/samaritan/game';
  static const String samaritanCutscene = '/stories/samaritan/cutscene';
  static const String samaritanReward   = '/stories/samaritan/reward';
  static const String zacchaeusIntro    = '/stories/zacchaeus/intro';
  static const String zacchaeusGame     = '/stories/zacchaeus/game';
  static const String zacchaesuCutscene = '/stories/zacchaeus/cutscene';
  static const String zacchaeusReward   = '/stories/zacchaeus/reward';
  static const String feedingIntro    = '/stories/feeding/intro';
  static const String feedingGame     = '/stories/feeding/game';
  static const String feedingCutscene = '/stories/feeding/cutscene';
  static const String feedingReward   = '/stories/feeding/reward';
  static const String creationIntro    = '/stories/creation/intro';
  static const String creationGame     = '/stories/creation/game';
  static const String creationCutscene = '/stories/creation/cutscene';
  static const String creationReward   = '/stories/creation/reward';
  static const String settings       = '/settings';
  static const String parent         = '/parent';
}

/// Top-level go_router configuration.
final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.home,
  routes: [
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: AppRoutes.stories,
      builder: (context, state) => const StorySelectionScreen(),
    ),
    GoRoute(
      path: AppRoutes.noahIntro,
      builder: (context, state) => const NoahStoryIntroScreen(),
    ),
    GoRoute(
      path: AppRoutes.noahGame,
      builder: (context, state) => const NoahGameScreen(),
    ),
    GoRoute(
      path: AppRoutes.noahCutscene,
      builder: (context, state) => CutsceneScreen(
        framePaths: AssetPaths.noahCutsceneFrames,
        nextRoute: AppRoutes.noahReward,
      ),
    ),
    GoRoute(
      path: AppRoutes.noahReward,
      builder: (context, state) => RewardScreen(
        stars: 1,
        badgeAssetPath: AssetPaths.noahBadge,
        storyTitle: "Noah's Ark",
        replayRoute: AppRoutes.noahIntro,
        doneRoute: AppRoutes.stories,
      ),
    ),
    GoRoute(
      path: AppRoutes.davidIntro,
      builder: (context, state) => const DavidStoryIntroScreen(),
    ),
    GoRoute(
      path: AppRoutes.davidGame,
      builder: (context, state) => const DavidGameScreen(),
    ),
    GoRoute(
      path: AppRoutes.davidCutscene,
      builder: (context, state) => CutsceneScreen(
        framePaths: AssetPaths.davidCutsceneFrames,
        nextRoute: AppRoutes.davidReward,
      ),
    ),
    GoRoute(
      path: AppRoutes.davidReward,
      builder: (context, state) => RewardScreen(
        stars: 1,
        badgeAssetPath: AssetPaths.davidBadge,
        storyTitle: 'David and Goliath',
        replayRoute: AppRoutes.davidIntro,
        doneRoute: AppRoutes.stories,
      ),
    ),
    GoRoute(
      path: AppRoutes.jonahIntro,
      builder: (context, state) => const JonahStoryIntroScreen(),
    ),
    GoRoute(
      path: AppRoutes.jonahGame,
      builder: (context, state) => const JonahGameScreen(),
    ),
    GoRoute(
      path: AppRoutes.jonahCutscene,
      builder: (context, state) => CutsceneScreen(
        framePaths: AssetPaths.jonahCutsceneFrames,
        nextRoute: AppRoutes.jonahReward,
      ),
    ),
    GoRoute(
      path: AppRoutes.jonahReward,
      builder: (context, state) => RewardScreen(
        stars: 1,
        badgeAssetPath: AssetPaths.jonahBadge,
        storyTitle: 'Jonah and the Whale',
        replayRoute: AppRoutes.jonahIntro,
        doneRoute: AppRoutes.stories,
      ),
    ),
    GoRoute(
      path: AppRoutes.adamIntro,
      builder: (context, state) => const AdamStoryIntroScreen(),
    ),
    GoRoute(
      path: AppRoutes.adamGame,
      builder: (context, state) => const AdamGameScreen(),
    ),
    GoRoute(
      path: AppRoutes.adamCutscene,
      builder: (context, state) => CutsceneScreen(
        framePaths: AssetPaths.adamCutsceneFrames,
        nextRoute: AppRoutes.adamReward,
      ),
    ),
    GoRoute(
      path: AppRoutes.adamReward,
      builder: (context, state) => RewardScreen(
        stars: 1,
        badgeAssetPath: AssetPaths.adamBadge,
        storyTitle: 'Adam and Eve',
        replayRoute: AppRoutes.adamIntro,
        doneRoute: AppRoutes.stories,
      ),
    ),
    GoRoute(
      path: AppRoutes.mosesIntro,
      builder: (context, state) => const MosesStoryIntroScreen(),
    ),
    GoRoute(
      path: AppRoutes.mosesGame,
      builder: (context, state) => const MosesGameScreen(),
    ),
    GoRoute(
      path: AppRoutes.mosesCutscene,
      builder: (context, state) => CutsceneScreen(
        framePaths: AssetPaths.mosesCutsceneFrames,
        nextRoute: AppRoutes.mosesReward,
      ),
    ),
    GoRoute(
      path: AppRoutes.mosesReward,
      builder: (context, state) => RewardScreen(
        stars: 1,
        badgeAssetPath: AssetPaths.mosesBadge,
        storyTitle: 'Moses and the Red Sea',
        replayRoute: AppRoutes.mosesIntro,
        doneRoute: AppRoutes.stories,
      ),
    ),
    GoRoute(
      path: AppRoutes.danielIntro,
      builder: (context, state) => const DanielStoryIntroScreen(),
    ),
    GoRoute(
      path: AppRoutes.danielGame,
      builder: (context, state) => const DanielGameScreen(),
    ),
    GoRoute(
      path: AppRoutes.danielCutscene,
      builder: (context, state) => CutsceneScreen(
        framePaths: AssetPaths.danielCutsceneFrames,
        nextRoute: AppRoutes.danielReward,
      ),
    ),
    GoRoute(
      path: AppRoutes.danielReward,
      builder: (context, state) => RewardScreen(
        stars: 1,
        badgeAssetPath: AssetPaths.danielBadge,
        storyTitle: 'Daniel and the Lions',
        replayRoute: AppRoutes.danielIntro,
        doneRoute: AppRoutes.stories,
      ),
    ),
    GoRoute(
      path: AppRoutes.samaritanIntro,
      builder: (context, state) => const SamaritanStoryIntroScreen(),
    ),
    GoRoute(
      path: AppRoutes.samaritanGame,
      builder: (context, state) => const SamaritanGameScreen(),
    ),
    GoRoute(
      path: AppRoutes.samaritanCutscene,
      builder: (context, state) => CutsceneScreen(
        framePaths: AssetPaths.samaritanCutsceneFrames,
        nextRoute: AppRoutes.samaritanReward,
      ),
    ),
    GoRoute(
      path: AppRoutes.samaritanReward,
      builder: (context, state) => RewardScreen(
        stars: 1,
        badgeAssetPath: AssetPaths.samaritanBadge,
        storyTitle: 'The Good Samaritan',
        replayRoute: AppRoutes.samaritanIntro,
        doneRoute: AppRoutes.stories,
      ),
    ),
    GoRoute(
      path: AppRoutes.zacchaeusIntro,
      builder: (context, state) => const ZacchaeusStoryIntroScreen(),
    ),
    GoRoute(
      path: AppRoutes.zacchaeusGame,
      builder: (context, state) => const ZacchaeusGameScreen(),
    ),
    GoRoute(
      path: AppRoutes.zacchaesuCutscene,
      builder: (context, state) => CutsceneScreen(
        framePaths: AssetPaths.zacchaesuCutsceneFrames,
        nextRoute: AppRoutes.zacchaeusReward,
      ),
    ),
    GoRoute(
      path: AppRoutes.zacchaeusReward,
      builder: (context, state) => RewardScreen(
        stars: 1,
        badgeAssetPath: AssetPaths.zacchaesuBadge,
        storyTitle: 'Zacchaeus',
        replayRoute: AppRoutes.zacchaeusIntro,
        doneRoute: AppRoutes.stories,
      ),
    ),
    GoRoute(
      path: AppRoutes.feedingIntro,
      builder: (context, state) => const FeedingStoryIntroScreen(),
    ),
    GoRoute(
      path: AppRoutes.feedingGame,
      builder: (context, state) => const FeedingGameScreen(),
    ),
    GoRoute(
      path: AppRoutes.feedingCutscene,
      builder: (context, state) => CutsceneScreen(
        framePaths: AssetPaths.feedingCutsceneFrames,
        nextRoute: AppRoutes.feedingReward,
      ),
    ),
    GoRoute(
      path: AppRoutes.feedingReward,
      builder: (context, state) => RewardScreen(
        stars: 1,
        badgeAssetPath: AssetPaths.feedingBadge,
        storyTitle: 'Feeding the 5,000',
        replayRoute: AppRoutes.feedingIntro,
        doneRoute: AppRoutes.stories,
      ),
    ),
    GoRoute(
      path: AppRoutes.creationIntro,
      builder: (context, state) => const CreationStoryIntroScreen(),
    ),
    GoRoute(
      path: AppRoutes.creationGame,
      builder: (context, state) => const CreationGameScreen(),
    ),
    GoRoute(
      path: AppRoutes.creationCutscene,
      builder: (context, state) => CutsceneScreen(
        framePaths: AssetPaths.creationCutsceneFrames,
        nextRoute: AppRoutes.creationReward,
      ),
    ),
    GoRoute(
      path: AppRoutes.creationReward,
      builder: (context, state) => RewardScreen(
        stars: 1,
        badgeAssetPath: AssetPaths.creationBadge,
        storyTitle: 'Creation',
        replayRoute: AppRoutes.creationIntro,
        doneRoute: AppRoutes.stories,
      ),
    ),
    GoRoute(
      path: AppRoutes.settings,
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: AppRoutes.parent,
      builder: (context, state) => const _StubScreen(title: 'Parent Section'),
    ),
  ],
);

/// Temporary stub screen — replaced when each feature screen is built.
class _StubScreen extends StatelessWidget {
  final String title;
  const _StubScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8EC),
      body: Center(
        child: Text(
          title,
          style: const TextStyle(fontSize: 28, color: Color(0xFF3D2B1F)),
        ),
      ),
    );
  }
}
