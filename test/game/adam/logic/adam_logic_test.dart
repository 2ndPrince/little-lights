import 'package:flutter_test/flutter_test.dart';
import 'package:little_lights/game/adam/logic/adam_logic.dart';
import 'package:little_lights/game/adam/models/adam_content.dart';
import 'package:little_lights/game/adam/models/garden_animal.dart';

void main() {
  group('AdamLogic — initial state', () {
    test('namedCount is 0 at start', () {
      final logic = AdamLogic(List.of(AdamContent.animals));
      expect(logic.namedCount, equals(0));
    });

    test('allNamed is false at start', () {
      final logic = AdamLogic(List.of(AdamContent.animals));
      expect(logic.allNamed, isFalse);
    });
  });

  group('AdamLogic.nameAnimal', () {
    test('returns GardenAnimal for a valid unnamed id', () {
      final logic = AdamLogic(List.of(AdamContent.animals));
      final result = logic.nameAnimal('lion');
      expect(result, isA<GardenAnimal>());
      expect(result!.id, equals('lion'));
      expect(result.isNamed, isTrue);
    });

    test('returns null for an unknown id', () {
      final logic = AdamLogic(List.of(AdamContent.animals));
      expect(logic.nameAnimal('unicorn'), isNull);
    });

    test('returns null if already named', () {
      final logic = AdamLogic(List.of(AdamContent.animals));
      logic.nameAnimal('lion');
      final second = logic.nameAnimal('lion');
      expect(second, isNull);
    });

    test('double-name is a no-op — namedCount stays same', () {
      final logic = AdamLogic(List.of(AdamContent.animals));
      logic.nameAnimal('lion');
      logic.nameAnimal('lion');
      expect(logic.namedCount, equals(1));
    });

    test('namedCount increments correctly after each naming', () {
      final logic = AdamLogic(List.of(AdamContent.animals));
      logic.nameAnimal('lion');
      expect(logic.namedCount, equals(1));
      logic.nameAnimal('elephant');
      expect(logic.namedCount, equals(2));
    });
  });

  group('AdamLogic.allNamed', () {
    test('allNamed is false after naming only 3 of 4', () {
      final logic = AdamLogic(List.of(AdamContent.animals));
      logic.nameAnimal('lion');
      logic.nameAnimal('elephant');
      logic.nameAnimal('giraffe');
      expect(logic.allNamed, isFalse);
    });

    test('allNamed is true after naming all 4', () {
      final logic = AdamLogic(List.of(AdamContent.animals));
      logic.nameAnimal('lion');
      logic.nameAnimal('elephant');
      logic.nameAnimal('giraffe');
      logic.nameAnimal('bird');
      expect(logic.allNamed, isTrue);
    });

    test('collect order does not matter', () {
      final logic = AdamLogic(List.of(AdamContent.animals));
      logic.nameAnimal('bird');
      logic.nameAnimal('giraffe');
      logic.nameAnimal('lion');
      logic.nameAnimal('elephant');
      expect(logic.allNamed, isTrue);
    });
  });
}
