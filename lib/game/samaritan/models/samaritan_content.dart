import '../../../constants/asset_paths.dart';
import 'healing_item.dart';

/// Static content registry for the Samaritan mini-game.
class SamaritanContent {
  SamaritanContent._();

  /// The three healing items the child applies to help the wounded man.
  static const List<HealingItem> items = [
    HealingItem(id: 'bandage', flamePath: AssetPaths.flameSamaritanBandage),
    HealingItem(id: 'water',   flamePath: AssetPaths.flameSamaritanWater),
    HealingItem(id: 'bread',   flamePath: AssetPaths.flameSamaritanBread),
  ];
}
