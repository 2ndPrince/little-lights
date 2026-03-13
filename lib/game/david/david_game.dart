import 'dart:async';

import 'package:flame/game.dart';

import '../core/base/game_result.dart';
import '../core/systems/audio_manager.dart';
import '../core/systems/audio_service.dart';
import '../../constants/asset_paths.dart';
import 'components/stone_component.dart';
import 'logic/stone_logic.dart';
import 'models/david_content.dart';
import 'david_world.dart';

/// Internal state machine for [DavidGame].
enum DavidGameState {
  /// Game is instantiated but [onLoad] has not completed.
  idle,

  /// Stones are on screen; player is collecting them.
  playing,

  /// All 3 stones collected — throw sequence in progress.
  throwing,

  /// Game is finished.
  completed,
}

// ignore: constant_identifier_names
const String _davidIntroOverlayKey = 'davidIntro';

/// Flame [FlameGame] for the David and Goliath stone-collecting mini-game.
///
/// Child taps 3 stones. Once all 3 are collected, Goliath falls and
/// [onComplete] is called with [GameResult.success].
///
/// No Riverpod. No Navigator. Data enters via constructor; result exits via callback.
class DavidGame extends FlameGame {
  /// Overlay key for the pre-game intro screen.
  static const String introOverlayKey = _davidIntroOverlayKey;

  /// Called exactly once when the player successfully completes the game.
  final void Function(GameResult)? onComplete;

  /// In-game audio manager — constructed internally, never sourced from providers.
  late final AudioManager audioManager;

  late final DavidWorld _world;

  DavidGameState _state = DavidGameState.idle;

  late final StoneLogic _stoneLogic;

  /// Guards [onComplete] so it is called at most once.
  bool _completed = false;

  /// Creates a [DavidGame]. Provide [onComplete] to receive the game result.
  DavidGame({this.onComplete}) : super() {
    audioManager = AudioManager(AudioService());
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    _stoneLogic = StoneLogic(List.of(DavidContent.stones));

    _world = DavidWorld(onStoneTap: _handleStoneTap);
    await add(_world);

    unawaited(audioManager.playBgm(AssetPaths.flameBgmDavid));
    overlays.add(introOverlayKey);
    _state = DavidGameState.playing;
  }

  @override
  void onRemove() {
    audioManager.stopBgm();
    super.onRemove();
  }

  /// Handles a tap on a [StoneComponent].
  void _handleStoneTap(StoneComponent stone) {
    if (_state != DavidGameState.playing) return;

    final collected = _stoneLogic.collectStone(stone.data.id);
    if (collected == null) return;

    stone.triggerCollectFeedback();
    unawaited(audioManager.playSfx(AssetPaths.flameSfxTap));

    if (_stoneLogic.allCollected) {
      unawaited(_onAllStonesCollected());
    }
  }

  Future<void> _onAllStonesCollected() async {
    if (_completed) return;
    _completed = true;
    _state = DavidGameState.throwing;

    await audioManager.playSfx(AssetPaths.flameSfxMatch);
    await Future<void>.delayed(const Duration(milliseconds: 600));

    _world.goliath.fallDown();

    await audioManager.playSfx(AssetPaths.flameSfxSuccess);
    await audioManager.stopBgm(fade: const Duration(milliseconds: 500));
    await Future<void>.delayed(const Duration(milliseconds: 1500));

    _state = DavidGameState.completed;
    onComplete?.call(GameResult.success);
  }
}
