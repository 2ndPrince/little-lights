import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/routes/app_router.dart';
import '../../data/models/story.dart';
import '../../game/core/base/base_game_screen.dart';
import '../../game/core/base/game_result.dart';
import '../../game/creation/creation_game.dart';
import '../../game/creation/overlays/creation_intro_overlay.dart';
import '../../providers/progress_provider.dart';

/// Screen that hosts the Creation mini-game via [BaseGameScreen].
///
/// On completion: saves progress via [progressProvider], then navigates to cutscene.
class CreationGameScreen extends ConsumerWidget {
  const CreationGameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseGameScreen(
      gameFactory: () => CreationGame(
        onComplete: (GameResult result) async {
          if (result == GameResult.success) {
            await ref
                .read(progressProvider.notifier)
                .markComplete(StoryId.creation, stars: 1);
            if (context.mounted) context.go(AppRoutes.creationCutscene);
          }
        },
      ),
      onGameComplete: (GameResult _) {},
      overlayBuilderMap: {
        CreationGame.introOverlayKey: (context, game) =>
            CreationIntroOverlay(game: game as CreationGame),
      },
    );
  }
}
