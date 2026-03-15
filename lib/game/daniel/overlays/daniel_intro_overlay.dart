import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_sizes.dart';
import '../../../constants/asset_paths.dart';
import '../daniel_game.dart';

/// Flame overlay shown at the start of [DanielGame] before gameplay begins.
///
/// Registered in [GameWidget.overlayBuilderMap] under [DanielGame.introOverlayKey].
/// Tapping "Start!" removes the overlay and lets the game proceed.
class DanielIntroOverlay extends StatelessWidget {
  /// The running [DanielGame] instance — used to dismiss this overlay.
  final DanielGame game;

  const DanielIntroOverlay({required this.game, super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.black54,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              AssetPaths.danielBgCave,
              width: 200,
              height: 150,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: AppSizes.spaceM),
            const Text(
              'Tap the lions to feed them!',
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
                  game.overlays.remove(DanielGame.introOverlayKey),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accentOrange,
                foregroundColor: AppColors.textLight,
                minimumSize: const Size(AppSizes.buttonWidth, AppSizes.tapMin),
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
