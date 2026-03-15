import '../models/branch.dart';

/// Pure game logic for the Zacchaeus branch-tapping mini-game.
///
/// No Flame imports. No Flutter imports. Fully unit-testable.
class ZacchaeusLogic {
  /// Mutable working copy of the branches for this game session.
  final List<Branch> branches;

  /// The order value expected on the next tap (starts at 1).
  int nextExpected = 1;

  /// Creates a [ZacchaeusLogic] with the provided [initial] branches.
  ZacchaeusLogic(List<Branch> initial) : branches = List.of(initial);

  /// True when all branches have been tapped in the correct order.
  bool get allDescended =>
      branches.isNotEmpty && branches.every((b) => b.isTapped);

  /// Attempts to tap the branch with [branchId].
  ///
  /// If the branch exists, is untapped, and its [Branch.order] matches
  /// [nextExpected], marks it tapped, increments [nextExpected], and returns
  /// the updated [Branch].
  ///
  /// Returns null if the id is unknown, already tapped, or tapped out of order
  /// (caller should trigger a shake/wrong-order feedback).
  Branch? tapBranch(String branchId) {
    final index = branches.indexWhere((b) => b.id == branchId);
    if (index == -1) return null;
    if (branches[index].isTapped) return null;
    if (branches[index].order != nextExpected) return null;
    final updated = branches[index].markTapped();
    branches[index] = updated;
    nextExpected++;
    return updated;
  }
}
