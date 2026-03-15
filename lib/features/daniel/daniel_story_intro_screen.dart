import 'package:flutter/material.dart';

import '../../constants/asset_paths.dart';
import '../stories/story_intro_screen.dart';

/// Story introduction screen for Daniel and the Lions.
class DanielStoryIntroScreen extends StatelessWidget {
  const DanielStoryIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const StoryIntroScreen(
      title: 'Daniel and the Lions',
      illustrationAssetPath: AssetPaths.danielBgCave,
      introSentence: 'Help Daniel stay brave with the lions!',
      startRoute: '/puzzle/daniel',
    );
  }
}
