import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';

/// Goliath character component in the David and Goliath mini-game.
///
/// Stands upright until [fallDown] is called, at which point it animates
/// falling to indicate Goliath has been defeated.
class GoliathComponent extends PositionComponent {
  late final RectangleComponent _body;

  /// Creates a [GoliathComponent] at [position] with [size].
  GoliathComponent({
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.bottomCenter);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    _body = RectangleComponent(
      size: size,
      paint: Paint()..color = const Color(0xFF6D4C41),
    );
    add(_body);

    add(
      TextComponent(
        text: 'Goliath',
        textRenderer: TextPaint(
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFFFFFFFF),
          ),
        ),
        anchor: Anchor.topCenter,
        position: Vector2(size.x / 2, 8),
      ),
    );
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
