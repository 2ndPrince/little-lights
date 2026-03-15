import '../models/creation_element.dart';

/// Pure game logic for the Creation mini-game.
///
/// No Flame imports. No Flutter imports. Fully unit-testable.
/// Elements must be tapped in order from 1 to 6.
class CreationLogic {
  /// Mutable working copy of the creation elements for this game session.
  final List<CreationElement> elements;

  /// The order number that must be tapped next. Starts at 1.
  int nextOrder;

  /// Creates a [CreationLogic] with the provided [elements].
  CreationLogic(List<CreationElement> initial)
      : elements = List.of(initial),
        nextOrder = 1;

  /// True when every element has been activated in order.
  bool get allActivated =>
      elements.isNotEmpty && elements.every((e) => e.isActivated);

  /// Attempts to activate the element with [elementId].
  ///
  /// Returns the updated [CreationElement] if the element exists, is not yet
  /// activated, and its [CreationElement.order] matches [nextOrder].
  /// Returns null if the element is unknown, already activated, or tapped out of order.
  CreationElement? tapElement(String elementId) {
    final index = elements.indexWhere((e) => e.id == elementId);
    if (index == -1) return null;
    if (elements[index].isActivated) return null;
    if (elements[index].order != nextOrder) return null;

    final updated = elements[index].markActivated();
    elements[index] = updated;
    nextOrder++;
    return updated;
  }
}
