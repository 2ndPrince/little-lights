import 'package:equatable/equatable.dart';

/// Represents one lion in the Daniel mini-game.
class Lion extends Equatable {
  /// Unique identifier for this lion.
  final String id;

  /// Asset path for Flame image loading (relative to assets/images/).
  final String flamePath;

  /// Whether the player has fed this lion.
  final bool isFed;

  const Lion({
    required this.id,
    required this.flamePath,
    this.isFed = false,
  });

  /// Returns a copy with [isFed] set to true.
  Lion markFed() => Lion(id: id, flamePath: flamePath, isFed: true);

  @override
  List<Object?> get props => [id, flamePath, isFed];
}
