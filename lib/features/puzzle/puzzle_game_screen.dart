import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../data/models/story.dart';
import '../../game/core/base/base_game_screen.dart';
import '../../game/core/base/game_result.dart';
import '../../game/puzzle/overlays/puzzle_intro_overlay.dart';
import '../../game/puzzle/puzzle_game.dart';
import '../../constants/puzzle_content_registry.dart';
import '../../providers/progress_provider.dart';

/// Flutter screen that hosts [PuzzleGame] for any story.
///
/// Looks up [PuzzleContent] from [puzzleContentRegistry], creates the game,
/// and navigates to the lesson screen on successful completion.
class PuzzleGameScreen extends ConsumerWidget {
  /// The story whose puzzle should be shown.
  final StoryId storyId;

  const PuzzleGameScreen({required this.storyId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final content = puzzleContentRegistry[storyId]!;

    return BaseGameScreen(
      gameFactory: () => PuzzleGame(
        content: content,
        onComplete: (GameResult result) async {
          if (result == GameResult.success) {
            await ref
                .read(progressProvider.notifier)
                .markComplete(storyId, stars: 1);
            if (context.mounted) {
              context.go('/lesson/${storyId.name}');
            }
          }
        },
      ),
      onGameComplete: (_) {},
      overlayBuilderMap: {
        PuzzleGame.introOverlayKey: (context, game) =>
            PuzzleIntroOverlay(game: game as PuzzleGame),
      },
    );
  }
}
