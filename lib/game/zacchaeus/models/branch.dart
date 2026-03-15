import 'package:equatable/equatable.dart';

/// Represents one tree branch in the Zacchaeus mini-game.
class Branch extends Equatable {
  /// Unique identifier for this branch.
  final String id;

  /// Flame-relative image path for this branch.
  final String flamePath;

  /// Expected tap order (1 = first/top, 3 = last/bottom).
  final int order;

  /// Whether this branch has been tapped in the correct sequence.
  final bool isTapped;

  const Branch({
    required this.id,
    required this.flamePath,
    required this.order,
    this.isTapped = false,
  });

  /// Returns a copy of this branch marked as tapped.
  Branch markTapped() => Branch(id: id, flamePath: flamePath, order: order, isTapped: true);

  @override
  List<Object?> get props => [id, flamePath, order, isTapped];
}
