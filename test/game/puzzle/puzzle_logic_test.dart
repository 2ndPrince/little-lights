import 'package:flutter_test/flutter_test.dart';
import 'package:little_lights/game/puzzle/puzzle_logic.dart';

void main() {
  group('PuzzleLogic — construction', () {
    test('3×4 grid creates exactly 12 pieces', () {
      final logic = PuzzleLogic(columns: 3, rows: 4);
      expect(logic.pieces.length, equals(12));
    });

    test('columns and rows are stored correctly', () {
      final logic = PuzzleLogic(columns: 3, rows: 4);
      expect(logic.columns, equals(3));
      expect(logic.rows, equals(4));
    });

    test('piece ids are 0-based sequential (0..11 for 3×4)', () {
      final logic = PuzzleLogic(columns: 3, rows: 4);
      final ids = logic.pieces.map((p) => p.id).toList();
      expect(ids, equals(List.generate(12, (i) => i)));
    });

    test('allPlaced is false immediately after construction', () {
      final logic = PuzzleLogic(columns: 3, rows: 4);
      expect(logic.allPlaced, isFalse);
    });
  });

  group('PuzzleLogic.placePiece', () {
    test('placePiece returns true and marks piece as placed', () {
      final logic = PuzzleLogic(columns: 3, rows: 4);
      final result = logic.placePiece(0);
      expect(result, isTrue);
      expect(logic.pieces.first.isPlaced, isTrue);
    });

    test('placePiece returns false if piece is already placed', () {
      final logic = PuzzleLogic(columns: 3, rows: 4);
      logic.placePiece(0);
      final second = logic.placePiece(0);
      expect(second, isFalse);
    });

    test('placing all pieces makes allPlaced true', () {
      final logic = PuzzleLogic(columns: 3, rows: 4);
      for (int i = 0; i < 12; i++) {
        logic.placePiece(i);
      }
      expect(logic.allPlaced, isTrue);
    });

    test('allPlaced is false until the very last piece is placed', () {
      final logic = PuzzleLogic(columns: 3, rows: 4);
      for (int i = 0; i < 11; i++) {
        logic.placePiece(i);
      }
      expect(logic.allPlaced, isFalse);
      logic.placePiece(11);
      expect(logic.allPlaced, isTrue);
    });
  });

  group('PuzzleLogic.reset', () {
    test('reset clears all placed pieces', () {
      final logic = PuzzleLogic(columns: 3, rows: 4);
      for (int i = 0; i < 12; i++) {
        logic.placePiece(i);
      }
      expect(logic.allPlaced, isTrue);
      logic.reset();
      expect(logic.allPlaced, isFalse);
      expect(logic.pieces.every((p) => !p.isPlaced), isTrue);
    });

    test('pieces can be placed again after reset', () {
      final logic = PuzzleLogic(columns: 3, rows: 4);
      logic.placePiece(5);
      logic.reset();
      final result = logic.placePiece(5);
      expect(result, isTrue);
    });
  });

  group('PuzzleLogic — piece metadata', () {
    test('piece at id 0 has column=0, row=0', () {
      final logic = PuzzleLogic(columns: 3, rows: 4);
      final p = logic.pieces.firstWhere((p) => p.id == 0);
      expect(p.column, equals(0));
      expect(p.row, equals(0));
    });

    test('piece at id 3 (second row, first col in 3×4) has column=0, row=1', () {
      final logic = PuzzleLogic(columns: 3, rows: 4);
      final p = logic.pieces.firstWhere((p) => p.id == 3);
      expect(p.column, equals(0));
      expect(p.row, equals(1));
    });
  });
}
