import 'package:equatable/equatable.dart';

/// Represents one healing item in the Samaritan mini-game.
class HealingItem extends Equatable {
  /// Unique identifier for this item.
  final String id;

  /// Flame-relative image path for this item.
  final String flamePath;

  /// Whether this item has been applied to the wounded man.
  final bool isApplied;

  const HealingItem({
    required this.id,
    required this.flamePath,
    this.isApplied = false,
  });

  /// Returns a copy of this item marked as applied.
  HealingItem markApplied() => HealingItem(id: id, flamePath: flamePath, isApplied: true);

  @override
  List<Object?> get props => [id, flamePath, isApplied];
}
