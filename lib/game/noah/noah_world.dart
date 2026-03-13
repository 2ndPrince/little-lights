import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'components/animal_card.dart';
import 'components/ark_drop_zone.dart';
import 'models/animal_pair.dart';
import 'models/noah_content.dart';

/// Lays out the Noah game world: 6 [AnimalCard]s in two rows and an [ArkDropZone].
///
/// Passes [onCardTap] to each card so [NoahGame] can drive the state machine.
class NoahWorld extends PositionComponent {
  /// Called when any [AnimalCard] is tapped.
  final void Function(AnimalCard card) onCardTap;

  /// Called when a matched pair is loaded into the ark.
  final void Function(String pairId)? onPairLoaded;

  /// The ark drop zone component, exposed for [NoahGame] to call [acceptPair].
  late final ArkDropZone arkDropZone;

  /// Creates the world with the given [onCardTap] handler.
  NoahWorld({
    required this.onCardTap,
    this.onPairLoaded,
  }) : super(anchor: Anchor.topLeft);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final screenSize = findGame()!.size;

    // Sky background
    add(
      RectangleComponent(
        size: screenSize,
        paint: Paint()..color = const Color(0xFFB3E5FC),
      ),
    );

    // Ark drop zone — upper-center
    const arkW = 280.0;
    const arkH = 180.0;
    arkDropZone = ArkDropZone(
      onPairLoaded: onPairLoaded ?? (_) {},
      position: Vector2((screenSize.x - arkW) / 2, screenSize.y * 0.08),
      size: Vector2(arkW, arkH),
    );
    await add(arkDropZone);

    // Animal cards — 2 rows of 3 at the bottom
    await _addAnimalCards(screenSize);
  }

  /// Places 6 [AnimalCard]s in a 3×2 grid near the bottom of the screen.
  Future<void> _addAnimalCards(Vector2 screenSize) async {
    // NoahContent already has all 6 cards (2 per pair)
    final cardData = List<AnimalPair>.from(NoahContent.animalPairs);

    const cardW = 100.0;
    const cardH = 100.0;
    const cols = 3;
    const hGap = 20.0;
    const vGap = 16.0;
    const rows = 2;

    final totalW = cols * cardW + (cols - 1) * hGap;
    final startX = (screenSize.x - totalW) / 2;
    final startY = screenSize.y - (rows * cardH + (rows - 1) * vGap) - 32;

    // Shuffle so card order is random each session
    cardData.shuffle();

    for (int i = 0; i < cardData.length; i++) {
      final col = i % cols;
      final row = i ~/ cols;
      final pos = Vector2(
        startX + col * (cardW + hGap),
        startY + row * (cardH + vGap),
      );
      final card = AnimalCard(
        data: cardData[i],
        onTap: onCardTap,
        position: pos,
        size: Vector2(cardW, cardH),
      );
      await add(card);
    }
  }
}
