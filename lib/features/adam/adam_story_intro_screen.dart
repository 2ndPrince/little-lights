import 'package:flutter/material.dart';

import '../../constants/asset_paths.dart';
import '../stories/story_intro_screen.dart';

/// Adam and Eve intro screen.
///
/// Thin wrapper around [StoryIntroScreen] with Adam-specific content.
class AdamStoryIntroScreen extends StatelessWidget {
  const AdamStoryIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const StoryIntroScreen(
      title: 'Adam and Eve',
      illustrationAssetPath: AssetPaths.adamBgGarden,
      introSentence: 'Help Adam name all the animals in the garden.',
      startRoute: '/puzzle/adam',
    );
  }
}
