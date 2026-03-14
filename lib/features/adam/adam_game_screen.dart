import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/routes/app_router.dart';
import '../../data/models/story.dart';
import '../../game/core/base/base_game_screen.dart';
import '../../game/core/base/game_result.dart';
import '../../game/adam/adam_game.dart';
import '../../game/adam/overlays/adam_intro_overlay.dart';
import '../../providers/progress_provider.dart';

/// Screen that hosts the Adam mini-game via [BaseGameScreen].
///
/// On completion: saves progress via [progressProvider], then navigates to cutscene.
class AdamGameScreen extends ConsumerWidget {
  const AdamGameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseGameScreen(
      gameFactory: () => AdamGame(
        onComplete: (GameResult result) async {
          if (result == GameResult.success) {
            await ref
                .read(progressProvider.notifier)
                .markComplete(StoryId.adam, stars: 1);
            if (context.mounted) context.go(AppRoutes.adamCutscene);
          }
        },
      ),
      onGameComplete: (GameResult _) {},
      overlayBuilderMap: {
        AdamGame.introOverlayKey: (context, game) =>
            AdamIntroOverlay(game: game as AdamGame),
      },
    );
  }
}
