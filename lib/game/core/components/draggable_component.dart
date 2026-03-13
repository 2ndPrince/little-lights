import 'package:flame/components.dart';
import 'package:flame/events.dart';

/// Reusable mixin that adds drag behaviour to any [PositionComponent].
///
/// Apply to any Flame component that needs drag-and-drop:
/// ```dart
/// class AnimalCard extends SpriteComponent with Draggable {}
/// ```
///
/// Provides:
/// - Raises [priority] while dragging (brings to front)
/// - Tracks origin for snap-back
/// - Calls [onDropped] when drag ends (override to implement drop logic)
mixin Draggable on PositionComponent, DragCallbacks {
  /// Saved position at drag start — used to snap back on failed drop.
  late Vector2 _dragOrigin;

  /// Whether this component is currently being dragged.
  bool get isDragging => _dragging;
  bool _dragging = false;

  /// Override to define what happens when the drag is released.
  /// Return `true` if the drop was accepted (no snap-back).
  /// Return `false` to snap back to origin.
  bool onDragReleased(Vector2 dropPosition) => false;

  @override
  void onDragStart(DragStartEvent event) {
    super.onDragStart(event);
    _dragOrigin = position.clone();
    _dragging = true;
    priority = 100; // bring to front
    event.continuePropagation = false;
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    position += event.localDelta;
  }

  @override
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);
    _dragging = false;
    priority = 0;
    final accepted = onDragReleased(position);
    if (!accepted) {
      _snapBack();
    }
  }

  @override
  void onDragCancel(DragCancelEvent event) {
    super.onDragCancel(event);
    _dragging = false;
    priority = 0;
    _snapBack();
  }

  /// Instantly returns component to its pre-drag position.
  /// Override for animated snap-back.
  void _snapBack() {
    position = _dragOrigin;
  }

  /// Returns the origin position before the last drag started.
  Vector2 get dragOrigin => _dragOrigin;
}
