import 'package:flutter/material.dart';

import '../../constants/asset_paths.dart';
import '../stories/story_intro_screen.dart';

/// David and Goliath intro screen.
///
/// Thin wrapper around [StoryIntroScreen] with David-specific content.
class DavidStoryIntroScreen extends StatelessWidget {
  const DavidStoryIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const StoryIntroScreen(
      title: 'David and Goliath',
      illustrationAssetPath: AssetPaths.davidBgHill,
      introSentence: 'Help David be brave and defeat the giant!',
      startRoute: '/puzzle/david',
    );
  }
}
