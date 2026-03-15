import 'dart:async';

import 'package:flame/game.dart';

import '../core/base/game_result.dart';
import '../core/systems/audio_manager.dart';
import '../core/systems/audio_service.dart';
import '../../constants/asset_paths.dart';
import 'components/food_item_component.dart';
import 'logic/feeding_logic.dart';
import 'models/feeding_content.dart';
import 'feeding_world.dart';

/// Internal state machine for [FeedingGame].
enum FeedingGameState {
  /// Game is instantiated but [onLoad] has not completed.
  idle,

  /// Food items are on screen; player is collecting them.
  playing,

  /// Game is finished.
  completed,
}

// ignore: constant_identifier_names
const String _feedingIntroOverlayKey = 'feedingIntro';

/// Flame [FlameGame] for the Feeding the 5,000 mini-game.
///
/// Child taps 7 food items (5 loaves + 2 fish). Once all are collected,
/// [onComplete] is called with [GameResult.success].
///
/// No Riverpod. No Navigator. Data enters via constructor; result exits via callback.
class FeedingGame extends FlameGame {
  /// Overlay key for the pre-game intro screen.
  static const String introOverlayKey = _feedingIntroOverlayKey;

  /// Called exactly once when the player successfully completes the game.
  final void Function(GameResult)? onComplete;

  /// In-game audio manager — constructed internally, never sourced from providers.
  late final AudioManager audioManager;

  late final FeedingWorld _world;

  FeedingGameState _state = FeedingGameState.idle;

  late final FeedingLogic _feedingLogic;

  /// Guards [onComplete] so it is called at most once.
  bool _completed = false;

  /// Creates a [FeedingGame]. Provide [onComplete] to receive the game result.
  FeedingGame({this.onComplete}) : super() {
    audioManager = AudioManager(AudioService());
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    _feedingLogic = FeedingLogic(List.of(FeedingContent.items));

    _world = FeedingWorld(onItemTap: _handleItemTap);
    await add(_world);

    unawaited(audioManager.playBgm(AssetPaths.flameBgmFeeding));
    overlays.add(introOverlayKey);
    _state = FeedingGameState.playing;
  }

  @override
  void onRemove() {
    audioManager.stopBgm();
    super.onRemove();
  }

  /// Handles a tap on a [FoodItemComponent].
  void _handleItemTap(FoodItemComponent item) {
    if (_state != FeedingGameState.playing) return;

    final collected = _feedingLogic.collectItem(item.data.id);
    if (collected == null) return;

    item.triggerCollectedFeedback();
    unawaited(audioManager.playSfx(AssetPaths.flameSfxTap));

    if (_feedingLogic.allCollected) {
      unawaited(_onAllItemsCollected());
    }
  }

  Future<void> _onAllItemsCollected() async {
    if (_completed) return;
    _completed = true;
    _state = FeedingGameState.completed;

    await audioManager.playSfx(AssetPaths.flameSfxSuccess);
    await audioManager.stopBgm(fade: const Duration(milliseconds: 500));
    await Future<void>.delayed(const Duration(milliseconds: 1500));

    onComplete?.call(GameResult.success);
  }
}
