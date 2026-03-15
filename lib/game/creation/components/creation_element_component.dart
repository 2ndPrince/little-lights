import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

import '../models/creation_element.dart';

/// Tappable creation element component in the Creation mini-game.
///
/// Renders the element sprite with a dark tint until activated.
/// Calls [onTap] when tapped. Can only be tapped once — becomes inert after activation.
class CreationElementComponent extends PositionComponent with TapCallbacks {
  /// The data model backing this creation element.
  final CreationElement data;

  /// Called when the player taps this element. Forwarded to [CreationGame].
  final void Function(CreationElementComponent) onTap;

  bool _isActivated = false;

  late final RectangleComponent _bg;

  static const Color _bgDefault = Color(0x88330066); // dark purple tint
  static const Color _bgActivated = Color(0x88FFFF00); // bright yellow tint

  /// Creates a [CreationElementComponent] at [position] with [size].
  CreationElementComponent({
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
      paint: Paint()..color = _bgDefault,
    );
    add(_bg);

    final sprite = await Sprite.load(data.flamePath);
    add(SpriteComponent(sprite: sprite, size: size));
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (!_isActivated) onTap(this);
  }

  /// Changes the background tint to bright and plays a scale bounce animation.
  void triggerActivatedFeedback() {
    _isActivated = true;
    _bg.paint.color = _bgActivated;
    add(
      ScaleEffect.to(
        Vector2.all(1.2),
        EffectController(duration: 0.15, reverseDuration: 0.15),
      ),
    );
  }

  /// Plays a shake animation to indicate a wrong-order tap.
  void triggerWrongFeedback() {
    const shakeAmount = 8.0;
    add(
      MoveEffect.by(
        Vector2(shakeAmount, 0),
        EffectController(
          duration: 0.05,
          reverseDuration: 0.05,
          repeatCount: 3,
        ),
      ),
    );
  }

  /// Whether this element has already been activated.
  bool get isActivated => _isActivated;
}
