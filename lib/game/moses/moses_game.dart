import 'dart:async';

import 'package:flame/game.dart';

import '../core/base/game_result.dart';
import '../core/systems/audio_manager.dart';
import '../core/systems/audio_service.dart';
import '../../constants/asset_paths.dart';
import 'components/water_wall_component.dart';
import 'logic/moses_logic.dart';
import 'models/moses_content.dart';
import 'moses_world.dart';

/// Internal state machine for [MosesGame].
enum MosesGameState {
  /// Game is instantiated but [onLoad] has not completed.
  idle,

  /// Walls are on screen; player is parting the sea.
  playing,

  /// Game is finished.
  completed,
}

// ignore: constant_identifier_names
const String _mosesIntroOverlayKey = 'mosesIntro';

/// Flame [FlameGame] for the Moses Red Sea mini-game.
///
/// Child taps 2 water walls to part the sea. Once both are moved,
/// [onComplete] is called with [GameResult.success].
///
/// No Riverpod. No Navigator. Data enters via constructor; result exits via callback.
class MosesGame extends FlameGame {
  /// Overlay key for the pre-game intro screen.
  static const String introOverlayKey = _mosesIntroOverlayKey;

  /// Called exactly once when the player successfully completes the game.
  final void Function(GameResult)? onComplete;

  /// In-game audio manager — constructed internally, never sourced from providers.
  late final AudioManager audioManager;

  late final MosesWorld _world;

  MosesGameState _state = MosesGameState.idle;

  late final MosesLogic _mosesLogic;

  /// Guards [onComplete] so it is called at most once.
  bool _completed = false;

  /// Creates a [MosesGame]. Provide [onComplete] to receive the game result.
  MosesGame({this.onComplete}) : super() {
    audioManager = AudioManager(AudioService());
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    _mosesLogic = MosesLogic(List.of(MosesContent.walls));

    _world = MosesWorld(onWallTap: _handleWallTap);
    await add(_world);

    unawaited(audioManager.playBgm(AssetPaths.flameBgmMoses));
    overlays.add(introOverlayKey);
    _state = MosesGameState.playing;
  }

  @override
  void onRemove() {
    audioManager.stopBgm();
    super.onRemove();
  }

  /// Handles a tap on a [WaterWallComponent].
  void _handleWallTap(WaterWallComponent wall) {
    if (_state != MosesGameState.playing) return;

    final moved = _mosesLogic.moveWall(wall.data.id);
    if (moved == null) return;

    wall.triggerMoveFeedback();
    unawaited(audioManager.playSfx(AssetPaths.flameSfxTap));

    if (_mosesLogic.allMoved) {
      unawaited(_onAllWallsMoved());
    }
  }

  Future<void> _onAllWallsMoved() async {
    if (_completed) return;
    _completed = true;
    _state = MosesGameState.completed;

    _world.showIsraelitesCross();
    await audioManager.playSfx(AssetPaths.flameSfxSuccess);
    await audioManager.stopBgm(fade: const Duration(milliseconds: 500));
    await Future<void>.delayed(const Duration(milliseconds: 1500));

    onComplete?.call(GameResult.success);
  }
}
