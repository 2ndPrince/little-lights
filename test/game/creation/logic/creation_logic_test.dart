import 'package:flutter_test/flutter_test.dart';
import 'package:little_lights/game/creation/logic/creation_logic.dart';
import 'package:little_lights/game/creation/models/creation_content.dart';
import 'package:little_lights/game/creation/models/creation_element.dart';

void main() {
  group('CreationLogic — initial state', () {
    test('nextOrder starts at 1', () {
      final logic = CreationLogic(List.of(CreationContent.elements));
      expect(logic.nextOrder, equals(1));
    });

    test('allActivated is false at start', () {
      final logic = CreationLogic(List.of(CreationContent.elements));
      expect(logic.allActivated, isFalse);
    });
  });

  group('CreationLogic.tapElement', () {
    test('returns CreationElement for correct order tap', () {
      final logic = CreationLogic(List.of(CreationContent.elements));
      final result = logic.tapElement('light'); // order 1
      expect(result, isA<CreationElement>());
      expect(result!.id, equals('light'));
      expect(result.isActivated, isTrue);
    });

    test('returns null for wrong order tap', () {
      final logic = CreationLogic(List.of(CreationContent.elements));
      final result = logic.tapElement('sky'); // order 2, but nextOrder is 1
      expect(result, isNull);
    });

    test('nextOrder increments after correct tap', () {
      final logic = CreationLogic(List.of(CreationContent.elements));
      logic.tapElement('light'); // order 1
      expect(logic.nextOrder, equals(2));
    });

    test('wrong order does not advance nextOrder', () {
      final logic = CreationLogic(List.of(CreationContent.elements));
      logic.tapElement('sky'); // wrong — order 2 when nextOrder is 1
      expect(logic.nextOrder, equals(1));
    });

    test('returns null for unknown id', () {
      final logic = CreationLogic(List.of(CreationContent.elements));
      expect(logic.tapElement('nonexistent'), isNull);
    });

    test('returns null if already activated', () {
      final logic = CreationLogic(List.of(CreationContent.elements));
      logic.tapElement('light'); // activates light
      logic.tapElement('sky');   // advances to order 3
      // now try to tap light again (already activated)
      final result = logic.tapElement('light');
      expect(result, isNull);
    });

    test('can still complete after a wrong-order attempt', () {
      final logic = CreationLogic(List.of(CreationContent.elements));
      logic.tapElement('animals'); // wrong — order 6 when nextOrder is 1
      // now tap all in correct order
      logic.tapElement('light');
      logic.tapElement('sky');
      logic.tapElement('land');
      logic.tapElement('stars');
      logic.tapElement('birds');
      logic.tapElement('animals');
      expect(logic.allActivated, isTrue);
    });
  });

  group('CreationLogic.allActivated', () {
    test('allActivated is true after all 6 tapped in order', () {
      final logic = CreationLogic(List.of(CreationContent.elements));
      logic.tapElement('light');
      logic.tapElement('sky');
      logic.tapElement('land');
      logic.tapElement('stars');
      logic.tapElement('birds');
      logic.tapElement('animals');
      expect(logic.allActivated, isTrue);
    });

    test('allActivated is false after only 5 tapped', () {
      final logic = CreationLogic(List.of(CreationContent.elements));
      logic.tapElement('light');
      logic.tapElement('sky');
      logic.tapElement('land');
      logic.tapElement('stars');
      logic.tapElement('birds');
      expect(logic.allActivated, isFalse);
    });
  });
}
