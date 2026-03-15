import '../models/lion.dart';

/// Pure game logic for the Daniel and the Lions mini-game.
///
/// No Flame imports. No Flutter imports. Fully unit-testable.
class DanielLogic {
  /// Mutable working copy of the lions for this game session.
  final List<Lion> lions;

  /// Creates a [DanielLogic] with the provided [lions].
  DanielLogic(List<Lion> initial) : lions = List.of(initial);

  /// Number of lions fed so far.
  int get fedCount => lions.where((l) => l.isFed).length;

  /// True when all lions have been fed.
  bool get allFed => lions.isNotEmpty && lions.every((l) => l.isFed);

  /// Marks the lion with [lionId] as fed.
  ///
  /// Returns the updated [Lion] if found and not yet fed.
  /// Returns null if the id is unknown or the lion is already fed.
  Lion? feedLion(String lionId) {
    final index = lions.indexWhere((l) => l.id == lionId);
    if (index == -1) return null;
    if (lions[index].isFed) return null;
    final updated = lions[index].markFed();
    lions[index] = updated;
    return updated;
  }
}
