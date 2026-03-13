import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:little_lights/app/theme/app_theme.dart';
import 'package:little_lights/constants/asset_paths.dart';
import 'package:little_lights/features/david/david_story_intro_screen.dart';
import 'package:little_lights/features/rewards/reward_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ── Minimal 1×1 transparent PNG ────────────────────────────────────────────
const List<int> _kTransparentImage = <int>[
  0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A,
  0x00, 0x00, 0x00, 0x0D, 0x49, 0x48, 0x44, 0x52,
  0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01,
  0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4,
  0x89, 0x00, 0x00, 0x00, 0x0A, 0x49, 0x44, 0x41,
  0x54, 0x78, 0x9C, 0x62, 0x00, 0x01, 0x00, 0x00,
  0x05, 0x00, 0x01, 0x0D, 0x0A, 0x2D, 0xB4, 0x00,
  0x00, 0x00, 0x00, 0x49, 0x45, 0x4E, 0x44, 0xAE,
  0x42, 0x60, 0x82,
];

class _FakeAssetBundle extends AssetBundle {
  static final ByteData _emptyManifest =
      ByteData.sublistView(Uint8List.fromList(const <int>[0x0D, 0x00]));

  @override
  Future<ByteData> load(String key) async {
    if (key == 'AssetManifest.bin') return _emptyManifest;
    return ByteData.sublistView(Uint8List.fromList(_kTransparentImage));
  }

  @override
  Future<String> loadString(String key, {bool cache = true}) async => '{}';

  @override
  Future<T> loadStructuredData<T>(
    String key,
    Future<T> Function(String) parser,
  ) =>
      loadString(key).then(parser);

  @override
  Future<T> loadStructuredBinaryData<T>(
    String key,
    FutureOr<T> Function(ByteData) parser,
  ) =>
      load(key).then(parser);
}

// ── Tests ────────────────────────────────────────────────────────────────────

void main() {
  setUpAll(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('DavidStoryIntroScreen', () {
    testWidgets('renders story title', (tester) async {
      final router = GoRouter(
        initialLocation: '/david/intro',
        routes: [
          GoRoute(
            path: '/david/intro',
            builder: (_, __) => DefaultAssetBundle(
              bundle: _FakeAssetBundle(),
              child: const DavidStoryIntroScreen(),
            ),
          ),
          GoRoute(
            path: '/david/game',
            builder: (_, __) =>
                const Scaffold(body: Text('game')),
          ),
        ],
      );

      await tester.pumpWidget(
        MaterialApp.router(
          theme: AppTheme.light,
          routerConfig: router,
        ),
      );
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('David and Goliath'), findsOneWidget);
    });
  });

  group('David RewardScreen', () {
    testWidgets('renders David story title on reward screen', (tester) async {
      final router = GoRouter(
        initialLocation: '/david/reward',
        routes: [
          GoRoute(
            path: '/david/reward',
            builder: (_, __) => DefaultAssetBundle(
              bundle: _FakeAssetBundle(),
              child: const RewardScreen(
                stars: 1,
                badgeAssetPath: AssetPaths.davidBadge,
                storyTitle: 'David and Goliath',
                replayRoute: '/david/intro',
                doneRoute: '/stories',
              ),
            ),
          ),
          GoRoute(
            path: '/stories',
            builder: (_, __) =>
                const Scaffold(body: Text('stories')),
          ),
          GoRoute(
            path: '/david/intro',
            builder: (_, __) =>
                const Scaffold(body: Text('intro')),
          ),
        ],
      );

      await tester.pumpWidget(
        MaterialApp.router(
          theme: AppTheme.light,
          routerConfig: router,
        ),
      );
      await tester.pump(const Duration(seconds: 2));

      expect(find.text('David and Goliath'), findsOneWidget);
    });

    testWidgets('Done button navigates to stories', (tester) async {
      final router = GoRouter(
        initialLocation: '/david/reward',
        routes: [
          GoRoute(
            path: '/david/reward',
            builder: (_, __) => DefaultAssetBundle(
              bundle: _FakeAssetBundle(),
              child: const RewardScreen(
                stars: 1,
                badgeAssetPath: AssetPaths.davidBadge,
                storyTitle: 'David and Goliath',
                replayRoute: '/david/intro',
                doneRoute: '/stories',
              ),
            ),
          ),
          GoRoute(
            path: '/stories',
            builder: (_, __) =>
                const Scaffold(body: Text('stories')),
          ),
          GoRoute(
            path: '/david/intro',
            builder: (_, __) =>
                const Scaffold(body: Text('intro')),
          ),
        ],
      );

      await tester.pumpWidget(
        MaterialApp.router(
          theme: AppTheme.light,
          routerConfig: router,
        ),
      );
      await tester.pump(const Duration(seconds: 2));

      await tester.tap(find.text('Done'));
      await tester.pumpAndSettle();

      expect(find.text('stories'), findsOneWidget);
    });
  });
}
