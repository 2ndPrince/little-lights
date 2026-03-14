import 'package:equatable/equatable.dart';

/// Represents one animal in the Adam and Eve mini-game.
class GardenAnimal extends Equatable {
  /// Unique ID for this animal (e.g., 'lion').
  final String id;

  /// Asset path for Flame image loading (relative to assets/images/).
  final String flamePath;

  /// Human-readable name displayed as feedback when named.
  final String displayName;

  /// Whether this animal has been named by the player.
  final bool isNamed;

  const GardenAnimal({
    required this.id,
    required this.flamePath,
    required this.displayName,
    this.isNamed = false,
  });

  /// Returns a copy with [isNamed] set to true.
  GardenAnimal markNamed() => GardenAnimal(
        id: id,
        flamePath: flamePath,
        displayName: displayName,
        isNamed: true,
      );

  @override
  List<Object?> get props => [id, flamePath, displayName, isNamed];
}
