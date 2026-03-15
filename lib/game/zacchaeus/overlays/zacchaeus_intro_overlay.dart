import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_sizes.dart';
import '../../../constants/asset_paths.dart';
import '../zacchaeus_game.dart';

/// Flame overlay shown at the start of [ZacchaeusGame] before gameplay begins.
///
/// Registered in [GameWidget.overlayBuilderMap] under [ZacchaeusGame.introOverlayKey].
/// Tapping "Start!" removes the overlay and lets the game proceed.
class ZacchaeusIntroOverlay extends StatelessWidget {
  /// The running [ZacchaeusGame] instance — used to dismiss this overlay.
  final ZacchaeusGame game;

  const ZacchaeusIntroOverlay({required this.game, super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.black54,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              AssetPaths.zacchaeusBackground,
              width: 200,
              height: 150,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: AppSizes.spaceM),
            const Text(
              'Tap the branches from top to bottom!',
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
                  game.overlays.remove(ZacchaeusGame.introOverlayKey),
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
