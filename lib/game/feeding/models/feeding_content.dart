import '../../../constants/asset_paths.dart';
import 'food_item.dart';

/// Static content definition for the Feeding the 5,000 mini-game.
///
/// Contains the 7 food items (5 loaves + 2 fish) the player must collect.
class FeedingContent {
  FeedingContent._();

  /// All 7 food items for this game session.
  static const List<FoodItem> items = [
    FoodItem(id: 'loaf_1', flamePath: AssetPaths.flameFeedingLoaf1),
    FoodItem(id: 'loaf_2', flamePath: AssetPaths.flameFeedingLoaf2),
    FoodItem(id: 'loaf_3', flamePath: AssetPaths.flameFeedingLoaf3),
    FoodItem(id: 'loaf_4', flamePath: AssetPaths.flameFeedingLoaf4),
    FoodItem(id: 'loaf_5', flamePath: AssetPaths.flameFeedingLoaf5),
    FoodItem(id: 'fish_1', flamePath: AssetPaths.flameFeedingFish1),
    FoodItem(id: 'fish_2', flamePath: AssetPaths.flameFeedingFish2),
  ];
}
