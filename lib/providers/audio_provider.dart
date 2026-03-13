import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../game/core/systems/audio_service.dart';

/// Singleton [AudioService] for the lifetime of the app.
final audioProvider = Provider<AudioService>((ref) {
  final service = AudioService();
  ref.onDispose(service.dispose);
  return service;
});
