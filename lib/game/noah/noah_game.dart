import 'dart:async';

import 'package:flame/game.dart';

import '../core/base/game_result.dart';
import '../core/systems/audio_manager.dart';
import '../core/systems/audio_service.dart';
import '../../constants/asset_paths.dart';
import 'components/animal_card.dart';
import 'logic/matching_logic.dart';
import 'models/animal_pair.dart';
import 'models/noah_content.dart';
import 'noah_world.dart';

/// Internal state machine for [NoahGame].
enum NoahGameState {
  /// Game is instantiated but [onLoad] has not completed.
  idle,

  /// Cutscene or intro sequence is playing (reserved for future use).
  intro,

  /// Cards are on screen; no card is selected.
  playing,

  /// One card is selected and waiting for a second tap.
  pairSelected,

  /// Two cards were just matched — visual feedback in progress.
  pairMatched,

  /// Matched pair has been loaded into the ark.
  pairLoaded,

  /// All pairs matched; game is finishing.
  completed,
}

/// Key used to register and remove the intro overlay via [FlameGame.overlays].
///
/// Pass this to [GameWidget.overlayBuilderMap] and call [overlays.add] in [onLoad].
// ignore: constant_identifier_names
const String _noahIntroOverlayKey = 'noahIntro';

/// Flame [FlameGame] for the Noah's Ark animal-matching mini-game.
///
/// Constructs and owns a [NoahWorld] and an [AudioManager]. Drives the
/// state machine via [_handleCardTap], which [AnimalCard] components call.
/// Calls [onComplete] exactly once with [GameResult.success] when all
/// animal pairs are loaded into the ark.
///
/// No Riverpod. No Navigator. Data enters via constructor; result exits via callback.
class NoahGame extends FlameGame {
  /// Overlay key for the pre-game intro screen.
  ///
  /// Register in [GameWidget.overlayBuilderMap] with this key.
  static const String introOverlayKey = _noahIntroOverlayKey;

  /// Called exactly once when the player successfully completes the game.
  final void Function(GameResult)? onComplete;

  /// In-game audio manager — constructed internally, never sourced from providers.
  late final AudioManager audioManager;

  late final NoahWorld _world;

  NoahGameState _state = NoahGameState.idle;

  AnimalCard? _selectedCard;

  /// Mutable working copy of [NoahContent.animalPairs] — tracks [AnimalPair.isLoaded].
  final List<AnimalPair> _pairs = List.of(NoahContent.animalPairs);

  /// Guards [onComplete] so it is called at most once.
  bool _completed = false;

  /// Creates a [NoahGame]. Provide [onComplete] to receive the game result.
  NoahGame({this.onComplete}) : super() {
    audioManager = AudioManager(AudioService());
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _world = NoahWorld(onCardTap: _handleCardTap);
    await add(_world);
    _state = NoahGameState.playing;
    overlays.add(introOverlayKey);
    unawaited(audioManager.playBgm(AssetPaths.flameBgmNoah));
  }

  @override
  void onRemove() {
    unawaited(audioManager.stopBgm());
    super.onRemove();
  }

  /// Current game state — read-only for external observers (e.g. tests).
  NoahGameState get state => _state;

  // ── Card tap handling ──────────────────────────────────────────────────

  /// Receives a tap from [card] and drives the state machine.
  ///
  /// Exposed as package-private so [AnimalCard] callbacks can reach it via
  /// the [onCardTap] closure passed through [NoahWorld].
  void _handleCardTap(AnimalCard card) {
    if (_state == NoahGameState.completed) return;

    final selected = _selectedCard;

    if (selected == null) {
      // First tap — select the card.
      _selectedCard = card;
      card.select();
      _state = NoahGameState.pairSelected;
      unawaited(audioManager.playSfx(AssetPaths.flameSfxTap));
      return;
    }

    if (identical(selected, card)) {
      // Same card tapped again — deselect.
      card.deselect();
      _selectedCard = null;
      _state = NoahGameState.playing;
      return;
    }

    // Second card tapped — evaluate the pair.
    _selectedCard = null;

    if (MatchingLogic.isValidPair(selected.data, card.data)) {
      _onValidPair(selected, card);
    } else {
      _onInvalidPair(selected, card);
    }
  }

  void _onValidPair(AnimalCard a, AnimalCard b) {
    a.triggerMatchFeedback();
    b.triggerMatchFeedback();
    _state = NoahGameState.pairMatched;
    unawaited(audioManager.playSfx(AssetPaths.flameSfxMatch));

    _markPairLoaded(a.data.pairId);
    _world.arkDropZone.acceptPair(a.data.pairId);

    // For MVP: pairMatched == pairLoaded immediately.
    _state = NoahGameState.pairLoaded;

    if (MatchingLogic.allPairsLoaded(_pairs)) {
      unawaited(_onAllPairsLoaded());
    } else {
      _state = NoahGameState.playing;
    }
  }

  void _onInvalidPair(AnimalCard a, AnimalCard b) {
    a.triggerWrongFeedback();
    b.triggerWrongFeedback();
    a.deselect();
    _state = NoahGameState.playing;
    unawaited(audioManager.playSfx(AssetPaths.flameSfxIncorrect));
  }

  void _markPairLoaded(String pairId) {
    for (int i = 0; i < _pairs.length; i++) {
      if (_pairs[i].pairId == pairId) {
        _pairs[i] = _pairs[i].markLoaded();
      }
    }
  }

  Future<void> _onAllPairsLoaded() async {
    if (_completed) return;
    _completed = true;
    _state = NoahGameState.completed;

    await audioManager.playSfx(AssetPaths.flameSfxSuccess);
    await audioManager.stopBgm(fade: const Duration(milliseconds: 500));
    await Future<void>.delayed(const Duration(milliseconds: 1500));

    onComplete?.call(GameResult.success);
  }
}
