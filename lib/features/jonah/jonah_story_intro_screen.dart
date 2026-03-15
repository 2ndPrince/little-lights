import 'package:flutter/material.dart';

import '../../constants/asset_paths.dart';
import '../stories/story_intro_screen.dart';

/// Jonah and the Whale intro screen.
///
/// Thin wrapper around [StoryIntroScreen] with Jonah-specific content.
class JonahStoryIntroScreen extends StatelessWidget {
  const JonahStoryIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const StoryIntroScreen(
      title: 'Jonah and the Whale',
      illustrationAssetPath: AssetPaths.jonahBgOcean,
      introSentence: 'Help Jonah obey God and calm the storm.',
      startRoute: '/puzzle/jonah',
    );
  }
}
