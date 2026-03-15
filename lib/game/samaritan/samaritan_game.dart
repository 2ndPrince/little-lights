import 'dart:async';

import 'package:flame/game.dart';

import '../core/base/game_result.dart';
import '../core/systems/audio_manager.dart';
import '../core/systems/audio_service.dart';
import '../../constants/asset_paths.dart';
import 'components/healing_item_component.dart';
import 'logic/samaritan_logic.dart';
import 'models/samaritan_content.dart';
import 'samaritan_world.dart';

/// Internal state machine for [SamaritanGame].
enum SamaritanGameState {
  /// Game is instantiated but [onLoad] has not completed.
  idle,

  /// Items are on screen; player is applying them.
  playing,

  /// Game is finished.
  completed,
}

// ignore: constant_identifier_names
const String _samaritanIntroOverlayKey = 'samaritanIntro';

/// Flame [FlameGame] for the Good Samaritan healing mini-game.
///
/// Child taps 3 healing items to apply them. Once all 3 are applied,
/// [onComplete] is called with [GameResult.success].
///
/// No Riverpod. No Navigator. Data enters via constructor; result exits via callback.
class SamaritanGame extends FlameGame {
  /// Overlay key for the pre-game intro screen.
  static const String introOverlayKey = _samaritanIntroOverlayKey;

  /// Called exactly once when the player successfully completes the game.
  final void Function(GameResult)? onComplete;

  /// In-game audio manager — constructed internally, never sourced from providers.
  late final AudioManager audioManager;

  late final SamaritanWorld _world;
  late final SamaritanLogic _samaritanLogic;

  SamaritanGameState _state = SamaritanGameState.idle;

  /// Guards [onComplete] so it is called at most once.
  bool _completed = false;

  /// Creates a [SamaritanGame]. Provide [onComplete] to receive the game result.
  SamaritanGame({this.onComplete}) : super() {
    audioManager = AudioManager(AudioService());
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    _samaritanLogic = SamaritanLogic(List.of(SamaritanContent.items));

    _world = SamaritanWorld(onItemTap: _handleItemTap);
    await add(_world);

    unawaited(audioManager.playBgm(AssetPaths.flameBgmSamaritan));
    overlays.add(introOverlayKey);
    _state = SamaritanGameState.playing;
  }

  @override
  void onRemove() {
    audioManager.stopBgm();
    super.onRemove();
  }

  /// Handles a tap on a [HealingItemComponent].
  void _handleItemTap(HealingItemComponent component) {
    if (_state != SamaritanGameState.playing) return;

    final applied = _samaritanLogic.applyItem(component.data.id);
    if (applied == null) return;

    component.triggerAppliedFeedback();
    unawaited(audioManager.playSfx(AssetPaths.flameSfxTap));

    if (_samaritanLogic.allApplied) {
      unawaited(_onAllItemsApplied());
    }
  }

  Future<void> _onAllItemsApplied() async {
    if (_completed) return;
    _completed = true;
    _state = SamaritanGameState.completed;

    _world.showHealed();

    await audioManager.playSfx(AssetPaths.flameSfxSuccess);
    await audioManager.stopBgm(fade: const Duration(milliseconds: 500));
    await Future<void>.delayed(const Duration(milliseconds: 1500));

    onComplete?.call(GameResult.success);
  }
}
