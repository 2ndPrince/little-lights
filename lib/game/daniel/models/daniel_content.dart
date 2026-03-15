import '../../../constants/asset_paths.dart';
import 'lion.dart';

/// Static content definitions for the Daniel mini-game.
class DanielContent {
  DanielContent._();

  /// The three lions the player must tap to feed.
  static const List<Lion> lions = [
    Lion(id: 'lion_1', flamePath: AssetPaths.flameDanielLion1),
    Lion(id: 'lion_2', flamePath: AssetPaths.flameDanielLion2),
    Lion(id: 'lion_3', flamePath: AssetPaths.flameDanielLion3),
  ];
}
