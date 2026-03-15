import 'package:flutter_test/flutter_test.dart';
import 'package:little_lights/game/samaritan/logic/samaritan_logic.dart';
import 'package:little_lights/game/samaritan/models/healing_item.dart';
import 'package:little_lights/game/samaritan/models/samaritan_content.dart';

void main() {
  group('SamaritanLogic — initial state', () {
    test('appliedCount is 0 at start', () {
      final logic = SamaritanLogic(List.of(SamaritanContent.items));
      expect(logic.appliedCount, equals(0));
    });

    test('allApplied is false at start', () {
      final logic = SamaritanLogic(List.of(SamaritanContent.items));
      expect(logic.allApplied, isFalse);
    });
  });

  group('SamaritanLogic.applyItem', () {
    test('returns HealingItem for a valid unapplied id', () {
      final logic = SamaritanLogic(List.of(SamaritanContent.items));
      final result = logic.applyItem('bandage');
      expect(result, isA<HealingItem>());
      expect(result!.id, equals('bandage'));
      expect(result.isApplied, isTrue);
    });

    test('returns null for an unknown id', () {
      final logic = SamaritanLogic(List.of(SamaritanContent.items));
      expect(logic.applyItem('nonexistent'), isNull);
    });

    test('returns null if already applied', () {
      final logic = SamaritanLogic(List.of(SamaritanContent.items));
      logic.applyItem('bandage');
      final second = logic.applyItem('bandage');
      expect(second, isNull);
    });

    test('double-apply is no-op — appliedCount stays same', () {
      final logic = SamaritanLogic(List.of(SamaritanContent.items));
      logic.applyItem('bandage');
      logic.applyItem('bandage');
      expect(logic.appliedCount, equals(1));
    });

    test('appliedCount increments correctly after each apply', () {
      final logic = SamaritanLogic(List.of(SamaritanContent.items));
      logic.applyItem('bandage');
      expect(logic.appliedCount, equals(1));
      logic.applyItem('water');
      expect(logic.appliedCount, equals(2));
    });
  });

  group('SamaritanLogic.allApplied', () {
    test('allApplied is false after applying only 2 of 3', () {
      final logic = SamaritanLogic(List.of(SamaritanContent.items));
      logic.applyItem('bandage');
      logic.applyItem('water');
      expect(logic.allApplied, isFalse);
    });

    test('allApplied is true after applying all 3', () {
      final logic = SamaritanLogic(List.of(SamaritanContent.items));
      logic.applyItem('bandage');
      logic.applyItem('water');
      logic.applyItem('bread');
      expect(logic.allApplied, isTrue);
    });

    test('apply order does not matter — all 3 in any order sets allApplied', () {
      final logic = SamaritanLogic(List.of(SamaritanContent.items));
      logic.applyItem('bread');
      logic.applyItem('bandage');
      logic.applyItem('water');
      expect(logic.allApplied, isTrue);
    });
  });
}
