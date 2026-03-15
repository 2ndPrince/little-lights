import 'package:flutter/material.dart';

import '../../app/routes/app_router.dart';
import '../../constants/asset_paths.dart';
import '../stories/story_intro_screen.dart';

/// Feeding the 5,000 story intro screen.
///
/// Thin wrapper around [StoryIntroScreen] with Feeding-specific content.
class FeedingStoryIntroScreen extends StatelessWidget {
  const FeedingStoryIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const StoryIntroScreen(
      title: 'Feeding the 5,000',
      illustrationAssetPath: AssetPaths.feedingBgHillside,
      introSentence: 'Help share the loaves and fish with everyone!',
      startRoute: AppRoutes.feedingGame,
    );
  }
}
