import '../models/story.dart';

/// Static registry of all stories in the app.
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
    thumbnailPath: 'assets/images/ui/btn_play.png',
    bgmPath: 'assets/audio/music/bgm_noah.mp3',
    theme: StoryTheme.courage,
  ),
  Story(
    id: StoryId.jonah,
    titleFallback: 'Jonah',
    thumbnailPath: 'assets/images/ui/btn_play.png',
    bgmPath: 'assets/audio/music/bgm_noah.mp3',
    theme: StoryTheme.obedience,
  ),
  Story(
    id: StoryId.adam,
    titleFallback: 'Adam and Eve',
    thumbnailPath: 'assets/images/ui/btn_play.png',
    bgmPath: 'assets/audio/music/bgm_noah.mp3',
    theme: StoryTheme.trust,
  ),
  Story(
    id: StoryId.moses,
    titleFallback: 'Moses and the Red Sea',
    thumbnailPath: 'assets/images/stories/moses/ui/water_wall_left.png',
    bgmPath: 'assets/audio/music/bgm_noah.mp3',
    theme: StoryTheme.trust,
  ),
  Story(
    id: StoryId.daniel,
    titleFallback: 'Daniel and the Lions',
    thumbnailPath: 'assets/images/stories/daniel/characters/lion_1.png',
    bgmPath: 'assets/audio/music/bgm_david.mp3',
    theme: StoryTheme.courage,
  ),
  Story(
    id: StoryId.samaritan,
    titleFallback: 'The Good Samaritan',
    thumbnailPath: 'assets/images/stories/samaritan/ui/item_bandage.png',
    bgmPath: 'assets/audio/music/bgm_home.mp3',
    theme: StoryTheme.kindness,
  ),
  Story(
    id: StoryId.zacchaeus,
    titleFallback: 'Zacchaeus',
    thumbnailPath: 'assets/images/stories/zacchaeus/characters/zacchaeus.png',
    bgmPath: 'assets/audio/music/bgm_home.mp3',
    theme: StoryTheme.forgiveness,
  ),
  Story(
    id: StoryId.feeding,
    titleFallback: 'Feeding the 5,000',
    thumbnailPath: 'assets/images/stories/feeding/ui/loaf_1.png',
    bgmPath: 'assets/audio/music/bgm_noah.mp3',
    theme: StoryTheme.generosity,
  ),
  Story(
    id: StoryId.creation,
    titleFallback: 'Creation',
    thumbnailPath: 'assets/images/stories/creation/ui/element_light.png',
    bgmPath: 'assets/audio/music/bgm_home.mp3',
    theme: StoryTheme.wonder,
  ),
];

/// The reward definition for each story.
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
    badgeIconPath: 'assets/images/ui/btn_play.png',
  ),
  StoryId.jonah: (
    badgeId: 'badge_jonah',
    badgeName: 'Second Chance',
    badgeIconPath: 'assets/images/ui/btn_play.png',
  ),
  StoryId.adam: (
    badgeId: 'badge_adam',
    badgeName: 'Garden Keeper',
    badgeIconPath: 'assets/images/ui/btn_play.png',
  ),
  StoryId.moses: (
    badgeId: 'badge_moses',
    badgeName: 'Sea Crosser',
    badgeIconPath: 'assets/images/stories/moses/ui/badge_moses.png',
  ),
  StoryId.daniel: (
    badgeId: 'badge_daniel',
    badgeName: 'Lion Tamer',
    badgeIconPath: 'assets/images/stories/daniel/ui/badge_daniel.png',
  ),
  StoryId.samaritan: (
    badgeId: 'badge_samaritan',
    badgeName: 'Good Helper',
    badgeIconPath: 'assets/images/stories/samaritan/ui/badge_samaritan.png',
  ),
  StoryId.zacchaeus: (
    badgeId: 'badge_zacchaeus',
    badgeName: 'Changed Heart',
    badgeIconPath: 'assets/images/stories/zacchaeus/ui/badge_zacchaeus.png',
  ),
  StoryId.feeding: (
    badgeId: 'badge_feeding',
    badgeName: 'Generous Giver',
    badgeIconPath: 'assets/images/stories/feeding/ui/badge_feeding.png',
  ),
  StoryId.creation: (
    badgeId: 'badge_creation',
    badgeName: 'Wonder Keeper',
    badgeIconPath: 'assets/images/stories/creation/ui/badge_creation.png',
  ),
};
