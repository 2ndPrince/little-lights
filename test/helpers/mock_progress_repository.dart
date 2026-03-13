import 'package:little_lights/data/models/story.dart';
import 'package:little_lights/data/models/story_progress.dart';
import 'package:little_lights/data/repositories/local/progress_repository.dart';

/// In-memory mock of [IProgressRepository] for use in tests.
/// Never touches SharedPreferences.
class MockProgressRepository implements IProgressRepository {
  final Map<StoryId, StoryProgress> _progress = {
    StoryId.noah:  StoryProgress(storyId: StoryId.noah,  isUnlocked: true),
    StoryId.david: StoryProgress(storyId: StoryId.david, isUnlocked: false),
    StoryId.jonah: StoryProgress(storyId: StoryId.jonah, isUnlocked: false),
    StoryId.adam:  StoryProgress(storyId: StoryId.adam,  isUnlocked: false),
  };

  bool _soundEnabled = true;

  /// Pre-seed progress for a story (useful in test setup).
  void seedProgress(StoryProgress progress) {
    _progress[progress.storyId] = progress;
  }

  @override
  Future<StoryProgress> loadProgress(StoryId storyId) async =>
      _progress[storyId] ??
      StoryProgress(storyId: storyId, isUnlocked: storyId == StoryId.noah);

  @override
  Future<void> saveProgress(StoryProgress progress) async {
    _progress[progress.storyId] = progress;
  }

  @override
  Future<void> resetAll() async {
    for (final id in StoryId.values) {
      _progress[id] = StoryProgress(
        storyId: id,
        isUnlocked: id == StoryId.noah,
      );
    }
    _soundEnabled = true;
  }

  @override
  Future<bool> getSoundEnabled() async => _soundEnabled;

  @override
  Future<void> setSoundEnabled(bool value) async {
    _soundEnabled = value;
  }
}
