import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:little_lights/providers/progress_provider.dart';
import 'mock_progress_repository.dart';

/// Creates a [ProviderContainer] with [progressRepositoryProvider] overridden
/// to use [MockProgressRepository]. Use this in all unit tests for providers.
///
/// Example:
/// ```dart
/// final container = makeTestContainer();
/// final notifier = container.read(progressProvider.notifier);
/// await notifier.markComplete(StoryId.noah);
/// ```
ProviderContainer makeTestContainer({
  MockProgressRepository? mockRepo,
}) {
  final repo = mockRepo ?? MockProgressRepository();
  return ProviderContainer(
    overrides: [
      progressRepositoryProvider.overrideWithValue(repo),
    ],
  );
}
