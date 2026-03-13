import 'package:equatable/equatable.dart';

/// Represents one animal card in the Noah matching game.
class AnimalPair extends Equatable {
  /// Unique ID for this specific card (e.g., 'lion_1', 'lion_2').
  final String id;

  /// Shared ID that links the two matching cards (e.g., 'lion').
  final String pairId;

  /// Asset path for Flame image loading (relative to assets/images/).
  /// Example: 'stories/noah/animals/lion_1.png'
  final String flamePath;

  /// Human-readable name used for accessibility / future narration.
  final String displayName;

  /// Whether this card has been successfully loaded into the ark.
  final bool isLoaded;

  const AnimalPair({
    required this.id,
    required this.pairId,
    required this.flamePath,
    required this.displayName,
    this.isLoaded = false,
  });

  /// Returns a copy with [isLoaded] set to true.
  AnimalPair markLoaded() => AnimalPair(
        id: id,
        pairId: pairId,
        flamePath: flamePath,
        displayName: displayName,
        isLoaded: true,
      );

  @override
  List<Object?> get props => [id, pairId, flamePath, displayName, isLoaded];
}
