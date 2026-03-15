import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'components/branch_component.dart';
import 'models/zacchaeus_content.dart';

/// Lays out the Zacchaeus game world: background and 3 branch components.
///
/// Passes [onBranchTap] to each [BranchComponent] so [ZacchaeusGame] can
/// drive the ordering state machine.
class ZacchaeusWorld extends PositionComponent {
  /// Called when any [BranchComponent] is tapped.
  final void Function(BranchComponent) onBranchTap;

  /// Creates the world with the given [onBranchTap] handler.
  ZacchaeusWorld({required this.onBranchTap}) : super(anchor: Anchor.topLeft);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final screenSize = findGame()!.size;

    // Green/brown street background
    add(
      RectangleComponent(
        size: screenSize,
        paint: Paint()..color = const Color(0xFF6B8E3E),
      ),
    );

    // Brown tree trunk area
    final trunkW = screenSize.x * 0.6;
    add(
      RectangleComponent(
        position: Vector2((screenSize.x - trunkW) / 2, 0),
        size: Vector2(trunkW, screenSize.y),
        paint: Paint()..color = const Color(0x338D6E52),
      ),
    );

    await _addBranches(screenSize);
  }

  /// Places 3 [BranchComponent]s stacked vertically (branch_1 at top).
  Future<void> _addBranches(Vector2 screenSize) async {
    const branchW = 200.0;
    const branchH = 70.0;
    const vGap = 30.0;
    final totalH = 3 * branchH + 2 * vGap;
    final startY = (screenSize.y - totalH) / 2;
    final startX = (screenSize.x - branchW) / 2;

    final branchData = List.of(ZacchaeusContent.branches);

    for (int i = 0; i < branchData.length; i++) {
      await add(
        BranchComponent(
          data: branchData[i],
          onTap: onBranchTap,
          position: Vector2(startX, startY + i * (branchH + vGap)),
          size: Vector2(branchW, branchH),
        ),
      );
    }
  }
}
