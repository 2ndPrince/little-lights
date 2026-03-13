import 'package:flutter_test/flutter_test.dart';
import 'package:little_lights/data/models/story.dart';
import 'package:little_lights/data/models/story_progress.dart';
import '../../helpers/mock_progress_repository.dart';

void main() {
  late MockProgressRepository repo;

  setUp(() {
    repo = MockProgressRepository();
  });

  group('saveProgress / loadProgress round-trip', () {
    test('saved progress is returned by loadProgress', () async {
      const saved = StoryProgress(
        storyId: StoryId.noah,
        isUnlocked: true,
        isCompleted: true,
        starsEarned: 1,
      );

      await repo.saveProgress(saved);
      final loaded = await repo.loadProgress(StoryId.noah);

      expect(loaded, equals(saved));
    });
  });

  group('loadProgress with no saved data', () {
    test('noah defaults to unlocked, not completed, 0 stars', () async {
      final progress = await repo.loadProgress(StoryId.noah);

      expect(progress.isUnlocked, isTrue);
      expect(progress.isCompleted, isFalse);
      expect(progress.starsEarned, equals(0));
    });

    test('non-noah story defaults to locked, not completed, 0 stars', () async {
      // Start with a fresh repo seeded without david progress
      final freshRepo = MockProgressRepository();
      await freshRepo.resetAll();
      final progress = await freshRepo.loadProgress(StoryId.david);

      expect(progress.isUnlocked, isFalse);
      expect(progress.isCompleted, isFalse);
      expect(progress.starsEarned, equals(0));
    });
  });

  group('markComplete', () {
    test('markComplete sets completed = true and correct star count', () async {
      final original = await repo.loadProgress(StoryId.noah);
      final completed = original.markComplete(stars: 1);
      await repo.saveProgress(completed);

      final loaded = await repo.loadProgress(StoryId.noah);

      expect(loaded.isCompleted, isTrue);
      expect(loaded.starsEarned, equals(1));
    });
  });

  group('resetAll', () {
    test('clears all progress back to defaults', () async {
      // Dirty state: save a completed noah
      await repo.saveProgress(
        const StoryProgress(
          storyId: StoryId.noah,
          isUnlocked: true,
          isCompleted: true,
          starsEarned: 1,
        ),
      );

      await repo.resetAll();

      final noah = await repo.loadProgress(StoryId.noah);
      expect(noah.isCompleted, isFalse);
      expect(noah.starsEarned, equals(0));
    });
  });

  group('sound settings', () {
    test('getSoundEnabled returns true by default', () async {
      expect(await repo.getSoundEnabled(), isTrue);
    });

    test('setSoundEnabled persists false value', () async {
      await repo.setSoundEnabled(false);
      expect(await repo.getSoundEnabled(), isFalse);
    });

    test('setSoundEnabled persists true value after being set to false', () async {
      await repo.setSoundEnabled(false);
      await repo.setSoundEnabled(true);
      expect(await repo.getSoundEnabled(), isTrue);
    });
  });
}
