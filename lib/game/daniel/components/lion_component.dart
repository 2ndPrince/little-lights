import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

import '../models/lion.dart';

/// Tappable lion component in the Daniel and the Lions mini-game.
///
/// Renders the lion sprite with a colour tint. Calls [onTap] when tapped.
/// Can only be tapped once — becomes calm (green tint) after being fed.
class LionComponent extends PositionComponent with TapCallbacks {
  /// The data model backing this lion.
  final Lion data;

  /// Called when the player taps this lion. Forwarded to [DanielGame].
  final void Function(LionComponent lion) onTap;

  bool _isFed = false;

  late final RectangleComponent _tint;

  static const Color _colourUnfed = Color(0x88FF9800);
  static const Color _colourFed = Color(0x4400FF00);

  /// Creates a [LionComponent] at [position] with [size].
  LionComponent({
    required this.data,
    required this.onTap,
    required super.position,
    required super.size,
  });

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final sprite = await Sprite.load(data.flamePath);
    add(SpriteComponent(sprite: sprite, size: size));
    _tint = RectangleComponent(
      size: size,
      paint: Paint()..color = _colourUnfed,
    );
    add(_tint);
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (!_isFed) onTap(this);
  }

  /// Changes the tint to calm green and adds a scale bounce to confirm feeding.
  void triggerFedFeedback() {
    _isFed = true;
    _tint.paint.color = _colourFed;
    add(ScaleEffect.to(
      Vector2.all(1.1),
      EffectController(duration: 0.15, reverseDuration: 0.15),
    ));
  }

  /// Whether this lion has already been fed.
  bool get isFed => _isFed;
}
