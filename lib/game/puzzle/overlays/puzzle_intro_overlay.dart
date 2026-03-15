import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_sizes.dart';
import '../../../data/shared/stories_registry.dart';
import '../puzzle_game.dart';

/// Flame overlay shown before the puzzle begins.
///
/// Displays the story title and a "Let's go! 🧩" button.
/// Tapping the button dismisses the overlay and starts the puzzle.
class PuzzleIntroOverlay extends StatelessWidget {
  /// The running [PuzzleGame] — used to dismiss this overlay.
  final PuzzleGame game;

  const PuzzleIntroOverlay({required this.game, super.key});

  @override
  Widget build(BuildContext context) {
    final storyTitle = allStories
        .firstWhere((s) => s.id == game.content.storyId)
        .titleFallback;

    return ColoredBox(
      color: Colors.black54,
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: AppSizes.spaceL),
          padding: const EdgeInsets.all(AppSizes.spaceXL),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(AppSizes.radiusCard),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                storyTitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.textDark,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppSizes.spaceM),
              const Text(
                'Put the puzzle together!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textDark,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: AppSizes.spaceXL),
              ElevatedButton(
                onPressed: () =>
                    game.overlays.remove(PuzzleGame.introOverlayKey),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accentOrange,
                  foregroundColor: AppColors.textLight,
                  minimumSize: const Size(
                    AppSizes.buttonWidth,
                    AppSizes.tapMin,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSizes.radiusButton),
                  ),
                ),
                child: const Text(
                  "Let's go! 🧩",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
