import 'package:equatable/equatable.dart';
import 'story.dart';

/// The reward earned on completing a story.
class Reward extends Equatable {
  /// Story this reward belongs to.
  final StoryId storyId;

  /// Number of stars awarded (MVP: always 1).
  final int stars;

  /// Unique identifier for the badge (e.g., 'badge_noah').
  final String badgeId;

  /// Human-readable badge name shown on the reward screen.
  final String badgeName;

  /// Flutter asset path for the badge icon image.
  final String badgeIconPath;

  const Reward({
    required this.storyId,
    required this.stars,
    required this.badgeId,
    required this.badgeName,
    required this.badgeIconPath,
  });

  @override
  List<Object?> get props => [storyId, stars, badgeId, badgeName, badgeIconPath];
}
