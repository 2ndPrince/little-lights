import 'package:equatable/equatable.dart';

/// Represents one food item in the Feeding the 5,000 mini-game.
class FoodItem extends Equatable {
  /// Unique identifier for this item.
  final String id;

  /// Flame-relative asset path for the item sprite.
  final String flamePath;

  /// Whether this item has been collected by the player.
  final bool isCollected;

  const FoodItem({
    required this.id,
    required this.flamePath,
    this.isCollected = false,
  });

  /// Returns a copy of this item marked as collected.
  FoodItem markCollected() =>
      FoodItem(id: id, flamePath: flamePath, isCollected: true);

  @override
  List<Object?> get props => [id, flamePath, isCollected];
}
