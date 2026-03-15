import 'package:flutter/material.dart';

import '../../constants/asset_paths.dart';
import '../stories/story_intro_screen.dart';

/// Noah's Ark intro screen.
///
/// Thin wrapper around [StoryIntroScreen] with Noah-specific content.
class NoahStoryIntroScreen extends StatelessWidget {
  const NoahStoryIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const StoryIntroScreen(
      title: "Noah's Ark",
      illustrationAssetPath: AssetPaths.noahBgSky,
      introSentence: 'Help Noah bring the animals into the ark.',
      startRoute: '/puzzle/noah',
    );
  }
}
