import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/routes/app_router.dart';
import '../../data/models/story.dart';
import '../../game/core/base/base_game_screen.dart';
import '../../game/core/base/game_result.dart';
import '../../game/david/david_game.dart';
import '../../game/david/overlays/david_intro_overlay.dart';
import '../../providers/progress_provider.dart';

/// Screen that hosts the David mini-game via [BaseGameScreen].
///
/// On completion: saves progress via [progressProvider], then navigates to cutscene.
class DavidGameScreen extends ConsumerWidget {
  const DavidGameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseGameScreen(
      gameFactory: () => DavidGame(
        onComplete: (GameResult result) async {
          if (result == GameResult.success) {
            await ref
                .read(progressProvider.notifier)
                .markComplete(StoryId.david, stars: 1);
            if (context.mounted) context.go(AppRoutes.davidCutscene);
          }
        },
      ),
      onGameComplete: (GameResult _) {},
      overlayBuilderMap: {
        DavidGame.introOverlayKey: (context, game) =>
            DavidIntroOverlay(game: game as DavidGame),
      },
    );
  }
}
