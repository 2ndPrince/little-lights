import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:little_lights/data/models/story.dart';
import 'package:little_lights/providers/progress_provider.dart';

import '../helpers/mock_progress_repository.dart';
import '../helpers/test_providers.dart';

/// Triggers the provider build and pumps the microtask queue so
/// [ProgressNotifier._loadAll] can complete before assertions run.
Future<ProviderContainer> _makeSettledContainer({
  MockProgressRepository? mockRepo,
}) async {
  final container = makeTestContainer(mockRepo: mockRepo);
  container.read(progressProvider); // trigger build() → fires _loadAll
  await Future<void>.delayed(Duration.zero); // let _loadAll complete
  return container;
}

void main() {
  group('progressProvider', () {
    test('initial state has noah unlocked, others locked', () async {
      final container = await _makeSettledContainer();
      addTearDown(container.dispose);

      final state = container.read(progressProvider);
      expect(state[StoryId.noah]!.isUnlocked, isTrue);
      expect(state[StoryId.david]!.isUnlocked, isFalse);
      expect(state[StoryId.jonah]!.isUnlocked, isFalse);
      expect(state[StoryId.adam]!.isUnlocked, isFalse);
    });

    test('markComplete unlocks the next story', () async {
      final container = await _makeSettledContainer();
      addTearDown(container.dispose);

      await container.read(progressProvider.notifier).markComplete(StoryId.noah);

      final state = container.read(progressProvider);
      expect(state[StoryId.david]!.isUnlocked, isTrue);
    });

    test('markComplete does NOT skip stories', () async {
      final container = await _makeSettledContainer();
      addTearDown(container.dispose);

      await container.read(progressProvider.notifier).markComplete(StoryId.noah);

      final state = container.read(progressProvider);
      expect(state[StoryId.jonah]!.isUnlocked, isFalse);
    });

    test('markComplete updates stars on the completed story', () async {
      final container = await _makeSettledContainer();
      addTearDown(container.dispose);

      await container
          .read(progressProvider.notifier)
          .markComplete(StoryId.noah, stars: 1);

      final state = container.read(progressProvider);
      expect(state[StoryId.noah]!.starsEarned, equals(1));
    });

    test('resetAll returns everything to defaults', () async {
      final container = await _makeSettledContainer();
      addTearDown(container.dispose);

      final notifier = container.read(progressProvider.notifier);
      await notifier.markComplete(StoryId.noah);
      await notifier.resetAll();
      // let _loadAll inside resetAll complete
      await Future<void>.delayed(Duration.zero);

      final state = container.read(progressProvider);
      expect(state[StoryId.noah]!.isUnlocked, isTrue);
      expect(state[StoryId.noah]!.isCompleted, isFalse);
      expect(state[StoryId.david]!.isUnlocked, isFalse);
      expect(state[StoryId.jonah]!.isUnlocked, isFalse);
      expect(state[StoryId.adam]!.isUnlocked, isFalse);
    });

    test('linear unlock chain: noah → david → jonah; adam stays locked',
        () async {
      final container = await _makeSettledContainer();
      addTearDown(container.dispose);

      final notifier = container.read(progressProvider.notifier);
      await notifier.markComplete(StoryId.noah);
      await notifier.markComplete(StoryId.david);

      final state = container.read(progressProvider);
      expect(state[StoryId.jonah]!.isUnlocked, isTrue);
      expect(state[StoryId.adam]!.isUnlocked, isFalse);
    });

    test('isUnlocked returns true for noah initially', () async {
      final container = await _makeSettledContainer();
      addTearDown(container.dispose);

      final notifier = container.read(progressProvider.notifier);
      expect(notifier.isUnlocked(StoryId.noah), isTrue);
    });

    test('isCompleted returns false initially, true after markComplete',
        () async {
      final container = await _makeSettledContainer();
      addTearDown(container.dispose);

      final notifier = container.read(progressProvider.notifier);
      expect(notifier.isCompleted(StoryId.noah), isFalse);

      await notifier.markComplete(StoryId.noah);
      expect(notifier.isCompleted(StoryId.noah), isTrue);
    });
  });
}
