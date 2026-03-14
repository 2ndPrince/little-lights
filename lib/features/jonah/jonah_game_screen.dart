import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/routes/app_router.dart';
import '../../data/models/story.dart';
import '../../game/core/base/base_game_screen.dart';
import '../../game/core/base/game_result.dart';
import '../../game/jonah/jonah_game.dart';
import '../../game/jonah/overlays/jonah_intro_overlay.dart';
import '../../providers/progress_provider.dart';

/// Screen that hosts the Jonah mini-game via [BaseGameScreen].
///
/// On completion: saves progress via [progressProvider], then navigates to cutscene.
class JonahGameScreen extends ConsumerWidget {
  const JonahGameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseGameScreen(
      gameFactory: () => JonahGame(
        onComplete: (GameResult result) async {
          if (result == GameResult.success) {
            await ref
                .read(progressProvider.notifier)
                .markComplete(StoryId.jonah, stars: 1);
            if (context.mounted) context.go(AppRoutes.jonahCutscene);
          }
        },
      ),
      onGameComplete: (GameResult _) {},
      overlayBuilderMap: {
        JonahGame.introOverlayKey: (context, game) =>
            JonahIntroOverlay(game: game as JonahGame),
      },
    );
  }
}
