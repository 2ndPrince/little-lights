import 'storm_cloud.dart';

/// Static content registry for the Jonah mini-game.
class JonahContent {
  JonahContent._();

  /// The 3 storm clouds the player must calm to complete the game.
  static const List<StormCloud> clouds = [
    StormCloud(id: 'cloud_1', flamePath: 'stories/jonah/ui/cloud_1.png'),
    StormCloud(id: 'cloud_2', flamePath: 'stories/jonah/ui/cloud_2.png'),
    StormCloud(id: 'cloud_3', flamePath: 'stories/jonah/ui/cloud_3.png'),
  ];
}
