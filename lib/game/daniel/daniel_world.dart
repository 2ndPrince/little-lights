import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'components/lion_component.dart';
import 'models/daniel_content.dart';

/// Lays out the Daniel game world: cave background and three [LionComponent]s.
///
/// Passes [onLionTap] to each lion so [DanielGame] can drive the state machine.
class DanielWorld extends PositionComponent {
  /// Called when any [LionComponent] is tapped.
  final void Function(LionComponent lion) onLionTap;

  /// Creates the world with the given [onLionTap] handler.
  DanielWorld({required this.onLionTap}) : super(anchor: Anchor.topLeft);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final screenSize = findGame()!.size;

    // Dark cave background
    add(RectangleComponent(
      size: screenSize,
      paint: Paint()..color = const Color(0xFF2D1B00),
    ));

    // Cave ceiling strip for depth
    final ceilingH = screenSize.y * 0.15;
    add(RectangleComponent(
      position: Vector2.zero(),
      size: Vector2(screenSize.x, ceilingH),
      paint: Paint()..color = const Color(0xFF1A0F00),
    ));

    await _addLions(screenSize);
  }

  /// Places 3 [LionComponent]s spread horizontally in the center.
  Future<void> _addLions(Vector2 screenSize) async {
    const lionW = 100.0;
    const lionH = 100.0;
    const count = 3;
    const hGap = 20.0;

    final totalW = count * lionW + (count - 1) * hGap;
    final startX = (screenSize.x - totalW) / 2;
    final lionY = (screenSize.y - lionH) / 2;

    for (int i = 0; i < DanielContent.lions.length; i++) {
      await add(LionComponent(
        data: DanielContent.lions[i],
        onTap: onLionTap,
        position: Vector2(startX + i * (lionW + hGap), lionY),
        size: Vector2(lionW, lionH),
      ));
    }
  }
}
