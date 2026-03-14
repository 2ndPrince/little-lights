import 'package:flutter_test/flutter_test.dart';
import 'package:little_lights/game/jonah/logic/jonah_logic.dart';
import 'package:little_lights/game/jonah/models/jonah_content.dart';
import 'package:little_lights/game/jonah/models/storm_cloud.dart';

void main() {
  group('JonahLogic — initial state', () {
    test('calmedCount is 0 at start', () {
      final logic = JonahLogic(List.of(JonahContent.clouds));
      expect(logic.calmedCount, equals(0));
    });

    test('allCalmed is false at start', () {
      final logic = JonahLogic(List.of(JonahContent.clouds));
      expect(logic.allCalmed, isFalse);
    });
  });

  group('JonahLogic.calmCloud', () {
    test('returns StormCloud for a valid uncalmed id', () {
      final logic = JonahLogic(List.of(JonahContent.clouds));
      final result = logic.calmCloud('cloud_1');
      expect(result, isA<StormCloud>());
      expect(result!.id, equals('cloud_1'));
      expect(result.isCalmed, isTrue);
    });

    test('returns null for an unknown id', () {
      final logic = JonahLogic(List.of(JonahContent.clouds));
      expect(logic.calmCloud('nonexistent'), isNull);
    });

    test('returns null if already calmed', () {
      final logic = JonahLogic(List.of(JonahContent.clouds));
      logic.calmCloud('cloud_1');
      final second = logic.calmCloud('cloud_1');
      expect(second, isNull);
    });

    test('double-calm is a no-op — calmedCount stays same', () {
      final logic = JonahLogic(List.of(JonahContent.clouds));
      logic.calmCloud('cloud_1');
      logic.calmCloud('cloud_1');
      expect(logic.calmedCount, equals(1));
    });

    test('calmedCount increments correctly after each calm', () {
      final logic = JonahLogic(List.of(JonahContent.clouds));
      logic.calmCloud('cloud_1');
      expect(logic.calmedCount, equals(1));
      logic.calmCloud('cloud_2');
      expect(logic.calmedCount, equals(2));
    });
  });

  group('JonahLogic.allCalmed', () {
    test('allCalmed is false after calming only 2 of 3', () {
      final logic = JonahLogic(List.of(JonahContent.clouds));
      logic.calmCloud('cloud_1');
      logic.calmCloud('cloud_2');
      expect(logic.allCalmed, isFalse);
    });

    test('allCalmed is true after calming all 3', () {
      final logic = JonahLogic(List.of(JonahContent.clouds));
      logic.calmCloud('cloud_1');
      logic.calmCloud('cloud_2');
      logic.calmCloud('cloud_3');
      expect(logic.allCalmed, isTrue);
    });

    test('collect order does not matter', () {
      final logic = JonahLogic(List.of(JonahContent.clouds));
      logic.calmCloud('cloud_3');
      logic.calmCloud('cloud_1');
      logic.calmCloud('cloud_2');
      expect(logic.allCalmed, isTrue);
    });
  });
}
