import '../models/water_wall.dart';

/// Pure game logic for the Moses Red Sea mini-game.
///
/// No Flame imports. No Flutter imports. Fully unit-testable.
class MosesLogic {
  /// Mutable working copy of the walls for this game session.
  final List<WaterWall> walls;

  /// Creates a [MosesLogic] with the provided [walls].
  MosesLogic(List<WaterWall> initial) : walls = List.of(initial);

  /// Number of walls moved so far.
  int get movedCount => walls.where((w) => w.isMoved).length;

  /// True when both walls have been moved.
  bool get allMoved => walls.isNotEmpty && walls.every((w) => w.isMoved);

  /// Marks the wall with [wallId] as moved.
  ///
  /// Returns the updated [WaterWall] if found and not yet moved.
  /// Returns null if the id is unknown or the wall is already moved.
  WaterWall? moveWall(String wallId) {
    final index = walls.indexWhere((w) => w.id == wallId);
    if (index == -1) return null;
    if (walls[index].isMoved) return null;
    final updated = walls[index].markMoved();
    walls[index] = updated;
    return updated;
  }
}
