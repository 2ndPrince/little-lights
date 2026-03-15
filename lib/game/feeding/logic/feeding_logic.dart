import '../models/food_item.dart';

/// Pure game logic for the Feeding the 5,000 mini-game.
///
/// No Flame imports. No Flutter imports. Fully unit-testable.
class FeedingLogic {
  /// Mutable working copy of the food items for this game session.
  final List<FoodItem> items;

  /// Creates a [FeedingLogic] with the provided [items].
  FeedingLogic(List<FoodItem> initial) : items = List.of(initial);

  /// Number of items collected so far.
  int get collectedCount => items.where((i) => i.isCollected).length;

  /// True when every item has been collected.
  bool get allCollected =>
      items.isNotEmpty && items.every((i) => i.isCollected);

  /// Marks the item with [itemId] as collected.
  ///
  /// Returns the updated [FoodItem] if found and not yet collected.
  /// Returns null if the id is unknown or the item is already collected.
  FoodItem? collectItem(String itemId) {
    final index = items.indexWhere((i) => i.id == itemId);
    if (index == -1) return null;
    if (items[index].isCollected) return null;
    final updated = items[index].markCollected();
    items[index] = updated;
    return updated;
  }
}
