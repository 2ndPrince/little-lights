import 'package:equatable/equatable.dart';

/// The moral theme of a Bible story.
enum StoryTheme {
  obedience,
  courage,
  trust,
  forgiveness,
  kindness,
  helping,
  generosity,
  wonder,
}

/// Identifies each story in the app.
/// Order is chronological — used for linear unlock sequencing.
enum StoryId { creation, adam, noah, moses, david, jonah, daniel, samaritan, feeding, zacchaeus }

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
