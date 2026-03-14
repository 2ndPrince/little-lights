import '../models/garden_animal.dart';

/// Pure game logic for the Adam and Eve animal-naming mini-game.
///
/// No Flame imports. No Flutter imports. Fully unit-testable.
class AdamLogic {
  /// Mutable working copy of the animals for this game session.
  final List<GardenAnimal> animals;

  /// Creates an [AdamLogic] with the provided [animals].
  AdamLogic(List<GardenAnimal> initial) : animals = List.of(initial);

  /// Number of animals named so far.
  int get namedCount => animals.where((a) => a.isNamed).length;

  /// True when every animal has been named.
  bool get allNamed =>
      animals.isNotEmpty && animals.every((a) => a.isNamed);

  /// Marks the animal with [animalId] as named.
  ///
  /// Returns the updated [GardenAnimal] if found and not yet named.
  /// Returns null if the id is unknown or the animal is already named.
  GardenAnimal? nameAnimal(String animalId) {
    final index = animals.indexWhere((a) => a.id == animalId);
    if (index == -1) return null;
    if (animals[index].isNamed) return null;
    final updated = animals[index].markNamed();
    animals[index] = updated;
    return updated;
  }
}
