import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'components/jonah_boat_component.dart';
import 'components/storm_cloud_component.dart';
import 'models/jonah_content.dart';

/// Lays out the Jonah game world: 3 [StormCloudComponent]s and a [JonahBoatComponent].
///
/// Passes [onCloudTap] to each cloud so [JonahGame] can drive the state machine.
class JonahWorld extends PositionComponent {
  /// Called when any [StormCloudComponent] is tapped.
  final void Function(StormCloudComponent cloud) onCloudTap;

  /// The boat component, exposed for [JonahGame] to call [sailAway].
  late final JonahBoatComponent boat;

  /// Creates the world with the given [onCloudTap] handler.
  JonahWorld({required this.onCloudTap}) : super(anchor: Anchor.topLeft);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final screenSize = findGame()!.size;

    // Ocean background
    add(
      RectangleComponent(
        size: screenSize,
        paint: Paint()..color = const Color(0xFF4FC3F7),
      ),
    );

    // Water surface strip at the bottom
    final waterH = screenSize.y * 0.25;
    add(
      RectangleComponent(
        position: Vector2(0, screenSize.y - waterH),
        size: Vector2(screenSize.x, waterH),
        paint: Paint()..color = const Color(0xFF0288D1),
      ),
    );

    // Jonah's boat — left-center area
    boat = JonahBoatComponent(
      position: Vector2(screenSize.x * 0.25, screenSize.y - waterH),
      size: Vector2(100, 80),
    );
    await add(boat);

    // 3 clouds spread across the top 40% of the screen
    await _addClouds(screenSize);
  }

  /// Places 3 [StormCloudComponent]s across the upper portion of the screen.
  Future<void> _addClouds(Vector2 screenSize) async {
    const cloudW = 100.0;
    const cloudH = 80.0;
    const count = 3;
    const hGap = 20.0;
    final totalW = count * cloudW + (count - 1) * hGap;
    final startX = (screenSize.x - totalW) / 2;
    final cloudY = screenSize.y * 0.1;

    final cloudData = List.of(JonahContent.clouds);

    for (int i = 0; i < cloudData.length; i++) {
      final pos = Vector2(startX + i * (cloudW + hGap), cloudY);
      await add(
        StormCloudComponent(
          data: cloudData[i],
          onTap: onCloudTap,
          position: pos,
          size: Vector2(cloudW, cloudH),
        ),
      );
    }
  }
}
