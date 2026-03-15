import 'package:flutter/material.dart';

import '../../app/routes/app_router.dart';
import '../../constants/asset_paths.dart';
import '../stories/story_intro_screen.dart';

/// Creation story intro screen.
///
/// Thin wrapper around [StoryIntroScreen] with Creation-specific content.
class CreationStoryIntroScreen extends StatelessWidget {
  const CreationStoryIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const StoryIntroScreen(
      title: 'Creation',
      illustrationAssetPath: AssetPaths.creationBgVoid,
      introSentence: 'Tap each day of creation in order!',
      startRoute: AppRoutes.creationGame,
    );
  }
}
