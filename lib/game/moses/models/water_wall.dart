import 'package:equatable/equatable.dart';

/// Which side of the sea a water wall stands on.
enum WaterWallSide { left, right }

/// Represents one water wall in the Moses mini-game.
class WaterWall extends Equatable {
  /// Unique identifier for this wall.
  final String id;

  /// Asset path for Flame image loading (relative to assets/images/).
  final String flamePath;

  /// Which side of the parted sea this wall belongs to.
  final WaterWallSide side;

  /// Whether the player has tapped this wall and it has moved aside.
  final bool isMoved;

  const WaterWall({
    required this.id,
    required this.flamePath,
    required this.side,
    this.isMoved = false,
  });

  /// Returns a copy with [isMoved] set to true.
  WaterWall markMoved() => WaterWall(
        id: id,
        flamePath: flamePath,
        side: side,
        isMoved: true,
      );

  @override
  List<Object?> get props => [id, flamePath, side, isMoved];
}
