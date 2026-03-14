import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

import '../models/storm_cloud.dart';

/// Tappable storm cloud component in the Jonah mini-game.
///
/// Renders the cloud sprite image. Calls [onTap] when tapped.
/// Can only be tapped once — becomes inert after being calmed.
class StormCloudComponent extends PositionComponent with TapCallbacks {
  /// The data model backing this cloud.
  final StormCloud data;

  /// Called when the player taps this cloud. Forwarded to [JonahGame].
  final void Function(StormCloudComponent cloud) onTap;

  bool _isCalmed = false;

  late final RectangleComponent _bg;

  static const Color _colourDefault = Color(0x00000000); // transparent
  static const Color _colourCalmed = Color(0x444FC3F7); // faint blue tint

  /// Creates a [StormCloudComponent] at [position] with [size].
  StormCloudComponent({
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

    final sprite = await Sprite.load(data.flamePath);
    add(SpriteComponent(sprite: sprite, size: size));
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (!_isCalmed) onTap(this);
  }

  /// Marks this cloud as calmed with a visual scale bounce and blue tint.
  void triggerCalmFeedback() {
    _isCalmed = true;
    _bg.paint.color = _colourCalmed;
    add(
      ScaleEffect.to(
        Vector2.all(1.1),
        EffectController(duration: 0.15, reverseDuration: 0.15),
      ),
    );
  }

  /// Whether this cloud has already been calmed.
  bool get isCalmed => _isCalmed;
}
