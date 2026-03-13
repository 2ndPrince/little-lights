import 'audio_service.dart';

/// Thin wrapper around [AudioService] for use inside Flame game components.
/// Passed via constructor — never imported from providers inside Flame.
class AudioManager {
  final AudioService _service;

  const AudioManager(this._service);

  /// Plays a one-shot SFX. [flameAudioPath] is relative to assets/audio/.
  /// Example: 'sfx/sfx_match.mp3'
  Future<void> playSfx(String flameAudioPath) =>
      _service.playSfx('assets/audio/$flameAudioPath');

  /// Starts looping BGM. [flameBgmPath] is relative to assets/audio/.
  Future<void> playBgm(String flameBgmPath) =>
      _service.playBgm('assets/audio/$flameBgmPath');

  /// Stops BGM.
  Future<void> stopBgm({Duration fade = Duration.zero}) =>
      _service.stopBgm(fadeDuration: fade);
}
