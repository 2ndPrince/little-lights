import '../models/storm_cloud.dart';

/// Pure game logic for the Jonah storm-calming mini-game.
///
/// No Flame imports. No Flutter imports. Fully unit-testable.
class JonahLogic {
  /// Mutable working copy of the clouds for this game session.
  final List<StormCloud> clouds;

  /// Creates a [JonahLogic] with the provided [clouds].
  JonahLogic(List<StormCloud> initial) : clouds = List.of(initial);

  /// Number of clouds calmed so far.
  int get calmedCount => clouds.where((c) => c.isCalmed).length;

  /// True when every cloud has been calmed.
  bool get allCalmed =>
      clouds.isNotEmpty && clouds.every((c) => c.isCalmed);

  /// Marks the cloud with [cloudId] as calmed.
  ///
  /// Returns the updated [StormCloud] if found and not yet calmed.
  /// Returns null if the id is unknown or the cloud is already calmed.
  StormCloud? calmCloud(String cloudId) {
    final index = clouds.indexWhere((c) => c.id == cloudId);
    if (index == -1) return null;
    if (clouds[index].isCalmed) return null;
    final updated = clouds[index].markCalmed();
    clouds[index] = updated;
    return updated;
  }
}
