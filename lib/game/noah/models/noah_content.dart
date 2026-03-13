import 'animal_pair.dart';

/// Static content registry for the Noah's Ark mini-game.
/// All 3 MVP animal pairs are defined here.
class NoahContent {
  NoahContent._();

  /// The 3 animal pairs used in the MVP game (6 cards total).
  static const List<AnimalPair> animalPairs = [
    AnimalPair(
      id: 'lion_1',
      pairId: 'lion',
      flamePath: 'stories/noah/animals/lion_1.png',
      displayName: 'Lion',
    ),
    AnimalPair(
      id: 'lion_2',
      pairId: 'lion',
      flamePath: 'stories/noah/animals/lion_2.png',
      displayName: 'Lion',
    ),
    AnimalPair(
      id: 'elephant_1',
      pairId: 'elephant',
      flamePath: 'stories/noah/animals/elephant_1.png',
      displayName: 'Elephant',
    ),
    AnimalPair(
      id: 'elephant_2',
      pairId: 'elephant',
      flamePath: 'stories/noah/animals/elephant_2.png',
      displayName: 'Elephant',
    ),
    AnimalPair(
      id: 'giraffe_1',
      pairId: 'giraffe',
      flamePath: 'stories/noah/animals/giraffe_1.png',
      displayName: 'Giraffe',
    ),
    AnimalPair(
      id: 'giraffe_2',
      pairId: 'giraffe',
      flamePath: 'stories/noah/animals/giraffe_2.png',
      displayName: 'Giraffe',
    ),
  ];
}
