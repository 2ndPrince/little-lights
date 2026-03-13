import 'stone.dart';

/// Static content registry for the David and Goliath mini-game.
class DavidContent {
  DavidContent._();

  /// The 3 stones the player must collect to defeat Goliath.
  static const List<Stone> stones = [
    Stone(
      id: 'pebble_1',
      flamePath: 'stories/david/ui/stone_1.png',
      displayName: 'Stone',
    ),
    Stone(
      id: 'pebble_2',
      flamePath: 'stories/david/ui/stone_2.png',
      displayName: 'Stone',
    ),
    Stone(
      id: 'pebble_3',
      flamePath: 'stories/david/ui/stone_3.png',
      displayName: 'Stone',
    ),
  ];
}
