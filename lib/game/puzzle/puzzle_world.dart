import 'dart:math';
import 'dart:ui' as ui;

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'components/puzzle_piece_component.dart';
import 'puzzle_content.dart';

/// Flame world that lays out the jigsaw puzzle grid and piece tray.
///
/// Positions ghost-outline slots at their target grid locations and scatters
/// [PuzzlePieceComponent]s randomly in the tray area below.
class PuzzleWorld extends PositionComponent {
  final ui.Image puzzleImage;
  final PuzzleContent content;
  final void Function(int pieceId) onPiecePlaced;

  final List<PuzzlePieceComponent> _pieces = [];

  /// All puzzle piece components, in piece-id order.
  List<PuzzlePieceComponent> get pieces => List.unmodifiable(_pieces);

  PuzzleWorld({
    required this.puzzleImage,
    required this.content,
    required this.onPiecePlaced,
  }) : super(anchor: Anchor.topLeft);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final screenSize = findGame()!.size;
    final fullSprite = Sprite(puzzleImage);

    final cols = content.columns;
    final rows = content.rows;

    // Grid occupies the top 60% of the screen.
    final gridAreaH = screenSize.y * 0.60;
    final pieceW = screenSize.x / cols;
    final pieceH = gridAreaH / rows;
    final pieceSize = Vector2(pieceW, pieceH);

    // Tray occupies the bottom 40%.
    final trayTop = gridAreaH;
    final trayH = screenSize.y * 0.40;

    // Background for the grid area.
    add(RectangleComponent(
      size: Vector2(screenSize.x, gridAreaH),
      paint: Paint()..color = const Color(0xFF1A1A2E),
    ));

    // Background for the tray area.
    add(RectangleComponent(
      position: Vector2(0, trayTop),
      size: Vector2(screenSize.x, trayH),
      paint: Paint()..color = const Color(0xFF2A2A3E),
    ));

    // Ghost outline slots at target grid positions.
    final ghostPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    for (int r = 0; r < rows; r++) {
      for (int c = 0; c < cols; c++) {
        final targetPos = Vector2(c * pieceW, r * pieceH);
        add(RectangleComponent(
          position: targetPos,
          size: pieceSize,
          paint: ghostPaint,
          priority: -1,
        ));
      }
    }

    // Scatter pieces in the tray area.
    final rng = Random();
    final maxX = screenSize.x - pieceW;
    final maxY = trayTop + trayH - pieceH;

    for (int r = 0; r < rows; r++) {
      for (int c = 0; c < cols; c++) {
        final id = r * cols + c;
        final targetPos = Vector2(c * pieceW, r * pieceH);

        final spawnX = rng.nextDouble() * maxX;
        final spawnY = trayTop + rng.nextDouble() * (maxY - trayTop).clamp(0, double.infinity);

        final piece = PuzzlePieceComponent(
          fullSprite: fullSprite,
          col: c,
          row: r,
          totalCols: cols,
          totalRows: rows,
          targetPosition: targetPos,
          pieceSize: pieceSize,
          onPlaced: () => onPiecePlaced(id),
          position: Vector2(spawnX, spawnY),
        );
        _pieces.add(piece);
        await add(piece);
      }
    }
  }
}
