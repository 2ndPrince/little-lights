import 'package:equatable/equatable.dart';

/// Represents one storm cloud in the Jonah mini-game.
class StormCloud extends Equatable {
  /// Unique ID for this cloud (e.g., 'cloud_1').
  final String id;

  /// Asset path for Flame image loading (relative to assets/images/).
  final String flamePath;

  /// Whether this cloud has been calmed by the player.
  final bool isCalmed;

  const StormCloud({
    required this.id,
    required this.flamePath,
    this.isCalmed = false,
  });

  /// Returns a copy with [isCalmed] set to true.
  StormCloud markCalmed() => StormCloud(id: id, flamePath: flamePath, isCalmed: true);

  @override
  List<Object?> get props => [id, flamePath, isCalmed];
}
