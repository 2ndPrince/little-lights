import '../models/story.dart';

/// Static registry of all stories in the app.
///
/// Noah is the only fully implemented story in MVP.
/// David, Jonah, Adam are stubs — unlocked via progress system in future versions.
const List<Story> allStories = [
  Story(
    id: StoryId.noah,
    titleFallback: "Noah's Ark",
    thumbnailPath: 'assets/images/stories/noah/ui/ark.png',
    bgmPath: 'assets/audio/music/bgm_noah.mp3',
    theme: StoryTheme.obedience,
  ),
  Story(
    id: StoryId.david,
    titleFallback: 'David and Goliath',
    thumbnailPath: 'assets/images/ui/btn_play.png', // placeholder until david art exists
    bgmPath: 'assets/audio/music/bgm_noah.mp3',     // placeholder until david bgm exists
    theme: StoryTheme.courage,
  ),
  Story(
    id: StoryId.jonah,
    titleFallback: 'Jonah',
    thumbnailPath: 'assets/images/ui/btn_play.png', // placeholder
    bgmPath: 'assets/audio/music/bgm_noah.mp3',     // placeholder
    theme: StoryTheme.obedience,
  ),
  Story(
    id: StoryId.adam,
    titleFallback: 'Adam and Eve',
    thumbnailPath: 'assets/images/ui/btn_play.png', // placeholder
    bgmPath: 'assets/audio/music/bgm_noah.mp3',     // placeholder
    theme: StoryTheme.trust,
  ),
];

/// The reward definition for each story.
/// Keyed by [StoryId] for fast lookup.
const Map<StoryId, ({String badgeId, String badgeName, String badgeIconPath})>
    storyRewards = {
  StoryId.noah: (
    badgeId: 'badge_noah',
    badgeName: 'Ark Builder',
    badgeIconPath: 'assets/images/stories/noah/ui/badge_noah.png',
  ),
  StoryId.david: (
    badgeId: 'badge_david',
    badgeName: 'Brave Heart',
    badgeIconPath: 'assets/images/ui/btn_play.png', // placeholder
  ),
  StoryId.jonah: (
    badgeId: 'badge_jonah',
    badgeName: 'Second Chance',
    badgeIconPath: 'assets/images/ui/btn_play.png', // placeholder
  ),
  StoryId.adam: (
    badgeId: 'badge_adam',
    badgeName: 'Garden Keeper',
    badgeIconPath: 'assets/images/ui/btn_play.png', // placeholder
  ),
};
