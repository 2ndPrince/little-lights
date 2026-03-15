import 'dart:async';

import 'package:flame/game.dart';

import '../core/base/game_result.dart';
import '../core/systems/audio_manager.dart';
import '../core/systems/audio_service.dart';
import '../../constants/asset_paths.dart';
import 'components/creation_element_component.dart';
import 'logic/creation_logic.dart';
import 'models/creation_content.dart';
import 'creation_world.dart';

/// Internal state machine for [CreationGame].
enum CreationGameState {
  /// Game is instantiated but [onLoad] has not completed.
  idle,

  /// Elements are on screen; player is tapping them in order.
  playing,

  /// Game is finished.
  completed,
}

// ignore: constant_identifier_names
const String _creationIntroOverlayKey = 'creationIntro';

/// Flame [FlameGame] for the Creation mini-game.
///
/// Child taps 6 creation elements in order (days 1–6). Wrong order triggers
/// shake feedback. All 6 in order → [onComplete] called with [GameResult.success].
///
/// No Riverpod. No Navigator. Data enters via constructor; result exits via callback.
class CreationGame extends FlameGame {
  /// Overlay key for the pre-game intro screen.
  static const String introOverlayKey = _creationIntroOverlayKey;

  /// Called exactly once when the player successfully completes the game.
  final void Function(GameResult)? onComplete;

  /// In-game audio manager — constructed internally, never sourced from providers.
  late final AudioManager audioManager;

  late final CreationWorld _world;

  CreationGameState _state = CreationGameState.idle;

  late final CreationLogic _creationLogic;

  /// Guards [onComplete] so it is called at most once.
  bool _completed = false;

  /// Creates a [CreationGame]. Provide [onComplete] to receive the game result.
  CreationGame({this.onComplete}) : super() {
    audioManager = AudioManager(AudioService());
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    _creationLogic = CreationLogic(List.of(CreationContent.elements));

    _world = CreationWorld(onElementTap: _handleElementTap);
    await add(_world);

    unawaited(audioManager.playBgm(AssetPaths.flameBgmCreation));
    overlays.add(introOverlayKey);
    _state = CreationGameState.playing;
  }

  @override
  void onRemove() {
    audioManager.stopBgm();
    super.onRemove();
  }

  /// Handles a tap on a [CreationElementComponent].
  void _handleElementTap(CreationElementComponent element) {
    if (_state != CreationGameState.playing) return;

    final activated = _creationLogic.tapElement(element.data.id);

    if (activated != null) {
      element.triggerActivatedFeedback();
      unawaited(audioManager.playSfx(AssetPaths.flameSfxTap));

      if (_creationLogic.allActivated) {
        unawaited(_onAllElementsActivated());
      }
    } else {
      element.triggerWrongFeedback();
      unawaited(audioManager.playSfx(AssetPaths.flameSfxIncorrect));
    }
  }

  Future<void> _onAllElementsActivated() async {
    if (_completed) return;
    _completed = true;
    _state = CreationGameState.completed;

    await audioManager.playSfx(AssetPaths.flameSfxSuccess);
    await audioManager.stopBgm(fade: const Duration(milliseconds: 500));
    await Future<void>.delayed(const Duration(milliseconds: 1500));

    onComplete?.call(GameResult.success);
  }
}
