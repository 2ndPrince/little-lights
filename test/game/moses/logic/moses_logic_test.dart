import 'package:flutter_test/flutter_test.dart';
import 'package:little_lights/game/moses/logic/moses_logic.dart';
import 'package:little_lights/game/moses/models/moses_content.dart';
import 'package:little_lights/game/moses/models/water_wall.dart';

void main() {
  group('MosesLogic — initial state', () {
    test('movedCount is 0 at start', () {
      final logic = MosesLogic(List.of(MosesContent.walls));
      expect(logic.movedCount, equals(0));
    });

    test('allMoved is false at start', () {
      final logic = MosesLogic(List.of(MosesContent.walls));
      expect(logic.allMoved, isFalse);
    });
  });

  group('MosesLogic — moveWall', () {
    test('returns WaterWall for valid id', () {
      final logic = MosesLogic(List.of(MosesContent.walls));
      final result = logic.moveWall('wall_left');
      expect(result, isA<WaterWall>());
      expect(result!.id, equals('wall_left'));
      expect(result.isMoved, isTrue);
    });

    test('returns null for unknown id', () {
      final logic = MosesLogic(List.of(MosesContent.walls));
      final result = logic.moveWall('wall_unknown');
      expect(result, isNull);
    });

    test('returns null if already moved', () {
      final logic = MosesLogic(List.of(MosesContent.walls));
      logic.moveWall('wall_left');
      final second = logic.moveWall('wall_left');
      expect(second, isNull);
    });

    test('movedCount increments correctly', () {
      final logic = MosesLogic(List.of(MosesContent.walls));
      expect(logic.movedCount, equals(0));
      logic.moveWall('wall_left');
      expect(logic.movedCount, equals(1));
      logic.moveWall('wall_right');
      expect(logic.movedCount, equals(2));
    });

    test('double-move is no-op — movedCount stays same', () {
      final logic = MosesLogic(List.of(MosesContent.walls));
      logic.moveWall('wall_right');
      logic.moveWall('wall_right');
      expect(logic.movedCount, equals(1));
    });

    test('allMoved true after both walls moved', () {
      final logic = MosesLogic(List.of(MosesContent.walls));
      logic.moveWall('wall_left');
      logic.moveWall('wall_right');
      expect(logic.allMoved, isTrue);
    });

    test('allMoved false after only one wall moved', () {
      final logic = MosesLogic(List.of(MosesContent.walls));
      logic.moveWall('wall_left');
      expect(logic.allMoved, isFalse);
    });
  });
}
