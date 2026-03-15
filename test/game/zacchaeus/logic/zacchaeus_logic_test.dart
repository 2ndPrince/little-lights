import 'package:flutter_test/flutter_test.dart';
import 'package:little_lights/game/zacchaeus/logic/zacchaeus_logic.dart';
import 'package:little_lights/game/zacchaeus/models/branch.dart';
import 'package:little_lights/game/zacchaeus/models/zacchaeus_content.dart';

void main() {
  group('ZacchaeusLogic — initial state', () {
    test('nextExpected starts at 1', () {
      final logic = ZacchaeusLogic(List.of(ZacchaeusContent.branches));
      expect(logic.nextExpected, equals(1));
    });

    test('allDescended is false at start', () {
      final logic = ZacchaeusLogic(List.of(ZacchaeusContent.branches));
      expect(logic.allDescended, isFalse);
    });
  });

  group('ZacchaeusLogic.tapBranch', () {
    test('returns Branch when tapped in correct order', () {
      final logic = ZacchaeusLogic(List.of(ZacchaeusContent.branches));
      final result = logic.tapBranch('branch_1');
      expect(result, isA<Branch>());
      expect(result!.id, equals('branch_1'));
      expect(result.isTapped, isTrue);
    });

    test('returns null when tapped in wrong order', () {
      final logic = ZacchaeusLogic(List.of(ZacchaeusContent.branches));
      // branch_2 before branch_1 is wrong
      final result = logic.tapBranch('branch_2');
      expect(result, isNull);
    });

    test('nextExpected increments after a correct tap', () {
      final logic = ZacchaeusLogic(List.of(ZacchaeusContent.branches));
      logic.tapBranch('branch_1');
      expect(logic.nextExpected, equals(2));
    });

    test('allDescended is true after tapping all 3 in order', () {
      final logic = ZacchaeusLogic(List.of(ZacchaeusContent.branches));
      logic.tapBranch('branch_1');
      logic.tapBranch('branch_2');
      logic.tapBranch('branch_3');
      expect(logic.allDescended, isTrue);
    });

    test('wrong order does not advance nextExpected', () {
      final logic = ZacchaeusLogic(List.of(ZacchaeusContent.branches));
      logic.tapBranch('branch_2'); // wrong — branch_1 not tapped yet
      expect(logic.nextExpected, equals(1));
    });

    test('returns null for an unknown id', () {
      final logic = ZacchaeusLogic(List.of(ZacchaeusContent.branches));
      expect(logic.tapBranch('nonexistent'), isNull);
    });

    test('tapping correct order after a wrong attempt still works', () {
      final logic = ZacchaeusLogic(List.of(ZacchaeusContent.branches));
      logic.tapBranch('branch_3'); // wrong
      logic.tapBranch('branch_2'); // wrong
      final result = logic.tapBranch('branch_1'); // correct
      expect(result, isA<Branch>());
      expect(result!.isTapped, isTrue);
      expect(logic.nextExpected, equals(2));
    });

    test('returns null for already tapped branch', () {
      final logic = ZacchaeusLogic(List.of(ZacchaeusContent.branches));
      logic.tapBranch('branch_1');
      final second = logic.tapBranch('branch_1');
      expect(second, isNull);
    });

    test('allDescended is false after only 2 tapped in order', () {
      final logic = ZacchaeusLogic(List.of(ZacchaeusContent.branches));
      logic.tapBranch('branch_1');
      logic.tapBranch('branch_2');
      expect(logic.allDescended, isFalse);
    });
  });
}
