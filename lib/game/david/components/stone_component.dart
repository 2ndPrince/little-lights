import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

import '../models/stone.dart';

/// Tappable stone component in the David and Goliath mini-game.
///
/// Renders the stone sprite image. Calls [onTap] when tapped.
/// Can only be tapped once — becomes inert after collection.
class StoneComponent extends PositionComponent with TapCallbacks {
  /// The data model backing this stone.
  final Stone data;

  /// Called when the player taps this stone. Forwarded to [DavidGame].
  final void Function(StoneComponent stone) onTap;

  bool _isCollected = false;

  late final RectangleComponent _bg;

  static const Color _colourDefault = Color(0x00000000); // transparent
  static const Color _colourCollected = Color(0x448BC34A); // faint green tint

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

    // Stone sprite
    final sprite = await Sprite.load(data.flamePath);
    add(SpriteComponent(sprite: sprite, size: size));
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
