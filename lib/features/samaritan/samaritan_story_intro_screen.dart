import 'package:flutter/material.dart';

import '../../constants/asset_paths.dart';
import '../stories/story_intro_screen.dart';

/// Good Samaritan story intro screen.
///
/// Thin wrapper around [StoryIntroScreen] with Samaritan-specific content.
class SamaritanStoryIntroScreen extends StatelessWidget {
  const SamaritanStoryIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const StoryIntroScreen(
      title: 'The Good Samaritan',
      illustrationAssetPath: AssetPaths.samaritanBgRoad,
      introSentence: 'Help the Good Samaritan heal the wounded man!',
      startRoute: '/puzzle/samaritan',
    );
  }
}
