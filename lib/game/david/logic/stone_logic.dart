import '../models/stone.dart';

/// Pure game logic for the David and Goliath stone-collecting mini-game.
///
/// No Flame imports. No Flutter imports. Fully unit-testable.
class StoneLogic {
  /// Mutable working copy of the stones for this game session.
  final List<Stone> stones;

  /// Creates a [StoneLogic] with the provided [stones].
  StoneLogic(List<Stone> initial)
      : stones = List.of(initial);

  /// Number of stones collected so far.
  int get collectedCount => stones.where((s) => s.isCollected).length;

  /// True when every stone has been collected.
  bool get allCollected =>
      stones.isNotEmpty && stones.every((s) => s.isCollected);

  /// Marks the stone with [stoneId] as collected.
  ///
  /// Returns the updated [Stone] if found and not yet collected.
  /// Returns null if the id is unknown or the stone is already collected.
  Stone? collectStone(String stoneId) {
    final index = stones.indexWhere((s) => s.id == stoneId);
    if (index == -1) return null;
    if (stones[index].isCollected) return null;
    final updated = stones[index].markCollected();
    stones[index] = updated;
    return updated;
  }
}
