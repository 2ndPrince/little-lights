import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// All app route paths as constants.
abstract final class AppRoutes {
  static const String home           = '/';
  static const String stories        = '/stories';
  static const String noahIntro      = '/stories/noah/intro';
  static const String noahGame       = '/stories/noah/game';
  static const String noahCutscene   = '/stories/noah/cutscene';
  static const String noahReward     = '/stories/noah/reward';
  static const String settings       = '/settings';
  static const String parent         = '/parent';
}

/// Top-level go_router configuration.
final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.home,
  routes: [
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const _StubScreen(title: 'Home'),
    ),
    GoRoute(
      path: AppRoutes.stories,
      builder: (context, state) => const _StubScreen(title: 'Story Select'),
    ),
    GoRoute(
      path: AppRoutes.noahIntro,
      builder: (context, state) => const _StubScreen(title: 'Noah Intro'),
    ),
    GoRoute(
      path: AppRoutes.noahGame,
      builder: (context, state) => const _StubScreen(title: 'Noah Game'),
    ),
    GoRoute(
      path: AppRoutes.noahCutscene,
      builder: (context, state) => const _StubScreen(title: 'Noah Cutscene'),
    ),
    GoRoute(
      path: AppRoutes.noahReward,
      builder: (context, state) => const _StubScreen(title: 'Noah Reward'),
    ),
    GoRoute(
      path: AppRoutes.settings,
      builder: (context, state) => const _StubScreen(title: 'Settings'),
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
