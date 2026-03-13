import 'package:equatable/equatable.dart';
import 'story.dart';

/// Tracks a player's progress on a single story.
class StoryProgress extends Equatable {
  /// Which story this progress belongs to.
  final StoryId storyId;

  /// Whether this story is available to play.
  final bool isUnlocked;

  /// Whether the player has completed this story at least once.
  final bool isCompleted;

  /// Number of stars earned (0–1 in MVP; max 3 in future versions).
  final int starsEarned;

  const StoryProgress({
    required this.storyId,
    required this.isUnlocked,
    this.isCompleted = false,
    this.starsEarned = 0,
  });

  /// Returns a copy with completion and stars recorded.
  StoryProgress markComplete({int stars = 1}) => StoryProgress(
        storyId: storyId,
        isUnlocked: isUnlocked,
        isCompleted: true,
        starsEarned: stars,
      );

  /// Returns a copy with isUnlocked set to true.
  StoryProgress unlock() => StoryProgress(
        storyId: storyId,
        isUnlocked: true,
        isCompleted: isCompleted,
        starsEarned: starsEarned,
      );

  @override
  List<Object?> get props => [storyId, isUnlocked, isCompleted, starsEarned];
}
