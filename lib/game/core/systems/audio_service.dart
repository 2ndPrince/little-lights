import 'package:audioplayers/audioplayers.dart';

/// App-level audio service. Manages BGM looping and SFX playback.
/// Injected via [audioProvider] — never instantiated directly in widgets.
class AudioService {
  AudioService() {
    _bgmPlayer.setReleaseMode(ReleaseMode.loop);
  }

  final AudioPlayer _bgmPlayer = AudioPlayer();
  final AudioPlayer _sfxPlayer = AudioPlayer();

  bool _enabled = true;
  String? _currentBgm;

  /// Whether audio is globally enabled.
  bool get isEnabled => _enabled;

  /// Starts looping [assetPath] as background music.
  /// Silently swaps if a different track is already playing.
  /// [assetPath] is a Flutter asset path, e.g. 'assets/audio/music/bgm_noah.mp3'
  Future<void> playBgm(String assetPath) async {
    if (!_enabled) return;
    if (_currentBgm == assetPath) return; // already playing
    _currentBgm = assetPath;
    try {
      await _bgmPlayer.play(AssetSource(_stripAssetPrefix(assetPath)));
    } catch (_) {
      // Audio unavailable (e.g. placeholder file, web autoplay policy) — silent fail
    }
  }

  /// Stops BGM. Optionally fades out over [fadeDuration].
  Future<void> stopBgm({Duration fadeDuration = Duration.zero}) async {
    _currentBgm = null;
    if (fadeDuration == Duration.zero) {
      await _bgmPlayer.stop();
    } else {
      // Simple fade: lower volume step by step then stop
      const steps = 10;
      final stepDuration = fadeDuration ~/ steps;
      double volume = 1.0;
      for (int i = 0; i < steps; i++) {
        volume -= 1.0 / steps;
        await _bgmPlayer.setVolume(volume.clamp(0.0, 1.0));
        await Future.delayed(stepDuration);
      }
      await _bgmPlayer.stop();
      await _bgmPlayer.setVolume(1.0); // reset for next play
    }
  }

  /// Plays a one-shot sound effect.
  /// [assetPath] is a Flutter asset path, e.g. 'assets/audio/sfx/sfx_match.mp3'
  Future<void> playSfx(String assetPath) async {
    if (!_enabled) return;
    try {
      await _sfxPlayer.play(AssetSource(_stripAssetPrefix(assetPath)));
    } catch (_) {
      // Audio unavailable — silent fail
    }
  }

  /// Enables or disables all audio. Stops BGM immediately if disabling.
  Future<void> setEnabled(bool enabled) async {
    _enabled = enabled;
    if (!enabled) {
      await _bgmPlayer.stop();
    }
  }

  /// Releases audio players. Call on app dispose.
  Future<void> dispose() async {
    await _bgmPlayer.dispose();
    await _sfxPlayer.dispose();
  }

  /// audioplayers AssetSource strips 'assets/' prefix automatically.
  String _stripAssetPrefix(String path) {
    return path.startsWith('assets/') ? path.substring(7) : path;
  }
}
