import 'dart:async';

import 'package:flame/game.dart';

import '../core/base/game_result.dart';
import '../core/systems/audio_manager.dart';
import '../core/systems/audio_service.dart';
import '../../constants/asset_paths.dart';
import 'components/storm_cloud_component.dart';
import 'logic/jonah_logic.dart';
import 'models/jonah_content.dart';
import 'jonah_world.dart';

/// Internal state machine for [JonahGame].
enum JonahGameState {
  /// Game is instantiated but [onLoad] has not completed.
  idle,

  /// Clouds are on screen; player is calming them.
  playing,

  /// Game is finished.
  completed,
}

// ignore: constant_identifier_names
const String _jonahIntroOverlayKey = 'jonahIntro';

/// Flame [FlameGame] for the Jonah storm-calming mini-game.
///
/// Child taps 3 storm clouds. Once all 3 are calmed, the boat sails away and
/// [onComplete] is called with [GameResult.success].
///
/// No Riverpod. No Navigator. Data enters via constructor; result exits via callback.
class JonahGame extends FlameGame {
  /// Overlay key for the pre-game intro screen.
  static const String introOverlayKey = _jonahIntroOverlayKey;

  /// Called exactly once when the player successfully completes the game.
  final void Function(GameResult)? onComplete;

  /// In-game audio manager — constructed internally, never sourced from providers.
  late final AudioManager audioManager;

  late final JonahWorld _world;

  JonahGameState _state = JonahGameState.idle;

  late final JonahLogic _jonahLogic;

  /// Guards [onComplete] so it is called at most once.
  bool _completed = false;

  /// Creates a [JonahGame]. Provide [onComplete] to receive the game result.
  JonahGame({this.onComplete}) : super() {
    audioManager = AudioManager(AudioService());
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    _jonahLogic = JonahLogic(List.of(JonahContent.clouds));

    _world = JonahWorld(onCloudTap: _handleCloudTap);
    await add(_world);

    unawaited(audioManager.playBgm(AssetPaths.flameBgmJonah));
    overlays.add(introOverlayKey);
    _state = JonahGameState.playing;
  }

  @override
  void onRemove() {
    audioManager.stopBgm();
    super.onRemove();
  }

  /// Handles a tap on a [StormCloudComponent].
  void _handleCloudTap(StormCloudComponent cloud) {
    if (_state != JonahGameState.playing) return;

    final calmed = _jonahLogic.calmCloud(cloud.data.id);
    if (calmed == null) return;

    cloud.triggerCalmFeedback();
    unawaited(audioManager.playSfx(AssetPaths.flameSfxTap));

    if (_jonahLogic.allCalmed) {
      unawaited(_onAllCloudsCalmed());
    }
  }

  Future<void> _onAllCloudsCalmed() async {
    if (_completed) return;
    _completed = true;
    _state = JonahGameState.completed;

    _world.boat.sailAway();

    await audioManager.playSfx(AssetPaths.flameSfxSuccess);
    await audioManager.stopBgm(fade: const Duration(milliseconds: 500));
    await Future<void>.delayed(const Duration(milliseconds: 1500));

    onComplete?.call(GameResult.success);
  }
}
