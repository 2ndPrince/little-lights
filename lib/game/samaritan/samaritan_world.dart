import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';

import 'components/healing_item_component.dart';
import 'models/samaritan_content.dart';

/// Lays out the Samaritan game world: background, wounded man, and 3 healing items.
///
/// Passes [onItemTap] to each [HealingItemComponent] so [SamaritanGame] can
/// drive the state machine.
class SamaritanWorld extends PositionComponent {
  /// Called when any [HealingItemComponent] is tapped.
  final void Function(HealingItemComponent) onItemTap;

  late final SpriteComponent _woundedMan;

  /// Creates the world with the given [onItemTap] handler.
  SamaritanWorld({required this.onItemTap}) : super(anchor: Anchor.topLeft);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final screenSize = findGame()!.size;

    // Sandy road background
    add(
      RectangleComponent(
        size: screenSize,
        paint: Paint()..color = const Color(0xFFD4A853),
      ),
    );

    // Wounded man sprite at center
    final manSize = Vector2(100, 120);
    final manPos = Vector2(
      (screenSize.x - manSize.x) / 2,
      (screenSize.y - manSize.y) / 2,
    );
    final woundedSprite = await Sprite.load(
      'stories/samaritan/characters/wounded_man.png',
    );
    _woundedMan = SpriteComponent(
      sprite: woundedSprite,
      position: manPos,
      size: manSize,
    );
    await add(_woundedMan);

    await _addHealingItems(screenSize);
  }

  /// Places 3 [HealingItemComponent]s around the screen edges.
  Future<void> _addHealingItems(Vector2 screenSize) async {
    const itemSize = 90.0;
    final size2d = Vector2.all(itemSize);
    final items = List.of(SamaritanContent.items);

    final positions = [
      Vector2(20, (screenSize.y - itemSize) / 2),                        // left side
      Vector2((screenSize.x - itemSize) / 2, screenSize.y - itemSize - 20), // bottom center
      Vector2(screenSize.x - itemSize - 20, (screenSize.y - itemSize) / 2), // right side
    ];

    for (int i = 0; i < items.length; i++) {
      await add(
        HealingItemComponent(
          data: items[i],
          onTap: onItemTap,
          position: positions[i],
          size: size2d,
        ),
      );
    }
  }

  /// Plays a scale-up animation on the wounded man sprite to signal healing.
  void showHealed() {
    _woundedMan.add(
      ScaleEffect.to(
        Vector2.all(1.2),
        EffectController(duration: 0.3, reverseDuration: 0.3),
      ),
    );
  }
}
