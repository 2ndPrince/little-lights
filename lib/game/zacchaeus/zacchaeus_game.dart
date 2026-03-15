import 'dart:async';

import 'package:flame/game.dart';

import '../core/base/game_result.dart';
import '../core/systems/audio_manager.dart';
import '../core/systems/audio_service.dart';
import '../../constants/asset_paths.dart';
import 'components/branch_component.dart';
import 'logic/zacchaeus_logic.dart';
import 'models/zacchaeus_content.dart';
import 'zacchaeus_world.dart';

/// Internal state machine for [ZacchaeusGame].
enum ZacchaeusGameState {
  /// Game is instantiated but [onLoad] has not completed.
  idle,

  /// Branches are on screen; player is tapping them in order.
  playing,

  /// Game is finished.
  completed,
}

// ignore: constant_identifier_names
const String _zacchaeusIntroOverlayKey = 'zacchaeusIntro';

/// Flame [FlameGame] for the Zacchaeus branch-tapping mini-game.
///
/// Child taps 3 branches from top to bottom in order. Once all 3 are tapped
/// correctly, [onComplete] is called with [GameResult.success].
///
/// No Riverpod. No Navigator. Data enters via constructor; result exits via callback.
class ZacchaeusGame extends FlameGame {
  /// Overlay key for the pre-game intro screen.
  static const String introOverlayKey = _zacchaeusIntroOverlayKey;

  /// Called exactly once when the player successfully completes the game.
  final void Function(GameResult)? onComplete;

  /// In-game audio manager — constructed internally, never sourced from providers.
  late final AudioManager audioManager;

  late final ZacchaeusWorld _world;
  late final ZacchaeusLogic _logic;

  ZacchaeusGameState _state = ZacchaeusGameState.idle;

  /// Guards [onComplete] so it is called at most once.
  bool _completed = false;

  /// Creates a [ZacchaeusGame]. Provide [onComplete] to receive the game result.
  ZacchaeusGame({this.onComplete}) : super() {
    audioManager = AudioManager(AudioService());
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    _logic = ZacchaeusLogic(List.of(ZacchaeusContent.branches));

    _world = ZacchaeusWorld(onBranchTap: _handleBranchTap);
    await add(_world);

    unawaited(audioManager.playBgm(AssetPaths.flameBgmZacchaeus));
    overlays.add(introOverlayKey);
    _state = ZacchaeusGameState.playing;
  }

  @override
  void onRemove() {
    audioManager.stopBgm();
    super.onRemove();
  }

  /// Handles a tap on a [BranchComponent].
  void _handleBranchTap(BranchComponent component) {
    if (_state != ZacchaeusGameState.playing) return;

    final tapped = _logic.tapBranch(component.data.id);
    if (tapped != null) {
      component.triggerCorrectFeedback();
      unawaited(audioManager.playSfx(AssetPaths.flameSfxTap));
      if (_logic.allDescended) {
        unawaited(_onAllBranchesTapped());
      }
    } else {
      component.triggerWrongFeedback();
      unawaited(audioManager.playSfx(AssetPaths.flameSfxIncorrect));
    }
  }

  Future<void> _onAllBranchesTapped() async {
    if (_completed) return;
    _completed = true;
    _state = ZacchaeusGameState.completed;

    await audioManager.playSfx(AssetPaths.flameSfxSuccess);
    await audioManager.stopBgm(fade: const Duration(milliseconds: 500));
    await Future<void>.delayed(const Duration(milliseconds: 1500));

    onComplete?.call(GameResult.success);
  }
}
