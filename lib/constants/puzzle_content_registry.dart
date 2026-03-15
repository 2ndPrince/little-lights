import '../data/models/story.dart';
import '../game/puzzle/puzzle_content.dart';
import 'asset_paths.dart';

/// Registry of [PuzzleContent] for every story in the app.
///
/// Look up by [StoryId] to configure [PuzzleGame] for any story.
const Map<StoryId, PuzzleContent> puzzleContentRegistry = {
  StoryId.creation: PuzzleContent(
    storyId: StoryId.creation,
    puzzleImageFlamePath: AssetPaths.flameCreationScene01,
    lessonFlutterPaths: [
      AssetPaths.creationScene02,
      AssetPaths.creationScene03,
      AssetPaths.creationScene04,
    ],
    lessonCaptions: [
      'God spoke light into the darkness — and it was good!',
      'He made the sky, the land, and all living things.',
      'God rested and blessed the seventh day.',
    ],
  ),
  StoryId.adam: PuzzleContent(
    storyId: StoryId.adam,
    puzzleImageFlamePath: AssetPaths.flameAdamScene01,
    lessonFlutterPaths: [
      AssetPaths.adamScene02,
      AssetPaths.adamScene03,
      AssetPaths.adamScene04,
    ],
    lessonCaptions: [
      'God made Adam and Eve to care for His creation.',
      'Adam gave names to every animal.',
      'God walked with them in the beautiful garden.',
    ],
  ),
  StoryId.noah: PuzzleContent(
    storyId: StoryId.noah,
    puzzleImageFlamePath: AssetPaths.flameNoahScene01,
    lessonFlutterPaths: [
      AssetPaths.noahScene02,
      AssetPaths.noahScene03,
      AssetPaths.noahScene04,
    ],
    lessonCaptions: [
      'God asked Noah to build a big ark.',
      'Two by two, the animals came aboard.',
      'After the rain, God sent a rainbow of promise.',
    ],
  ),
  StoryId.moses: PuzzleContent(
    storyId: StoryId.moses,
    puzzleImageFlamePath: AssetPaths.flameMosesScene01,
    lessonFlutterPaths: [
      AssetPaths.mosesScene02,
      AssetPaths.mosesScene03,
      AssetPaths.mosesScene04,
    ],
    lessonCaptions: [
      'Moses trusted God and led His people.',
      'God parted the mighty Red Sea!',
      'The people walked safely to the other side.',
    ],
  ),
  StoryId.david: PuzzleContent(
    storyId: StoryId.david,
    puzzleImageFlamePath: AssetPaths.flameDavidScene01,
    lessonFlutterPaths: [
      AssetPaths.davidScene02,
      AssetPaths.davidScene03,
      AssetPaths.davidScene04,
    ],
    lessonCaptions: [
      'Little David trusted God against giant Goliath.',
      'One small stone in the hands of a brave heart.',
      "With God's help, even the smallest can be mighty.",
    ],
  ),
  StoryId.jonah: PuzzleContent(
    storyId: StoryId.jonah,
    puzzleImageFlamePath: AssetPaths.flameJonahScene01,
    lessonFlutterPaths: [
      AssetPaths.jonahScene02,
      AssetPaths.jonahScene03,
      AssetPaths.jonahScene04,
    ],
    lessonCaptions: [
      'Jonah ran away — but God never gave up on him.',
      'Inside the big fish, Jonah prayed for help.',
      'God gave Jonah a second chance to obey.',
    ],
  ),
  StoryId.daniel: PuzzleContent(
    storyId: StoryId.daniel,
    puzzleImageFlamePath: AssetPaths.flameDanielScene01,
    lessonFlutterPaths: [
      AssetPaths.danielScene02,
      AssetPaths.danielScene03,
      AssetPaths.danielScene04,
    ],
    lessonCaptions: [
      'Daniel prayed to God even when it was hard.',
      'God sent an angel to protect Daniel.',
      "Daniel's faith showed everyone God's power.",
    ],
  ),
  StoryId.samaritan: PuzzleContent(
    storyId: StoryId.samaritan,
    puzzleImageFlamePath: AssetPaths.flameSamaritanScene01,
    lessonFlutterPaths: [
      AssetPaths.samaritanScene02,
      AssetPaths.samaritanScene03,
      AssetPaths.samaritanScene04,
    ],
    lessonCaptions: [
      'A kind stranger stopped to help someone in need.',
      'He cared for the hurt man with love and kindness.',
      'Be a good neighbor — show love to everyone.',
    ],
  ),
  StoryId.feeding: PuzzleContent(
    storyId: StoryId.feeding,
    puzzleImageFlamePath: AssetPaths.flameFeedingScene01,
    lessonFlutterPaths: [
      AssetPaths.feedingScene02,
      AssetPaths.feedingScene03,
      AssetPaths.feedingScene04,
    ],
    lessonCaptions: [
      'A boy shared his 5 loaves and 2 fish with Jesus.',
      'Jesus blessed the little lunch — and it fed everyone!',
      'When we give what we have, God does amazing things.',
    ],
  ),
  StoryId.zacchaeus: PuzzleContent(
    storyId: StoryId.zacchaeus,
    puzzleImageFlamePath: AssetPaths.flameZacchaeusScene01,
    lessonFlutterPaths: [
      AssetPaths.zacchaeusScene02,
      AssetPaths.zacchaeusScene03,
      AssetPaths.zacchaeusScene04,
    ],
    lessonCaptions: [
      'Zacchaeus climbed a tree to see Jesus.',
      "Jesus called to him — \"Come down, I'm coming to your house!\"",
      "Meeting Jesus changed Zacchaeus's heart forever.",
    ],
  ),
};
