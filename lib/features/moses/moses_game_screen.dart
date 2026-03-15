import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/routes/app_router.dart';
import '../../data/models/story.dart';
import '../../game/core/base/base_game_screen.dart';
import '../../game/core/base/game_result.dart';
import '../../game/moses/moses_game.dart';
import '../../game/moses/overlays/moses_intro_overlay.dart';
import '../../providers/progress_provider.dart';

/// Screen that hosts the Moses mini-game via [BaseGameScreen].
///
/// On completion: saves progress via [progressProvider], then navigates to cutscene.
class MosesGameScreen extends ConsumerWidget {
  const MosesGameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseGameScreen(
      gameFactory: () => MosesGame(
        onComplete: (GameResult result) async {
          if (result == GameResult.success) {
            await ref
                .read(progressProvider.notifier)
                .markComplete(StoryId.moses, stars: 1);
            if (context.mounted) context.go(AppRoutes.mosesCutscene);
          }
        },
      ),
      onGameComplete: (GameResult _) {},
      overlayBuilderMap: {
        MosesGame.introOverlayKey: (context, game) =>
            MosesIntroOverlay(game: game as MosesGame),
      },
    );
  }
}
