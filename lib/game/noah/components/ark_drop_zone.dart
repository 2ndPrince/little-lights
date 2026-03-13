import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';

/// The ark area where matched animal pairs are loaded.
///
/// Renders the ark sprite. Fires [onPairLoaded] when a pair is
/// successfully dropped into it.
class ArkDropZone extends PositionComponent with TapCallbacks {
  /// Called when a matched pair is successfully loaded into the ark.
  final void Function(String pairId) onPairLoaded;

  /// How many pairs have been loaded so far.
  int _loadedCount = 0;

  /// The number of pairs successfully loaded into the ark.
  int get loadedCount => _loadedCount;

  ArkDropZone({
    required this.onPairLoaded,
    required super.position,
    required super.size,
  });

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final sprite = await Sprite.load('stories/noah/ui/ark.png');
    add(SpriteComponent(sprite: sprite, size: size));
  }

  /// Called by [NoahGame] when a valid pair has been matched.
  /// Triggers visual feedback and fires [onPairLoaded].
  void acceptPair(String pairId) {
    _loadedCount++;
    _playLoadAnimation();
    onPairLoaded(pairId);
  }

  /// Returns true if [worldPoint] is within the ark drop zone bounds.
  @override
  bool containsPoint(Vector2 worldPoint) {
    final local = worldPoint - position;
    return local.x >= 0 &&
        local.y >= 0 &&
        local.x <= size.x &&
        local.y <= size.y;
  }

  void _playLoadAnimation() {
    // Placeholder: slight scale pulse to indicate a pair was loaded
    add(
      ScaleEffect.to(
        Vector2.all(1.05),
        EffectController(duration: 0.1, reverseDuration: 0.1),
      ),
    );
  }
}
