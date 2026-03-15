import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_sizes.dart';
import '../../../constants/asset_paths.dart';
import '../samaritan_game.dart';

/// Flame overlay shown at the start of [SamaritanGame] before gameplay begins.
///
/// Registered in [GameWidget.overlayBuilderMap] under [SamaritanGame.introOverlayKey].
/// Tapping "Start!" removes the overlay and lets the game proceed.
class SamaritanIntroOverlay extends StatelessWidget {
  /// The running [SamaritanGame] instance — used to dismiss this overlay.
  final SamaritanGame game;

  const SamaritanIntroOverlay({required this.game, super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.black54,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              AssetPaths.samaritanBgRoad,
              width: 200,
              height: 150,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: AppSizes.spaceM),
            const Text(
              'Tap the items to help the wounded man!',
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
                  game.overlays.remove(SamaritanGame.introOverlayKey),
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
