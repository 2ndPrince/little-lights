import 'package:flame/components.dart';
import 'package:flame/effects.dart';

/// Jonah's boat component in the Jonah mini-game.
///
/// Stands still during gameplay. Calls [sailAway] to animate the boat
/// sliding off screen to the right when all clouds are calmed.
class JonahBoatComponent extends PositionComponent {
  /// Creates a [JonahBoatComponent] at [position] with [size].
  JonahBoatComponent({
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.bottomCenter);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final sprite = await Sprite.load('stories/jonah/characters/jonah_boat.png');
    add(SpriteComponent(sprite: sprite, size: size));
  }

  /// Animates the boat sailing off to the right of the screen.
  void sailAway() {
    add(
      MoveByEffect(
        Vector2(400, 0),
        EffectController(duration: 1.5),
      ),
    );
  }
}
