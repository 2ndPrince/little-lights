import 'package:flutter_test/flutter_test.dart';
import 'package:little_lights/game/feeding/logic/feeding_logic.dart';
import 'package:little_lights/game/feeding/models/feeding_content.dart';
import 'package:little_lights/game/feeding/models/food_item.dart';

void main() {
  group('FeedingLogic — initial state', () {
    test('collectedCount is 0 at start', () {
      final logic = FeedingLogic(List.of(FeedingContent.items));
      expect(logic.collectedCount, equals(0));
    });

    test('allCollected is false at start', () {
      final logic = FeedingLogic(List.of(FeedingContent.items));
      expect(logic.allCollected, isFalse);
    });
  });

  group('FeedingLogic.collectItem', () {
    test('returns FoodItem for a valid uncollected id', () {
      final logic = FeedingLogic(List.of(FeedingContent.items));
      final result = logic.collectItem('loaf_1');
      expect(result, isA<FoodItem>());
      expect(result!.id, equals('loaf_1'));
      expect(result.isCollected, isTrue);
    });

    test('returns null for an unknown id', () {
      final logic = FeedingLogic(List.of(FeedingContent.items));
      expect(logic.collectItem('nonexistent'), isNull);
    });

    test('returns null if already collected', () {
      final logic = FeedingLogic(List.of(FeedingContent.items));
      logic.collectItem('loaf_1');
      final second = logic.collectItem('loaf_1');
      expect(second, isNull);
    });

    test('double-collect is a no-op — collectedCount stays same', () {
      final logic = FeedingLogic(List.of(FeedingContent.items));
      logic.collectItem('loaf_1');
      logic.collectItem('loaf_1');
      expect(logic.collectedCount, equals(1));
    });

    test('collectedCount increments correctly after each collect', () {
      final logic = FeedingLogic(List.of(FeedingContent.items));
      logic.collectItem('loaf_1');
      expect(logic.collectedCount, equals(1));
      logic.collectItem('loaf_2');
      expect(logic.collectedCount, equals(2));
      logic.collectItem('fish_1');
      expect(logic.collectedCount, equals(3));
    });
  });

  group('FeedingLogic.allCollected', () {
    test('allCollected is false after collecting only 6 of 7', () {
      final logic = FeedingLogic(List.of(FeedingContent.items));
      logic.collectItem('loaf_1');
      logic.collectItem('loaf_2');
      logic.collectItem('loaf_3');
      logic.collectItem('loaf_4');
      logic.collectItem('loaf_5');
      logic.collectItem('fish_1');
      expect(logic.allCollected, isFalse);
    });

    test('allCollected is true after collecting all 7', () {
      final logic = FeedingLogic(List.of(FeedingContent.items));
      logic.collectItem('loaf_1');
      logic.collectItem('loaf_2');
      logic.collectItem('loaf_3');
      logic.collectItem('loaf_4');
      logic.collectItem('loaf_5');
      logic.collectItem('fish_1');
      logic.collectItem('fish_2');
      expect(logic.allCollected, isTrue);
    });

    test('collect order does not matter for allCollected', () {
      final logic = FeedingLogic(List.of(FeedingContent.items));
      logic.collectItem('fish_2');
      logic.collectItem('fish_1');
      logic.collectItem('loaf_5');
      logic.collectItem('loaf_4');
      logic.collectItem('loaf_3');
      logic.collectItem('loaf_2');
      logic.collectItem('loaf_1');
      expect(logic.allCollected, isTrue);
    });
  });
}
