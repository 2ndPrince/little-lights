import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/routes/app_router.dart';
import '../../data/models/story.dart';
import '../../game/core/base/base_game_screen.dart';
import '../../game/core/base/game_result.dart';
import '../../game/noah/noah_game.dart';
import '../../game/noah/overlays/noah_intro_overlay.dart';
import '../../providers/progress_provider.dart';

/// Screen that hosts the Noah mini-game via [BaseGameScreen].
///
/// On completion: saves progress via [progressProvider], then navigates to cutscene.
class NoahGameScreen extends ConsumerWidget {
  const NoahGameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseGameScreen(
      gameFactory: () => NoahGame(
        onComplete: (GameResult result) async {
          if (result == GameResult.success) {
            await ref
                .read(progressProvider.notifier)
                .markComplete(StoryId.noah, stars: 1);
            if (context.mounted) context.go(AppRoutes.noahCutscene);
          }
        },
      ),
      onGameComplete: (GameResult _) {},
      overlayBuilderMap: {
        NoahGame.introOverlayKey: (context, game) =>
            NoahIntroOverlay(game: game as NoahGame),
      },
    );
  }
}
