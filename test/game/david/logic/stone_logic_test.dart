import 'package:flutter_test/flutter_test.dart';
import 'package:little_lights/game/david/logic/stone_logic.dart';
import 'package:little_lights/game/david/models/david_content.dart';
import 'package:little_lights/game/david/models/stone.dart';

void main() {
  group('StoneLogic — initial state', () {
    test('collectedCount is 0 at start', () {
      final logic = StoneLogic(List.of(DavidContent.stones));
      expect(logic.collectedCount, equals(0));
    });

    test('allCollected is false at start', () {
      final logic = StoneLogic(List.of(DavidContent.stones));
      expect(logic.allCollected, isFalse);
    });
  });

  group('StoneLogic.collectStone', () {
    test('returns Stone for a valid uncollected id', () {
      final logic = StoneLogic(List.of(DavidContent.stones));
      final result = logic.collectStone('pebble_1');
      expect(result, isA<Stone>());
      expect(result!.id, equals('pebble_1'));
      expect(result.isCollected, isTrue);
    });

    test('returns null for an unknown id', () {
      final logic = StoneLogic(List.of(DavidContent.stones));
      expect(logic.collectStone('nonexistent'), isNull);
    });

    test('returns null for an already-collected stone', () {
      final logic = StoneLogic(List.of(DavidContent.stones));
      logic.collectStone('pebble_1'); // first collect
      final second = logic.collectStone('pebble_1'); // duplicate
      expect(second, isNull);
    });

    test('double-collect is a no-op — collectedCount stays same', () {
      final logic = StoneLogic(List.of(DavidContent.stones));
      logic.collectStone('pebble_1');
      logic.collectStone('pebble_1');
      expect(logic.collectedCount, equals(1));
    });

    test('collectedCount increments correctly after each collect', () {
      final logic = StoneLogic(List.of(DavidContent.stones));
      logic.collectStone('pebble_1');
      expect(logic.collectedCount, equals(1));
      logic.collectStone('pebble_2');
      expect(logic.collectedCount, equals(2));
    });
  });

  group('StoneLogic.allCollected', () {
    test('allCollected is false after collecting only 2 of 3', () {
      final logic = StoneLogic(List.of(DavidContent.stones));
      logic.collectStone('pebble_1');
      logic.collectStone('pebble_2');
      expect(logic.allCollected, isFalse);
    });

    test('allCollected is true after collecting all 3', () {
      final logic = StoneLogic(List.of(DavidContent.stones));
      logic.collectStone('pebble_1');
      logic.collectStone('pebble_2');
      logic.collectStone('pebble_3');
      expect(logic.allCollected, isTrue);
    });

    test('collect order does not matter', () {
      final logic = StoneLogic(List.of(DavidContent.stones));
      logic.collectStone('pebble_3');
      logic.collectStone('pebble_1');
      logic.collectStone('pebble_2');
      expect(logic.allCollected, isTrue);
    });
  });
}
