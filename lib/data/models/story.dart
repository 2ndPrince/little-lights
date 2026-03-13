import 'package:equatable/equatable.dart';

/// The moral theme of a Bible story.
enum StoryTheme { obedience, courage, trust, forgiveness, kindness, helping }

/// Identifies each story in the app.
enum StoryId { noah, david, jonah, adam }

/// Metadata for a single Bible story.
class Story extends Equatable {
  /// Unique story identifier.
  final StoryId id;

  /// Display title (English fallback; i18n key used in v2).
  final String titleFallback;

  /// Flutter asset path for the story card thumbnail.
  final String thumbnailPath;

  /// Flutter asset path for background music.
  final String bgmPath;

  /// Core moral theme of the story.
  final StoryTheme theme;

  const Story({
    required this.id,
    required this.titleFallback,
    required this.thumbnailPath,
    required this.bgmPath,
    required this.theme,
  });

  @override
  List<Object?> get props => [id, titleFallback, thumbnailPath, bgmPath, theme];
}
