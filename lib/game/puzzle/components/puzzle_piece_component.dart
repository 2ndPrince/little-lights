import 'dart:ui' show Canvas;

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/foundation.dart';

/// A single draggable jigsaw puzzle piece.
///
/// Renders the correct slice of [fullSprite] based on [col] and [row].
/// Snap-targets [targetPosition] when dropped within 40 logical pixels.
class PuzzlePieceComponent extends PositionComponent with DragCallbacks {
  /// The full puzzle image to slice from.
  final Sprite fullSprite;

  /// Column index of this piece in the grid.
  final int col;

  /// Row index of this piece in the grid.
  final int row;

  /// Total columns in the puzzle grid — used to compute slice width.
  final int totalCols;

  /// Total rows in the puzzle grid — used to compute slice height.
  final int totalRows;

  /// World position this piece must reach to be considered placed.
  final Vector2 targetPosition;

  /// Called exactly once when this piece snaps into its target slot.
  final VoidCallback onPlaced;

  /// Whether this piece has been correctly placed and locked.
  bool isPlaced = false;

  late Sprite _pieceSprite;
  Vector2 _startPosition = Vector2.zero();

  PuzzlePieceComponent({
    required this.fullSprite,
    required this.col,
    required this.row,
    required this.totalCols,
    required this.totalRows,
    required this.targetPosition,
    required Vector2 pieceSize,
    required this.onPlaced,
    required Vector2 position,
  }) : super(position: position, size: pieceSize);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final sliceWidth = fullSprite.image.width / totalCols;
    final sliceHeight = fullSprite.image.height / totalRows;
    _pieceSprite = Sprite(
      fullSprite.image,
      srcPosition: Vector2(col * sliceWidth, row * sliceHeight),
      srcSize: Vector2(sliceWidth, sliceHeight),
    );
  }

  @override
  void render(Canvas canvas) {
    _pieceSprite.render(canvas, size: size);
  }

  @override
  void onDragStart(DragStartEvent event) {
    super.onDragStart(event);
    if (isPlaced) return;
    _startPosition = position.clone();
    scale = Vector2.all(1.05);
    priority = 10;
    event.continuePropagation = false;
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    if (isPlaced) return;
    position += event.localDelta;
  }

  @override
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);
    if (isPlaced) return;
    if (position.distanceTo(targetPosition) <= 40.0) {
      position = targetPosition.clone();
      scale = Vector2.all(1.0);
      priority = 5;
      isPlaced = true;
      onPlaced();
    } else {
      position = _startPosition.clone();
      scale = Vector2.all(1.0);
      priority = 0;
    }
  }

  @override
  void onDragCancel(DragCancelEvent event) {
    super.onDragCancel(event);
    if (isPlaced) return;
    position = _startPosition.clone();
    scale = Vector2.all(1.0);
    priority = 0;
  }
}
