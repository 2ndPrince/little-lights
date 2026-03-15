import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../../constants/asset_paths.dart';
import 'components/water_wall_component.dart';
import 'models/moses_content.dart';

/// Lays out the Moses game world: sea background, two water walls, and an Israelites sprite.
///
/// Passes [onWallTap] to each wall so [MosesGame] can drive the state machine.
class MosesWorld extends PositionComponent {
  /// Called when any [WaterWallComponent] is tapped.
  final void Function(WaterWallComponent wall) onWallTap;

  late SpriteComponent _israelites;

  /// Creates the world with the given [onWallTap] handler.
  MosesWorld({required this.onWallTap}) : super(anchor: Anchor.topLeft);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final screenSize = findGame()!.size;

    // Sea background
    add(RectangleComponent(
      size: screenSize,
      paint: Paint()..color = const Color(0xFF1565C0),
    ));

    // Sandy floor strip
    final floorH = screenSize.y * 0.2;
    add(RectangleComponent(
      position: Vector2(0, screenSize.y - floorH),
      size: Vector2(screenSize.x, floorH),
      paint: Paint()..color = const Color(0xFFF9A825),
    ));

    // Israelites sprite — initially tiny (scale 0) at bottom center
    final israelitesSprite =
        await Sprite.load(AssetPaths.flameMosesIsraelites);
    _israelites = SpriteComponent(
      sprite: israelitesSprite,
      position: Vector2(screenSize.x * 0.35, screenSize.y * 0.55),
      size: Vector2(120, 80),
    )..scale = Vector2.zero();
    await add(_israelites);

    await _addWalls(screenSize);
  }

  /// Places left and right [WaterWallComponent]s flanking the center.
  Future<void> _addWalls(Vector2 screenSize) async {
    const wallW = 100.0;
    const wallH = 200.0;
    final centerX = screenSize.x / 2;
    final wallY = screenSize.y * 0.25;

    for (final wallData in MosesContent.walls) {
      final xPos = wallData.side.name == 'left'
          ? centerX - wallW - 20
          : centerX + 20;
      await add(WaterWallComponent(
        data: wallData,
        onTap: onWallTap,
        position: Vector2(xPos, wallY),
        size: Vector2(wallW, wallH),
      ));
    }
  }

  /// Animates the Israelites sprite into view once both walls have parted.
  void showIsraelitesCross() {
    _israelites.scale = Vector2.all(1.0);
  }
}
