import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

import '../models/branch.dart';

/// Tappable branch component in the Zacchaeus mini-game.
///
/// Renders the branch sprite. Calls [onTap] when tapped.
/// Provides correct/wrong visual feedback based on tap order.
class BranchComponent extends PositionComponent with TapCallbacks {
  /// The data model backing this branch.
  final Branch data;

  /// Called when the player taps this branch. Forwarded to [ZacchaeusGame].
  final void Function(BranchComponent) onTap;

  bool _isTapped = false;

  late final RectangleComponent _bg;

  static const Color _colourDefault = Color(0x448D6E52);
  static const Color _colourCorrect = Color(0x8800C853);

  /// Creates a [BranchComponent] at [position] with [size].
  BranchComponent({
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
    if (!_isTapped) onTap(this);
  }

  /// Marks the branch as tapped with a green tint and scale bounce.
  void triggerCorrectFeedback() {
    _isTapped = true;
    _bg.paint.color = _colourCorrect;
    add(
      ScaleEffect.to(
        Vector2.all(1.15),
        EffectController(duration: 0.15, reverseDuration: 0.15),
      ),
    );
  }

  /// Shakes the branch left/right to signal an incorrect tap order.
  void triggerWrongFeedback() {
    add(
      MoveEffect.by(
        Vector2(-8, 0),
        EffectController(
          duration: 0.05,
          reverseDuration: 0.05,
          repeatCount: 3,
        ),
      ),
    );
  }

  /// Whether this branch has already been tapped in the correct order.
  bool get isTapped => _isTapped;
}
