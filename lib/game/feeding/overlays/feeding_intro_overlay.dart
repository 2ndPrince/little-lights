import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_sizes.dart';
import '../../../constants/asset_paths.dart';
import '../feeding_game.dart';

/// Flame overlay shown at the start of [FeedingGame] before gameplay begins.
///
/// Registered in [GameWidget.overlayBuilderMap] under [FeedingGame.introOverlayKey].
/// Tapping "Start!" removes the overlay and lets the game proceed.
class FeedingIntroOverlay extends StatelessWidget {
  /// The running [FeedingGame] instance — used to dismiss this overlay.
  final FeedingGame game;

  const FeedingIntroOverlay({required this.game, super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.black54,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              AssetPaths.feedingBgHillside,
              width: 200,
              height: 150,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: AppSizes.spaceM),
            const Text(
              'Tap all the food to share with everyone!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textLight,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppSizes.spaceL),
            ElevatedButton(
              onPressed: () =>
                  game.overlays.remove(FeedingGame.introOverlayKey),
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
                'Start!',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
