import '../../data/models/story.dart';

/// Configuration data for a single story's puzzle experience.
///
/// Passed to [PuzzleGame] via constructor — no Riverpod inside the game.
class PuzzleContent {
  /// The story this puzzle belongs to.
  final StoryId storyId;

  /// Flame path to the puzzle image (scene_01), relative to assets/images/.
  final String puzzleImageFlamePath;

  /// Flutter full asset paths for the 3 lesson scenes (scene_02–04).
  final List<String> lessonFlutterPaths;

  /// 3 captions, one per lesson scene.
  final List<String> lessonCaptions;

  /// Number of puzzle columns. Default is 3.
  final int columns;

  /// Number of puzzle rows. Default is 4. (3×4 = 12 pieces)
  final int rows;

  const PuzzleContent({
    required this.storyId,
    required this.puzzleImageFlamePath,
    required this.lessonFlutterPaths,
    required this.lessonCaptions,
    this.columns = 3,
    this.rows = 4,
  });
}
