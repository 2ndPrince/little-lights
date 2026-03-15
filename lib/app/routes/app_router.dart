import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../constants/asset_paths.dart';
import '../../data/models/story.dart';
import '../../features/adam/adam_story_intro_screen.dart';
import '../../features/creation/creation_story_intro_screen.dart';
import '../../features/daniel/daniel_story_intro_screen.dart';
import '../../features/david/david_story_intro_screen.dart';
import '../../features/feeding/feeding_story_intro_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/jonah/jonah_story_intro_screen.dart';
import '../../features/lesson/lesson_screen.dart';
import '../../features/moses/moses_story_intro_screen.dart';
import '../../features/noah/noah_story_intro_screen.dart';
import '../../features/puzzle/puzzle_game_screen.dart';
import '../../features/rewards/reward_screen.dart';
import '../../features/samaritan/samaritan_story_intro_screen.dart';
import '../../features/settings/settings_screen.dart';
import '../../features/stories/story_selection_screen.dart';
import '../../features/zacchaeus/zacchaeus_story_intro_screen.dart';

/// All app route paths as constants.
abstract final class AppRoutes {
  static const String home    = '/';
  static const String stories = '/stories';
  static const String settings = '/settings';
  static const String parent   = '/parent';

  // Per-story intro and reward routes
  static const String noahIntro      = '/stories/noah/intro';
  static const String noahReward     = '/stories/noah/reward';
  static const String davidIntro     = '/stories/david/intro';
  static const String davidReward    = '/stories/david/reward';
  static const String jonahIntro     = '/stories/jonah/intro';
  static const String jonahReward    = '/stories/jonah/reward';
  static const String adamIntro      = '/stories/adam/intro';
  static const String adamReward     = '/stories/adam/reward';
  static const String mosesIntro     = '/stories/moses/intro';
  static const String mosesReward    = '/stories/moses/reward';
  static const String danielIntro    = '/stories/daniel/intro';
  static const String danielReward   = '/stories/daniel/reward';
  static const String samaritanIntro = '/stories/samaritan/intro';
  static const String samaritanReward = '/stories/samaritan/reward';
  static const String zacchaeusIntro  = '/stories/zacchaeus/intro';
  static const String zacchaeusReward = '/stories/zacchaeus/reward';
  static const String feedingIntro    = '/stories/feeding/intro';
  static const String feedingReward   = '/stories/feeding/reward';
  static const String creationIntro   = '/stories/creation/intro';
  static const String creationReward  = '/stories/creation/reward';
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
    // ── Universal puzzle & lesson routes (Wave 7) ──────────────────────────
    GoRoute(
      path: '/puzzle/:storyId',
      builder: (context, state) {
        final id = StoryId.values.firstWhere(
          (e) => e.name == state.pathParameters['storyId'],
        );
        return PuzzleGameScreen(storyId: id);
      },
    ),
    GoRoute(
      path: '/lesson/:storyId',
      builder: (context, state) {
        final id = StoryId.values.firstWhere(
          (e) => e.name == state.pathParameters['storyId'],
        );
        return LessonScreen(storyId: id);
      },
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
