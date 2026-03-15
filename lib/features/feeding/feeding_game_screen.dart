import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/routes/app_router.dart';
import '../../data/models/story.dart';
import '../../game/core/base/base_game_screen.dart';
import '../../game/core/base/game_result.dart';
import '../../game/feeding/feeding_game.dart';
import '../../game/feeding/overlays/feeding_intro_overlay.dart';
import '../../providers/progress_provider.dart';

/// Screen that hosts the Feeding mini-game via [BaseGameScreen].
///
/// On completion: saves progress via [progressProvider], then navigates to cutscene.
class FeedingGameScreen extends ConsumerWidget {
  const FeedingGameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseGameScreen(
      gameFactory: () => FeedingGame(
        onComplete: (GameResult result) async {
          if (result == GameResult.success) {
            await ref
                .read(progressProvider.notifier)
                .markComplete(StoryId.feeding, stars: 1);
            if (context.mounted) context.go(AppRoutes.feedingCutscene);
          }
        },
      ),
      onGameComplete: (GameResult _) {},
      overlayBuilderMap: {
        FeedingGame.introOverlayKey: (context, game) =>
            FeedingIntroOverlay(game: game as FeedingGame),
      },
    );
  }
}
