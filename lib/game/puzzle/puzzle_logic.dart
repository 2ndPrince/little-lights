/// A single puzzle piece's mutable state.
class PuzzlePiece {
  /// Zero-based unique identifier: row * columns + column.
  final int id;

  /// Column index of this piece in the grid.
  final int column;

  /// Row index of this piece in the grid.
  final int row;

  /// Whether this piece has been correctly placed by the player.
  bool isPlaced;

  PuzzlePiece({
    required this.id,
    required this.column,
    required this.row,
  }) : isPlaced = false;
}

/// Pure logic engine for the jigsaw puzzle — no Flutter or Flame dependencies.
///
/// Tracks which pieces have been placed. Call [placePiece] when a piece
/// snaps into position and check [allPlaced] to detect completion.
class PuzzleLogic {
  /// Number of columns in the grid.
  final int columns;

  /// Number of rows in the grid.
  final int rows;

  /// All pieces in row-major order: row 0 first, then row 1, etc.
  late final List<PuzzlePiece> pieces;

  PuzzleLogic({required this.columns, required this.rows}) {
    pieces = [
      for (int r = 0; r < rows; r++)
        for (int c = 0; c < columns; c++)
          PuzzlePiece(id: r * columns + c, column: c, row: r),
    ];
  }

  /// Marks piece with [id] as placed.
  ///
  /// Returns `true` if the piece was successfully placed.
  /// Returns `false` if the piece was already placed or the id is invalid.
  bool placePiece(int id) {
    final piece = _findById(id);
    if (piece == null || piece.isPlaced) return false;
    piece.isPlaced = true;
    return true;
  }

  /// `true` when every piece has been placed.
  bool get allPlaced => pieces.every((p) => p.isPlaced);

  /// Resets all pieces to unplaced so the puzzle can be replayed.
  void reset() {
    for (final p in pieces) {
      p.isPlaced = false;
    }
  }

  PuzzlePiece? _findById(int id) {
    for (final p in pieces) {
      if (p.id == id) return p;
    }
    return null;
  }
}
