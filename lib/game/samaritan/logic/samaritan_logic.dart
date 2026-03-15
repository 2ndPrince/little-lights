import '../models/healing_item.dart';

/// Pure game logic for the Samaritan healing mini-game.
///
/// No Flame imports. No Flutter imports. Fully unit-testable.
class SamaritanLogic {
  /// Mutable working copy of the items for this game session.
  final List<HealingItem> items;

  /// Creates a [SamaritanLogic] with the provided [initial] items.
  SamaritanLogic(List<HealingItem> initial) : items = List.of(initial);

  /// Number of items applied so far.
  int get appliedCount => items.where((i) => i.isApplied).length;

  /// True when every item has been applied.
  bool get allApplied => items.isNotEmpty && items.every((i) => i.isApplied);

  /// Marks the item with [itemId] as applied.
  ///
  /// Returns the updated [HealingItem] if found and not yet applied.
  /// Returns null if the id is unknown or the item is already applied.
  HealingItem? applyItem(String itemId) {
    final index = items.indexWhere((i) => i.id == itemId);
    if (index == -1) return null;
    if (items[index].isApplied) return null;
    final updated = items[index].markApplied();
    items[index] = updated;
    return updated;
  }
}
