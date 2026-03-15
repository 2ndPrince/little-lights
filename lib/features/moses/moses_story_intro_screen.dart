import 'package:flutter/material.dart';

import '../../app/routes/app_router.dart';
import '../../constants/asset_paths.dart';
import '../stories/story_intro_screen.dart';

/// Story introduction screen for Moses and the Red Sea.
class MosesStoryIntroScreen extends StatelessWidget {
  const MosesStoryIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const StoryIntroScreen(
      title: 'Moses and the Red Sea',
      illustrationAssetPath: AssetPaths.mosesBgDesert,
      introSentence: 'Help Moses part the Red Sea!',
      startRoute: AppRoutes.mosesGame,
    );
  }
}
