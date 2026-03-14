import 'garden_animal.dart';

/// Static content registry for the Adam and Eve mini-game.
class AdamContent {
  AdamContent._();

  /// The 4 animals the player must name to complete the game.
  static const List<GardenAnimal> animals = [
    GardenAnimal(
      id: 'lion',
      flamePath: 'stories/adam/animals/adam_lion.png',
      displayName: 'Lion',
    ),
    GardenAnimal(
      id: 'elephant',
      flamePath: 'stories/adam/animals/adam_elephant.png',
      displayName: 'Elephant',
    ),
    GardenAnimal(
      id: 'giraffe',
      flamePath: 'stories/adam/animals/adam_giraffe.png',
      displayName: 'Giraffe',
    ),
    GardenAnimal(
      id: 'bird',
      flamePath: 'stories/adam/animals/adam_bird.png',
      displayName: 'Bird',
    ),
  ];
}
