import '../../../constants/asset_paths.dart';
import 'water_wall.dart';

/// Static content definitions for the Moses mini-game.
class MosesContent {
  MosesContent._();

  /// The two water walls the player must tap to part the sea.
  static const List<WaterWall> walls = [
    WaterWall(
      id: 'wall_left',
      flamePath: AssetPaths.flameMosesWallLeft,
      side: WaterWallSide.left,
    ),
    WaterWall(
      id: 'wall_right',
      flamePath: AssetPaths.flameMosesWallRight,
      side: WaterWallSide.right,
    ),
  ];
}
