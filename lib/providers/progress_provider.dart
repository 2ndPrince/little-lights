import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/models/story.dart';
import '../data/models/story_progress.dart';
import '../data/repositories/local/progress_repository.dart';

/// Provides the [SharedPreferences] instance, overridden in main.dart.
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('Override sharedPreferencesProvider in ProviderScope');
});

/// Provides the [ProgressRepository].
final progressRepositoryProvider = Provider<IProgressRepository>((ref) {
  return ProgressRepository(ref.watch(sharedPreferencesProvider));
});

/// Notifier that manages all story progress state.
class ProgressNotifier extends Notifier<Map<StoryId, StoryProgress>> {
  @override
  Map<StoryId, StoryProgress> build() {
    // Initialise with defaults; load from storage asynchronously
    _loadAll();
    return {
      StoryId.noah:  StoryProgress(storyId: StoryId.noah,  isUnlocked: true),
      StoryId.david: StoryProgress(storyId: StoryId.david, isUnlocked: false),
      StoryId.jonah: StoryProgress(storyId: StoryId.jonah, isUnlocked: false),
      StoryId.adam:  StoryProgress(storyId: StoryId.adam,  isUnlocked: false),
    };
  }

  IProgressRepository get _repo => ref.read(progressRepositoryProvider);

  Future<void> _loadAll() async {
    final updated = <StoryId, StoryProgress>{};
    for (final id in StoryId.values) {
      updated[id] = await _repo.loadProgress(id);
    }
    // Apply linear unlock rule
    state = _applyUnlockRules(updated);
  }

  /// Marks [storyId] complete, saves, and unlocks the next story.
  Future<void> markComplete(StoryId storyId, {int stars = 1}) async {
    final updated = Map<StoryId, StoryProgress>.from(state);
    updated[storyId] = updated[storyId]!.markComplete(stars: stars);
    await _repo.saveProgress(updated[storyId]!);
    state = _applyUnlockRules(updated);
  }

  /// Resets all progress. Used via parent gate.
  Future<void> resetAll() async {
    await _repo.resetAll();
    await _loadAll();
  }

  /// Returns true if [storyId] is unlocked.
  bool isUnlocked(StoryId storyId) => state[storyId]?.isUnlocked ?? false;

  /// Returns true if [storyId] is completed.
  bool isCompleted(StoryId storyId) => state[storyId]?.isCompleted ?? false;

  /// Enforces linear unlock: each story unlocks only when the previous is done.
  static Map<StoryId, StoryProgress> _applyUnlockRules(
    Map<StoryId, StoryProgress> input,
  ) {
    final ordered = StoryId.values; // noah, david, jonah, adam
    final result = Map<StoryId, StoryProgress>.from(input);
    for (int i = 1; i < ordered.length; i++) {
      final prev = ordered[i - 1];
      final curr = ordered[i];
      if (result[prev]?.isCompleted == true) {
        if (result[curr]?.isUnlocked == false) {
          result[curr] = result[curr]!.unlock();
        }
      }
    }
    return result;
  }
}

/// The main progress provider — use this in UI widgets.
final progressProvider =
    NotifierProvider<ProgressNotifier, Map<StoryId, StoryProgress>>(
  ProgressNotifier.new,
);
