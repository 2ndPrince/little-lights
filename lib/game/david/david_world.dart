import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'components/goliath_component.dart';
import 'components/stone_component.dart';
import 'models/david_content.dart';

/// Lays out the David game world: 3 [StoneComponent]s and a [GoliathComponent].
///
/// Passes [onStoneTap] to each stone so [DavidGame] can drive the state machine.
class DavidWorld extends PositionComponent {
  /// Called when any [StoneComponent] is tapped.
  final void Function(StoneComponent stone) onStoneTap;

  /// The Goliath component, exposed for [DavidGame] to call [fallDown].
  late final GoliathComponent goliath;

  /// Creates the world with the given [onStoneTap] handler.
  DavidWorld({required this.onStoneTap}) : super(anchor: Anchor.topLeft);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final screenSize = findGame()!.size;

    // Sky background
    add(
      RectangleComponent(
        size: screenSize,
        paint: Paint()..color = const Color(0xFF87CEEB),
      ),
    );

    // Ground strip at the bottom
    final groundH = screenSize.y * 0.25;
    add(
      RectangleComponent(
        position: Vector2(0, screenSize.y - groundH),
        size: Vector2(screenSize.x, groundH),
        paint: Paint()..color = const Color(0xFF8BC34A),
      ),
    );

    // Goliath — upper-right area
    goliath = GoliathComponent(
      position: Vector2(screenSize.x * 0.72, screenSize.y - groundH),
      size: Vector2(80, 160),
    );
    await add(goliath);

    // 3 stones — evenly spread along the riverbank
    await _addStones(screenSize, groundH);
  }

  /// Places 3 [StoneComponent]s along the lower portion of the screen.
  Future<void> _addStones(Vector2 screenSize, double groundH) async {
    const stoneW = 80.0;
    const stoneH = 80.0;
    const count = 3;
    const hGap = 30.0;
    final totalW = count * stoneW + (count - 1) * hGap;
    final startX = (screenSize.x - totalW) / 2;
    final stoneY = screenSize.y - groundH + (groundH - stoneH) / 2;

    final stoneData = List.of(DavidContent.stones);

    for (int i = 0; i < stoneData.length; i++) {
      final pos = Vector2(startX + i * (stoneW + hGap), stoneY);
      await add(
        StoneComponent(
          data: stoneData[i],
          onTap: onStoneTap,
          position: pos,
          size: Vector2(stoneW, stoneH),
        ),
      );
    }
  }
}
