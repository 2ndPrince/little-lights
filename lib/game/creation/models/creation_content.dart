import '../../../constants/asset_paths.dart';
import 'creation_element.dart';

/// Static content definition for the Creation mini-game.
///
/// Contains the 6 creation elements in correct tap order (days 1–6).
class CreationContent {
  CreationContent._();

  /// All 6 creation elements ordered by creation day.
  static const List<CreationElement> elements = [
    CreationElement(id: 'light',   flamePath: AssetPaths.flameCreationLight,   order: 1),
    CreationElement(id: 'sky',     flamePath: AssetPaths.flameCreationSky,     order: 2),
    CreationElement(id: 'land',    flamePath: AssetPaths.flameCreationLand,    order: 3),
    CreationElement(id: 'stars',   flamePath: AssetPaths.flameCreationStars,   order: 4),
    CreationElement(id: 'birds',   flamePath: AssetPaths.flameCreationBirds,   order: 5),
    CreationElement(id: 'animals', flamePath: AssetPaths.flameCreationAnimals, order: 6),
  ];
}
