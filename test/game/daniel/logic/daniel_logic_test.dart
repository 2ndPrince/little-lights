import 'package:flutter_test/flutter_test.dart';
import 'package:little_lights/game/daniel/logic/daniel_logic.dart';
import 'package:little_lights/game/daniel/models/daniel_content.dart';
import 'package:little_lights/game/daniel/models/lion.dart';

void main() {
  group('DanielLogic — initial state', () {
    test('fedCount is 0 at start', () {
      final logic = DanielLogic(List.of(DanielContent.lions));
      expect(logic.fedCount, equals(0));
    });

    test('allFed is false at start', () {
      final logic = DanielLogic(List.of(DanielContent.lions));
      expect(logic.allFed, isFalse);
    });
  });

  group('DanielLogic — feedLion', () {
    test('returns Lion for valid id', () {
      final logic = DanielLogic(List.of(DanielContent.lions));
      final result = logic.feedLion('lion_1');
      expect(result, isA<Lion>());
      expect(result!.id, equals('lion_1'));
      expect(result.isFed, isTrue);
    });

    test('returns null for unknown id', () {
      final logic = DanielLogic(List.of(DanielContent.lions));
      final result = logic.feedLion('lion_99');
      expect(result, isNull);
    });

    test('returns null if already fed', () {
      final logic = DanielLogic(List.of(DanielContent.lions));
      logic.feedLion('lion_1');
      final second = logic.feedLion('lion_1');
      expect(second, isNull);
    });

    test('double-feed is no-op — fedCount stays same', () {
      final logic = DanielLogic(List.of(DanielContent.lions));
      logic.feedLion('lion_2');
      logic.feedLion('lion_2');
      expect(logic.fedCount, equals(1));
    });

    test('fedCount increments correctly', () {
      final logic = DanielLogic(List.of(DanielContent.lions));
      expect(logic.fedCount, equals(0));
      logic.feedLion('lion_1');
      expect(logic.fedCount, equals(1));
      logic.feedLion('lion_2');
      expect(logic.fedCount, equals(2));
      logic.feedLion('lion_3');
      expect(logic.fedCount, equals(3));
    });

    test('allFed true after all 3 lions fed', () {
      final logic = DanielLogic(List.of(DanielContent.lions));
      logic.feedLion('lion_1');
      logic.feedLion('lion_2');
      logic.feedLion('lion_3');
      expect(logic.allFed, isTrue);
    });

    test('allFed false after only 2 lions fed', () {
      final logic = DanielLogic(List.of(DanielContent.lions));
      logic.feedLion('lion_1');
      logic.feedLion('lion_2');
      expect(logic.allFed, isFalse);
    });

    test('allFed false after only 1 lion fed', () {
      final logic = DanielLogic(List.of(DanielContent.lions));
      logic.feedLion('lion_3');
      expect(logic.allFed, isFalse);
    });
  });
}
