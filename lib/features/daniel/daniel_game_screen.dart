import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/routes/app_router.dart';
import '../../data/models/story.dart';
import '../../game/core/base/base_game_screen.dart';
import '../../game/core/base/game_result.dart';
import '../../game/daniel/daniel_game.dart';
import '../../game/daniel/overlays/daniel_intro_overlay.dart';
import '../../providers/progress_provider.dart';

/// Screen that hosts the Daniel mini-game via [BaseGameScreen].
///
/// On completion: saves progress via [progressProvider], then navigates to cutscene.
class DanielGameScreen extends ConsumerWidget {
  const DanielGameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseGameScreen(
      gameFactory: () => DanielGame(
        onComplete: (GameResult result) async {
          if (result == GameResult.success) {
            await ref
                .read(progressProvider.notifier)
                .markComplete(StoryId.daniel, stars: 1);
            if (context.mounted) context.go(AppRoutes.danielCutscene);
          }
        },
      ),
      onGameComplete: (GameResult _) {},
      overlayBuilderMap: {
        DanielGame.introOverlayKey: (context, game) =>
            DanielIntroOverlay(game: game as DanielGame),
      },
    );
  }
}
