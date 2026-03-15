import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'components/creation_element_component.dart';
import 'models/creation_content.dart';

/// Lays out the Creation game world: dark background and 6 creation element
/// components arranged in a 2×3 grid.
///
/// Passes [onElementTap] to each element so [CreationGame] can drive the state machine.
class CreationWorld extends PositionComponent {
  /// Called when any [CreationElementComponent] is tapped.
  final void Function(CreationElementComponent) onElementTap;

  /// Creates the world with the given [onElementTap] handler.
  CreationWorld({required this.onElementTap}) : super(anchor: Anchor.topLeft);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final screenSize = findGame()!.size;

    // Dark void background
    add(
      RectangleComponent(
        size: screenSize,
        paint: Paint()..color = const Color(0xFF0A0A2E),
      ),
    );

    await _addElements(screenSize);
  }

  /// Places 6 [CreationElementComponent]s in a 2-column × 3-row grid.
  Future<void> _addElements(Vector2 screenSize) async {
    const cols = 2;
    const rows = 3;
    const itemW = 110.0;
    const itemH = 100.0;
    const gapX = 20.0;
    const gapY = 20.0;

    final gridW = cols * itemW + (cols - 1) * gapX;
    final gridH = rows * itemH + (rows - 1) * gapY;
    final startX = (screenSize.x - gridW) / 2;
    final startY = (screenSize.y - gridH) / 2;

    final elementData = List.of(CreationContent.elements);

    for (int i = 0; i < elementData.length; i++) {
      final col = i % cols;
      final row = i ~/ cols;
      final pos = Vector2(
        startX + col * (itemW + gapX),
        startY + row * (itemH + gapY),
      );
      await add(
        CreationElementComponent(
          data: elementData[i],
          onTap: onElementTap,
          position: pos,
          size: Vector2(itemW, itemH),
        ),
      );
    }
  }
}
