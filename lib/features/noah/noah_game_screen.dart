import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/routes/app_router.dart';
import '../../game/core/base/base_game_screen.dart';
import '../../game/core/base/game_result.dart';
import '../../game/noah/noah_game.dart';

/// Screen that hosts the Noah mini-game via [BaseGameScreen].
///
/// Bridges game completion to the cutscene route.
class NoahGameScreen extends StatelessWidget {
  const NoahGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseGameScreen(
      gameFactory: () => NoahGame(
        onComplete: (GameResult result) {
          if (result == GameResult.success) {
            context.go(AppRoutes.noahCutscene);
          }
        },
      ),
      onGameComplete: (GameResult result) {
        if (result == GameResult.success) {
          context.go(AppRoutes.noahCutscene);
        }
      },
    );
  }
}
