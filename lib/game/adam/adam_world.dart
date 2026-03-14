import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'components/garden_animal_component.dart';
import 'models/adam_content.dart';

/// Lays out the Adam game world: Adam character and 4 [GardenAnimalComponent]s.
///
/// Passes [onAnimalTap] to each animal so [AdamGame] can drive the state machine.
class AdamWorld extends PositionComponent {
  /// Called when any [GardenAnimalComponent] is tapped.
  final void Function(GardenAnimalComponent animal) onAnimalTap;

  /// Creates the world with the given [onAnimalTap] handler.
  AdamWorld({required this.onAnimalTap}) : super(anchor: Anchor.topLeft);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final screenSize = findGame()!.size;

    // Garden background
    add(
      RectangleComponent(
        size: screenSize,
        paint: Paint()..color = const Color(0xFF66BB6A),
      ),
    );

    // Sky strip at the top
    final skyH = screenSize.y * 0.3;
    add(
      RectangleComponent(
        position: Vector2.zero(),
        size: Vector2(screenSize.x, skyH),
        paint: Paint()..color = const Color(0xFF81D4FA),
      ),
    );

    // Adam character — bottom-left
    final adamSprite = await Sprite.load('stories/adam/characters/adam_character.png');
    add(
      SpriteComponent(
        sprite: adamSprite,
        position: Vector2(screenSize.x * 0.05, screenSize.y * 0.6),
        size: Vector2(60, 100),
      ),
    );

    // 4 animals in a 2×2 grid centered on screen
    await _addAnimals(screenSize);
  }

  /// Places 4 [GardenAnimalComponent]s in a 2×2 grid in the center of the screen.
  Future<void> _addAnimals(Vector2 screenSize) async {
    const animalW = 100.0;
    const animalH = 100.0;
    const cols = 2;
    const rows = 2;
    const hGap = 20.0;
    const vGap = 20.0;

    final totalW = cols * animalW + (cols - 1) * hGap;
    final totalH = rows * animalH + (rows - 1) * vGap;
    final startX = (screenSize.x - totalW) / 2;
    final startY = (screenSize.y - totalH) / 2;

    final animalData = List.of(AdamContent.animals);

    for (int i = 0; i < animalData.length; i++) {
      final col = i % cols;
      final row = i ~/ cols;
      final pos = Vector2(
        startX + col * (animalW + hGap),
        startY + row * (animalH + vGap),
      );
      await add(
        GardenAnimalComponent(
          data: animalData[i],
          onTap: onAnimalTap,
          position: pos,
          size: Vector2(animalW, animalH),
        ),
      );
    }
  }
}
