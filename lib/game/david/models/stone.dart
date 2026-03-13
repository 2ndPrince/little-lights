import 'package:equatable/equatable.dart';

/// Represents one stone in the David and Goliath mini-game.
class Stone extends Equatable {
  /// Unique ID for this stone (e.g., 'pebble_1').
  final String id;

  /// Asset path for Flame image loading (relative to assets/images/).
  final String flamePath;

  /// Human-readable name used for accessibility / future narration.
  final String displayName;

  /// Whether this stone has been collected by the player.
  final bool isCollected;

  const Stone({
    required this.id,
    required this.flamePath,
    required this.displayName,
    this.isCollected = false,
  });

  /// Returns a copy with [isCollected] set to true.
  Stone markCollected() => Stone(
        id: id,
        flamePath: flamePath,
        displayName: displayName,
        isCollected: true,
      );

  @override
  List<Object?> get props => [id, flamePath, displayName, isCollected];
}
