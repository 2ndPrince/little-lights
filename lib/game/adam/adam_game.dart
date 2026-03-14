import 'dart:async';

import 'package:flame/game.dart';

import '../core/base/game_result.dart';
import '../core/systems/audio_manager.dart';
import '../core/systems/audio_service.dart';
import '../../constants/asset_paths.dart';
import 'components/garden_animal_component.dart';
import 'logic/adam_logic.dart';
import 'models/adam_content.dart';
import 'adam_world.dart';

/// Internal state machine for [AdamGame].
enum AdamGameState {
  /// Game is instantiated but [onLoad] has not completed.
  idle,

  /// Animals are on screen; player is naming them.
  playing,

  /// Game is finished.
  completed,
}

// ignore: constant_identifier_names
const String _adamIntroOverlayKey = 'adamIntro';

/// Flame [FlameGame] for the Adam and Eve animal-naming mini-game.
///
/// Child taps 4 animals to name them. Once all 4 are named,
/// [onComplete] is called with [GameResult.success].
///
/// No Riverpod. No Navigator. Data enters via constructor; result exits via callback.
class AdamGame extends FlameGame {
  /// Overlay key for the pre-game intro screen.
  static const String introOverlayKey = _adamIntroOverlayKey;

  /// Called exactly once when the player successfully completes the game.
  final void Function(GameResult)? onComplete;

  /// In-game audio manager — constructed internally, never sourced from providers.
  late final AudioManager audioManager;

  late final AdamWorld _world;

  AdamGameState _state = AdamGameState.idle;

  late final AdamLogic _adamLogic;

  /// Guards [onComplete] so it is called at most once.
  bool _completed = false;

  /// Creates an [AdamGame]. Provide [onComplete] to receive the game result.
  AdamGame({this.onComplete}) : super() {
    audioManager = AudioManager(AudioService());
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    _adamLogic = AdamLogic(List.of(AdamContent.animals));

    _world = AdamWorld(onAnimalTap: _handleAnimalTap);
    await add(_world);

    unawaited(audioManager.playBgm(AssetPaths.flameBgmAdam));
    overlays.add(introOverlayKey);
    _state = AdamGameState.playing;
  }

  @override
  void onRemove() {
    audioManager.stopBgm();
    super.onRemove();
  }

  /// Handles a tap on a [GardenAnimalComponent].
  void _handleAnimalTap(GardenAnimalComponent animal) {
    if (_state != AdamGameState.playing) return;

    final named = _adamLogic.nameAnimal(animal.data.id);
    if (named == null) return;

    animal.triggerNamedFeedback();
    unawaited(audioManager.playSfx(AssetPaths.flameSfxTap));

    if (_adamLogic.allNamed) {
      unawaited(_onAllAnimalsNamed());
    }
  }

  Future<void> _onAllAnimalsNamed() async {
    if (_completed) return;
    _completed = true;
    _state = AdamGameState.completed;

    await audioManager.playSfx(AssetPaths.flameSfxSuccess);
    await audioManager.stopBgm(fade: const Duration(milliseconds: 500));
    await Future<void>.delayed(const Duration(milliseconds: 1500));

    onComplete?.call(GameResult.success);
  }
}
