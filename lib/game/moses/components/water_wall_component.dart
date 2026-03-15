import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';

import '../models/water_wall.dart';

/// Tappable water wall component in the Moses Red Sea mini-game.
///
/// Renders the wall sprite. Calls [onTap] when tapped.
/// Can only be tapped once — slides away after being moved.
class WaterWallComponent extends PositionComponent with TapCallbacks {
  /// The data model backing this wall.
  final WaterWall data;

  /// Called when the player taps this wall. Forwarded to [MosesGame].
  final void Function(WaterWallComponent wall) onTap;

  bool _isMoved = false;

  /// Creates a [WaterWallComponent] at [position] with [size].
  WaterWallComponent({
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
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (!_isMoved) onTap(this);
  }

  /// Slides this wall off screen in the direction of its [WaterWallSide] with a scale bounce.
  void triggerMoveFeedback() {
    _isMoved = true;
    final xDelta = data.side == WaterWallSide.left ? -200.0 : 200.0;
    add(MoveEffect.by(
      Vector2(xDelta, 0),
      EffectController(duration: 0.4),
    ));
    add(ScaleEffect.to(
      Vector2.all(1.1),
      EffectController(duration: 0.15, reverseDuration: 0.15),
    ));
  }

  /// Whether this wall has already been moved.
  bool get isMoved => _isMoved;
}
