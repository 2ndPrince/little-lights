import 'dart:async';

import 'package:flame/game.dart';

import '../core/base/game_result.dart';
import 'puzzle_content.dart';
import 'puzzle_logic.dart';
import 'puzzle_world.dart';

/// Universal Flame game that powers the jigsaw puzzle for every story.
///
/// Receives story data via [content] and signals completion via [onComplete].
/// No Riverpod. No Navigator. Data in via constructor; result out via callback.
class PuzzleGame extends FlameGame {
  /// Overlay key for the pre-game intro screen.
  static const String introOverlayKey = 'puzzleIntro';

  /// Story-specific puzzle configuration.
  final PuzzleContent content;

  /// Called exactly once when the player places all pieces.
  final void Function(GameResult) onComplete;

  late final PuzzleLogic _logic;
  late final PuzzleWorld _world;

  bool _completed = false;

  PuzzleGame({required this.content, required this.onComplete});

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    _logic = PuzzleLogic(columns: content.columns, rows: content.rows);

    final puzzleImage = await images.load(content.puzzleImageFlamePath);
    _world = PuzzleWorld(
      puzzleImage: puzzleImage,
      content: content,
      onPiecePlaced: _handlePiecePlaced,
    );
    await add(_world);

    overlays.add(introOverlayKey);
  }

  /// Called by [PuzzleWorld] each time a piece snaps into position.
  void _handlePiecePlaced(int id) {
    _logic.placePiece(id);
    if (_logic.allPlaced) {
      unawaited(_onPuzzleComplete());
    }
  }

  Future<void> _onPuzzleComplete() async {
    if (_completed) return;
    _completed = true;
    await Future<void>.delayed(const Duration(milliseconds: 1500));
    onComplete(GameResult.success);
  }
}
