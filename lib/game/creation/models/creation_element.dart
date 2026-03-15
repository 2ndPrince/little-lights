import 'package:equatable/equatable.dart';

/// Represents one creation element in the Creation mini-game.
class CreationElement extends Equatable {
  /// Unique identifier for this element.
  final String id;

  /// Flame-relative asset path for the element sprite.
  final String flamePath;

  /// The correct tap order (1–6).
  final int order;

  /// Whether this element has been activated by the player.
  final bool isActivated;

  const CreationElement({
    required this.id,
    required this.flamePath,
    required this.order,
    this.isActivated = false,
  });

  /// Returns a copy of this element marked as activated.
  CreationElement markActivated() => CreationElement(
        id: id,
        flamePath: flamePath,
        order: order,
        isActivated: true,
      );

  @override
  List<Object?> get props => [id, flamePath, order, isActivated];
}
