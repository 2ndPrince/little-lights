import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'audio_provider.dart';
import 'progress_provider.dart';

const _keySoundEnabled = 'settings_sound_enabled';

/// Notifier that persists and applies the global sound toggle.
class SettingsNotifier extends Notifier<bool> {
  @override
  bool build() {
    final prefs = ref.read(sharedPreferencesProvider);
    // Default to sound on.
    return prefs.getBool(_keySoundEnabled) ?? true;
  }

  /// Toggles sound on/off, persists the preference, and updates [AudioService].
  Future<void> setSoundEnabled(bool enabled) async {
    state = enabled;
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setBool(_keySoundEnabled, enabled);
    await ref.read(audioProvider).setEnabled(enabled);
  }
}

/// Provides the global sound-enabled setting as a [bool].
final settingsProvider = NotifierProvider<SettingsNotifier, bool>(
  SettingsNotifier.new,
);
