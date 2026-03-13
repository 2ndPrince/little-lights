import 'package:flutter_test/flutter_test.dart';
import 'package:little_lights/game/noah/logic/matching_logic.dart';
import 'package:little_lights/game/noah/models/animal_pair.dart';
import 'package:little_lights/game/noah/models/noah_content.dart';

void main() {
  group('MatchingLogic.isValidPair', () {
    const lion1 = AnimalPair(
      id: 'lion_1',
      pairId: 'lion',
      flamePath: 'stories/noah/animals/lion_1.png',
      displayName: 'Lion',
    );
    const lion2 = AnimalPair(
      id: 'lion_2',
      pairId: 'lion',
      flamePath: 'stories/noah/animals/lion_2.png',
      displayName: 'Lion',
    );
    const elephant1 = AnimalPair(
      id: 'elephant_1',
      pairId: 'elephant',
      flamePath: 'stories/noah/animals/elephant_1.png',
      displayName: 'Elephant',
    );

    test('same pairId on different cards returns true', () {
      expect(MatchingLogic.isValidPair(lion1, lion2), isTrue);
    });

    test('different pairId returns false', () {
      expect(MatchingLogic.isValidPair(lion1, elephant1), isFalse);
    });

    test('same exact card (same id) returns false', () {
      expect(MatchingLogic.isValidPair(lion1, lion1), isFalse);
    });
  });

  group('MatchingLogic.allPairsLoaded', () {
    test('all pairs marked loaded returns true', () {
      final pairs = [
        const AnimalPair(
          id: 'lion_1', pairId: 'lion',
          flamePath: 'l1.png', displayName: 'Lion', isLoaded: true,
        ),
        const AnimalPair(
          id: 'lion_2', pairId: 'lion',
          flamePath: 'l2.png', displayName: 'Lion', isLoaded: true,
        ),
        const AnimalPair(
          id: 'elephant_1', pairId: 'elephant',
          flamePath: 'e1.png', displayName: 'Elephant', isLoaded: true,
        ),
        const AnimalPair(
          id: 'elephant_2', pairId: 'elephant',
          flamePath: 'e2.png', displayName: 'Elephant', isLoaded: true,
        ),
      ];
      expect(MatchingLogic.allPairsLoaded(pairs), isTrue);
    });

    test('one pair not loaded returns false', () {
      final pairs = [
        const AnimalPair(
          id: 'lion_1', pairId: 'lion',
          flamePath: 'l1.png', displayName: 'Lion', isLoaded: true,
        ),
        const AnimalPair(
          id: 'lion_2', pairId: 'lion',
          flamePath: 'l2.png', displayName: 'Lion', isLoaded: false,
        ),
      ];
      expect(MatchingLogic.allPairsLoaded(pairs), isFalse);
    });

    test('empty list returns false', () {
      expect(MatchingLogic.allPairsLoaded([]), isFalse);
    });
  });

  group('MatchingLogic.loadedCount', () {
    test('returns correct count of loaded pairs', () {
      final pairs = [
        const AnimalPair(
          id: 'lion_1', pairId: 'lion',
          flamePath: 'l1.png', displayName: 'Lion', isLoaded: true,
        ),
        const AnimalPair(
          id: 'lion_2', pairId: 'lion',
          flamePath: 'l2.png', displayName: 'Lion', isLoaded: true,
        ),
        const AnimalPair(
          id: 'elephant_1', pairId: 'elephant',
          flamePath: 'e1.png', displayName: 'Elephant', isLoaded: false,
        ),
        const AnimalPair(
          id: 'elephant_2', pairId: 'elephant',
          flamePath: 'e2.png', displayName: 'Elephant', isLoaded: false,
        ),
      ];
      // 2 loaded cards → 1 loaded pair
      expect(MatchingLogic.loadedCount(pairs), equals(1));
    });

    test('returns 0 when no cards are loaded', () {
      final pairs = [
        const AnimalPair(
          id: 'lion_1', pairId: 'lion',
          flamePath: 'l1.png', displayName: 'Lion',
        ),
        const AnimalPair(
          id: 'lion_2', pairId: 'lion',
          flamePath: 'l2.png', displayName: 'Lion',
        ),
      ];
      expect(MatchingLogic.loadedCount(pairs), equals(0));
    });
  });

  group('MatchingLogic.totalPairs', () {
    test('returns 3 for NoahContent.animalPairs', () {
      expect(
        MatchingLogic.totalPairs(NoahContent.animalPairs),
        equals(3),
      );
    });
  });
}
