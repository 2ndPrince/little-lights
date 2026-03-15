import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

import '../models/food_item.dart';

/// Tappable food item component in the Feeding the 5,000 mini-game.
///
/// Renders the food sprite. Calls [onTap] when tapped.
/// Can only be tapped once — becomes inert after being collected.
class FoodItemComponent extends PositionComponent with TapCallbacks {
  /// The data model backing this food item.
  final FoodItem data;

  /// Called when the player taps this item. Forwarded to [FeedingGame].
  final void Function(FoodItemComponent) onTap;

  bool _isCollected = false;

  late final RectangleComponent _bg;

  static const Color _bgColour = Color(0x44FFD700); // faint yellow tint

  /// Creates a [FoodItemComponent] at [position] with [size].
  FoodItemComponent({
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
      paint: Paint()..color = _bgColour,
    );
    add(_bg);

    final sprite = await Sprite.load(data.flamePath);
    add(SpriteComponent(sprite: sprite, size: size));
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (!_isCollected) onTap(this);
  }

  /// Scales this item down to zero and then removes it from the game tree.
  void triggerCollectedFeedback() {
    _isCollected = true;
    add(
      ScaleEffect.to(
        Vector2.zero(),
        EffectController(duration: 0.3),
        onComplete: removeFromParent,
      ),
    );
  }

  /// Whether this item has already been collected.
  bool get isCollected => _isCollected;
}
