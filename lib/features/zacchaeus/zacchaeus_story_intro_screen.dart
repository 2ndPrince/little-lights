import 'package:flutter/material.dart';

import '../../app/routes/app_router.dart';
import '../../constants/asset_paths.dart';
import '../stories/story_intro_screen.dart';

/// Zacchaeus story intro screen.
///
/// Thin wrapper around [StoryIntroScreen] with Zacchaeus-specific content.
class ZacchaeusStoryIntroScreen extends StatelessWidget {
  const ZacchaeusStoryIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const StoryIntroScreen(
      title: 'Zacchaeus',
      illustrationAssetPath: AssetPaths.zacchaeusBackground,
      introSentence: 'Help Zacchaeus climb down to meet Jesus!',
      startRoute: AppRoutes.zacchaeusGame,
    );
  }
}
