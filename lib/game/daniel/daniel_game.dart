import 'dart:async';

import 'package:flame/game.dart';

import '../core/base/game_result.dart';
import '../core/systems/audio_manager.dart';
import '../core/systems/audio_service.dart';
import '../../constants/asset_paths.dart';
import 'components/lion_component.dart';
import 'daniel_world.dart';
import 'logic/daniel_logic.dart';
import 'models/daniel_content.dart';

/// Internal state machine for [DanielGame].
enum DanielGameState {
  /// Game is instantiated but [onLoad] has not completed.
  idle,

  /// Lions are on screen; player is feeding them.
  playing,

  /// Game is finished.
  completed,
}

// ignore: constant_identifier_names
const String _danielIntroOverlayKey = 'danielIntro';

/// Flame [FlameGame] for the Daniel and the Lions mini-game.
///
/// Child taps 3 lions to feed them. Once all are fed,
/// [onComplete] is called with [GameResult.success].
///
/// No Riverpod. No Navigator. Data enters via constructor; result exits via callback.
class DanielGame extends FlameGame {
  /// Overlay key for the pre-game intro screen.
  static const String introOverlayKey = _danielIntroOverlayKey;

  /// Called exactly once when the player successfully completes the game.
  final void Function(GameResult)? onComplete;

  /// In-game audio manager — constructed internally, never sourced from providers.
  late final AudioManager audioManager;

  late final DanielWorld _world;

  DanielGameState _state = DanielGameState.idle;

  late final DanielLogic _danielLogic;

  /// Guards [onComplete] so it is called at most once.
  bool _completed = false;

  /// Creates a [DanielGame]. Provide [onComplete] to receive the game result.
  DanielGame({this.onComplete}) : super() {
    audioManager = AudioManager(AudioService());
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    _danielLogic = DanielLogic(List.of(DanielContent.lions));

    _world = DanielWorld(onLionTap: _handleLionTap);
    await add(_world);

    unawaited(audioManager.playBgm(AssetPaths.flameBgmDaniel));
    overlays.add(introOverlayKey);
    _state = DanielGameState.playing;
  }

  @override
  void onRemove() {
    audioManager.stopBgm();
    super.onRemove();
  }

  /// Handles a tap on a [LionComponent].
  void _handleLionTap(LionComponent lion) {
    if (_state != DanielGameState.playing) return;

    final fed = _danielLogic.feedLion(lion.data.id);
    if (fed == null) return;

    lion.triggerFedFeedback();
    unawaited(audioManager.playSfx(AssetPaths.flameSfxTap));

    if (_danielLogic.allFed) {
      unawaited(_onAllLionsFed());
    }
  }

  Future<void> _onAllLionsFed() async {
    if (_completed) return;
    _completed = true;
    _state = DanielGameState.completed;

    await audioManager.playSfx(AssetPaths.flameSfxSuccess);
    await audioManager.stopBgm(fade: const Duration(milliseconds: 500));
    await Future<void>.delayed(const Duration(milliseconds: 1500));

    onComplete?.call(GameResult.success);
  }
}
