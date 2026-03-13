import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';

/// Goliath character component in the David and Goliath mini-game.
///
/// Stands upright until [fallDown] is called, at which point it animates
/// falling to indicate Goliath has been defeated.
class GoliathComponent extends PositionComponent {
  /// Creates a [GoliathComponent] at [position] with [size].
  GoliathComponent({
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.bottomCenter);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final sprite = await Sprite.load('stories/david/characters/goliath_character.png');
    add(SpriteComponent(sprite: sprite, size: size));
  }

  /// Animates Goliath falling down to indicate defeat.
  void fallDown() {
    add(
      MoveByEffect(
        Vector2(0, 60),
        EffectController(duration: 0.4, curve: Curves.easeIn),
      ),
    );
    add(
      OpacityEffect.to(
        0.0,
        EffectController(duration: 0.5),
      ),
    );
  }
}
