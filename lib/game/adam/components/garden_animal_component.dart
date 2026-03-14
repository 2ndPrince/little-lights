import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

import '../models/garden_animal.dart';

/// Tappable garden animal component in the Adam and Eve mini-game.
///
/// Renders the animal sprite image. Calls [onTap] when tapped.
/// Can only be tapped once — becomes inert after being named.
class GardenAnimalComponent extends PositionComponent with TapCallbacks {
  /// The data model backing this animal.
  final GardenAnimal data;

  /// Called when the player taps this animal. Forwarded to [AdamGame].
  final void Function(GardenAnimalComponent animal) onTap;

  bool _isNamed = false;

  late final RectangleComponent _bg;

  static const Color _colourDefault = Color(0x00000000); // transparent
  static const Color _colourNamed = Color(0x44FFD700); // faint golden tint

  /// Creates a [GardenAnimalComponent] at [position] with [size].
  GardenAnimalComponent({
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
    if (!_isNamed) onTap(this);
  }

  /// Marks this animal as named with a golden glow tint and scale bounce.
  void triggerNamedFeedback() {
    _isNamed = true;
    _bg.paint.color = _colourNamed;
    add(
      ScaleEffect.to(
        Vector2.all(1.1),
        EffectController(duration: 0.15, reverseDuration: 0.15),
      ),
    );
  }

  /// Whether this animal has already been named.
  bool get isNamed => _isNamed;
}
