import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

import '../models/healing_item.dart';

/// Tappable healing item component in the Samaritan mini-game.
///
/// Renders the item sprite. Calls [onTap] when tapped.
/// Can only be tapped once — disappears after being applied.
class HealingItemComponent extends PositionComponent with TapCallbacks {
  /// The data model backing this item.
  final HealingItem data;

  /// Called when the player taps this item. Forwarded to [SamaritanGame].
  final void Function(HealingItemComponent) onTap;

  bool _isApplied = false;

  late final RectangleComponent _bg;

  static const Color _colourDefault = Color(0x4400C853);
  static const Color _colourApplied = Color(0x8800C853);

  /// Creates a [HealingItemComponent] at [position] with [size].
  HealingItemComponent({
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
    if (!_isApplied) onTap(this);
  }

  /// Plays a scale-down-to-zero animation to signal the item has been applied.
  void triggerAppliedFeedback() {
    _isApplied = true;
    _bg.paint.color = _colourApplied;
    add(
      ScaleEffect.to(
        Vector2.zero(),
        EffectController(duration: 0.3),
      ),
    );
  }

  /// Whether this item has already been applied.
  bool get isApplied => _isApplied;
}
