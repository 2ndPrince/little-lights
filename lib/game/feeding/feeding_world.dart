import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'components/food_item_component.dart';
import 'models/feeding_content.dart';

/// Lays out the Feeding the 5,000 game world: hillside background, boy sprite,
/// and 7 [FoodItemComponent]s arranged in a circle around the boy.
///
/// Passes [onItemTap] to each item so [FeedingGame] can drive the state machine.
class FeedingWorld extends PositionComponent {
  /// Called when any [FoodItemComponent] is tapped.
  final void Function(FoodItemComponent) onItemTap;

  /// Creates the world with the given [onItemTap] handler.
  FeedingWorld({required this.onItemTap}) : super(anchor: Anchor.topLeft);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final screenSize = findGame()!.size;

    // Green hillside background
    add(
      RectangleComponent(
        size: screenSize,
        paint: Paint()..color = const Color(0xFF7DB87D),
      ),
    );

    // Boy sprite centered on screen
    final boySize = Vector2(80, 100);
    final boyPos = Vector2(
      (screenSize.x - boySize.x) / 2,
      (screenSize.y - boySize.y) / 2,
    );
    final boySprite = await Sprite.load(
      'stories/feeding/characters/boy.png',
    );
    add(SpriteComponent(sprite: boySprite, position: boyPos, size: boySize));

    // 7 food items spread in a circle around the boy
    await _addFoodItems(screenSize, boyPos + boySize / 2);
  }

  /// Places 7 [FoodItemComponent]s evenly around a circle centred on [centre].
  Future<void> _addFoodItems(Vector2 screenSize, Vector2 centre) async {
    const itemSize = 70.0;
    const radius = 130.0;
    final itemData = List.of(FeedingContent.items);
    final count = itemData.length;

    for (int i = 0; i < count; i++) {
      final angle = (2 * pi / count) * i - pi / 2;
      final pos = Vector2(
        centre.x + radius * cos(angle) - itemSize / 2,
        centre.y + radius * sin(angle) - itemSize / 2,
      );
      await add(
        FoodItemComponent(
          data: itemData[i],
          onTap: onItemTap,
          position: pos,
          size: Vector2.all(itemSize),
        ),
      );
    }
  }
}
