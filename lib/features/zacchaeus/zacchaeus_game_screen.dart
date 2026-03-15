import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/routes/app_router.dart';
import '../../data/models/story.dart';
import '../../game/core/base/base_game_screen.dart';
import '../../game/core/base/game_result.dart';
import '../../game/zacchaeus/zacchaeus_game.dart';
import '../../game/zacchaeus/overlays/zacchaeus_intro_overlay.dart';
import '../../providers/progress_provider.dart';

/// Screen that hosts the Zacchaeus mini-game via [BaseGameScreen].
///
/// On completion: saves progress via [progressProvider], then navigates to cutscene.
class ZacchaeusGameScreen extends ConsumerWidget {
  const ZacchaeusGameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseGameScreen(
      gameFactory: () => ZacchaeusGame(
        onComplete: (GameResult result) async {
          if (result == GameResult.success) {
            await ref
                .read(progressProvider.notifier)
                .markComplete(StoryId.zacchaeus, stars: 1);
            if (context.mounted) context.go(AppRoutes.zacchaesuCutscene);
          }
        },
      ),
      onGameComplete: (GameResult _) {},
      overlayBuilderMap: {
        ZacchaeusGame.introOverlayKey: (context, game) =>
            ZacchaeusIntroOverlay(game: game as ZacchaeusGame),
      },
    );
  }
}
