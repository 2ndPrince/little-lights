import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/routes/app_router.dart';
import '../../data/models/story.dart';
import '../../game/core/base/base_game_screen.dart';
import '../../game/core/base/game_result.dart';
import '../../game/samaritan/samaritan_game.dart';
import '../../game/samaritan/overlays/samaritan_intro_overlay.dart';
import '../../providers/progress_provider.dart';

/// Screen that hosts the Samaritan mini-game via [BaseGameScreen].
///
/// On completion: saves progress via [progressProvider], then navigates to cutscene.
class SamaritanGameScreen extends ConsumerWidget {
  const SamaritanGameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseGameScreen(
      gameFactory: () => SamaritanGame(
        onComplete: (GameResult result) async {
          if (result == GameResult.success) {
            await ref
                .read(progressProvider.notifier)
                .markComplete(StoryId.samaritan, stars: 1);
            if (context.mounted) context.go(AppRoutes.samaritanCutscene);
          }
        },
      ),
      onGameComplete: (GameResult _) {},
      overlayBuilderMap: {
        SamaritanGame.introOverlayKey: (context, game) =>
            SamaritanIntroOverlay(game: game as SamaritanGame),
      },
    );
  }
}
