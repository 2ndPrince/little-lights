import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'game_result.dart';

/// Flutter widget that hosts any [FlameGame] and bridges completion back to Flutter.
///
/// Always wrap Flame games in this widget — never use [GameWidget] directly in a route.
/// The game receives data via its constructor. It signals completion via [onGameComplete].
class BaseGameScreen extends StatefulWidget {
  /// Factory that creates a fresh game instance on each mount.
  final FlameGame Function() gameFactory;

  /// Called exactly once when the game signals it is done.
  final void Function(GameResult result) onGameComplete;

  const BaseGameScreen({
    required this.gameFactory,
    required this.onGameComplete,
    super.key,
  });

  @override
  State<BaseGameScreen> createState() => _BaseGameScreenState();
}

class _BaseGameScreenState extends State<BaseGameScreen> {
  late final FlameGame _game;
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _game = widget.gameFactory();
    _game.onGameResize(Vector2.zero()); // pre-init so onLoad can be awaited
    _initGame();
  }

  Future<void> _initGame() async {
    await _game.onLoad();
    if (mounted) setState(() => _loaded = true);
  }

  @override
  void dispose() {
    _game.onRemove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _loaded
          ? GameWidget(game: _game)
          : const Center(
              child: CircularProgressIndicator(
                color: Color(0xFFF4A261), // AppColors.accentOrange
              ),
            ),
    );
  }
}
