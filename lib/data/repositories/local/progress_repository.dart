import 'package:shared_preferences/shared_preferences.dart';
import '../../models/story.dart';
import '../../models/story_progress.dart';

/// Contract for reading and writing story progress.
abstract interface class IProgressRepository {
  Future<StoryProgress> loadProgress(StoryId storyId);
  Future<void> saveProgress(StoryProgress progress);
  Future<void> resetAll();
  Future<bool> getSoundEnabled();
  Future<void> setSoundEnabled(bool value);
}

/// SharedPreferences-backed implementation of [IProgressRepository].
///
/// Key schema (all keys are private constants):
///   progress_{storyId}_completed  → bool
///   progress_{storyId}_stars      → int
///   settings_sound_enabled        → bool
class ProgressRepository implements IProgressRepository {
  const ProgressRepository(this._prefs);

  final SharedPreferences _prefs;

  // ── Key helpers ──────────────────────────────────────────────────────────

  static String _completedKey(StoryId id) => 'progress_${id.name}_completed';
  static String _starsKey(StoryId id)     => 'progress_${id.name}_stars';
  static const String _soundKey           = 'settings_sound_enabled';

  // ── Noah is the only story unlocked by default ───────────────────────────
  static bool _defaultUnlocked(StoryId id) => id == StoryId.noah;

  // ── IProgressRepository ──────────────────────────────────────────────────

  @override
  Future<StoryProgress> loadProgress(StoryId storyId) async {
    final completed = _prefs.getBool(_completedKey(storyId)) ?? false;
    final stars     = _prefs.getInt(_starsKey(storyId)) ?? 0;
    return StoryProgress(
      storyId:    storyId,
      isUnlocked: _defaultUnlocked(storyId) || completed,
      isCompleted: completed,
      starsEarned: stars,
    );
  }

  @override
  Future<void> saveProgress(StoryProgress progress) async {
    await _prefs.setBool(_completedKey(progress.storyId), progress.isCompleted);
    await _prefs.setInt(_starsKey(progress.storyId), progress.starsEarned);
  }

  @override
  Future<void> resetAll() async {
    for (final id in StoryId.values) {
      await _prefs.remove(_completedKey(id));
      await _prefs.remove(_starsKey(id));
    }
  }

  @override
  Future<bool> getSoundEnabled() async =>
      _prefs.getBool(_soundKey) ?? true;

  @override
  Future<void> setSoundEnabled(bool value) async =>
      _prefs.setBool(_soundKey, value);
}
