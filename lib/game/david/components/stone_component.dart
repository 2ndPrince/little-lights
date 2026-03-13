import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

import '../models/stone.dart';

/// Tappable stone component in the David and Goliath mini-game.
///
/// Renders as a rounded rectangle placeholder until real sprites are available.
/// Calls [onTap] when tapped. Can only be tapped once — becomes inert after collection.
class StoneComponent extends PositionComponent with TapCallbacks {
  /// The data model backing this stone.
  final Stone data;

  /// Called when the player taps this stone. Forwarded to [DavidGame].
  final void Function(StoneComponent stone) onTap;

  bool _isCollected = false;

  late final RectangleComponent _bg;

  static const Color _colourDefault = Color(0xFFBDBDBD);
  static const Color _colourCollected = Color(0xFF8BC34A);

  /// Creates a [StoneComponent] at [position] with [size].
  StoneComponent({
    required this.data,
    required this.onTap,
    required super.position,
    required super.size,
  });

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    _bg = RectangleComponent(
      size: size,
      paint: Paint()..color = _colourDefault,
    );
    add(_bg);

    add(
      TextComponent(
        text: data.displayName,
        textRenderer: TextPaint(
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4A3728),
          ),
        ),
        anchor: Anchor.center,
        position: size / 2,
      ),
    );
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (!_isCollected) onTap(this);
  }

  /// Marks this stone as collected with a visual effect.
  void triggerCollectFeedback() {
    _isCollected = true;
    _bg.paint.color = _colourCollected;
    add(
      ScaleEffect.to(
        Vector2.all(1.1),
        EffectController(duration: 0.15, reverseDuration: 0.15),
      ),
    );
  }

  /// Whether this stone has already been collected.
  bool get isCollected => _isCollected;
}
