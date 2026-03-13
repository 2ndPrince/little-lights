import '../models/animal_pair.dart';

/// Pure game logic for the Noah animal matching mini-game.
///
/// No Flame imports. No Flutter imports. Fully unit-testable.
abstract final class MatchingLogic {
  /// Returns true if [a] and [b] are a valid pair.
  ///
  /// Valid pair: same [AnimalPair.pairId], different [AnimalPair.id].
  /// Prevents matching a card with itself.
  static bool isValidPair(AnimalPair a, AnimalPair b) {
    return a.pairId == b.pairId && a.id != b.id;
  }

  /// Returns true when every pair in [pairs] has been loaded into the ark.
  static bool allPairsLoaded(List<AnimalPair> pairs) {
    return pairs.isNotEmpty && pairs.every((p) => p.isLoaded);
  }

  /// Returns the number of pairs that have been loaded.
  static int loadedCount(List<AnimalPair> pairs) {
    return pairs.where((p) => p.isLoaded).length ~/ 2;
  }

  /// Returns the total number of unique pairs (not cards) in [pairs].
  static int totalPairs(List<AnimalPair> pairs) {
    return pairs.map((p) => p.pairId).toSet().length;
  }
}
