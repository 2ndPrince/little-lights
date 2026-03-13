import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:little_lights/app/theme/app_theme.dart';
import 'package:little_lights/constants/asset_paths.dart';
import 'package:little_lights/data/models/story.dart';
import 'package:little_lights/data/models/story_progress.dart';
import 'package:little_lights/features/rewards/reward_screen.dart';
import 'package:little_lights/widgets/story_card.dart';

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

/// Fake asset bundle that returns a valid 1×1 PNG for every binary key
/// and an empty JSON object for every string key.
///
/// Prevents [Image.asset] from failing in tests where real assets
/// are not present in the test runner's asset bundle.
///
/// [AssetManifest.bin] receives a valid empty [StandardMessageCodec] map
/// (`[0x0D, 0x00]`) so that [AssetImage.obtainKey] can parse it without
/// throwing a [FormatException].
class _FakeAssetBundle extends AssetBundle {
  // StandardMessageCodec empty map: type byte 0x0D (13 = map), size byte 0x00.
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

// ── Shared test story ───────────────────────────────────────────────────────

const Story _noahStory = Story(
  id: StoryId.noah,
  titleFallback: "Noah's Ark",
  thumbnailPath: AssetPaths.noahBgSky,
  bgmPath: AssetPaths.bgmNoah,
  theme: StoryTheme.obedience,
);

// ── Helper builders ─────────────────────────────────────────────────────────

/// Wraps [StoryCard] in a [MaterialApp] with a fake asset bundle.
Widget _buildCard(StoryProgress progress, {VoidCallback? onTap}) {
  return DefaultAssetBundle(
    bundle: _FakeAssetBundle(),
    child: MaterialApp(
      theme: AppTheme.light,
      home: Scaffold(
        body: SizedBox(
          width: 200,
          height: 200,
          child: StoryCard(
            story: _noahStory,
            progress: progress,
            onTap: onTap,
          ),
        ),
      ),
    ),
  );
}

/// Builds a minimal [GoRouter] for [RewardScreen] tests.
///
/// - `/reward` → [RewardScreen]
/// - `/stories` → plain `Text('stories')`  (the expected doneRoute)
/// - `/replay`  → plain `Text('replay')`   (the expected replayRoute)
GoRouter _buildTestRouter() => GoRouter(
      initialLocation: '/reward',
      routes: [
        GoRoute(
          path: '/reward',
          builder: (_, __) => DefaultAssetBundle(
            bundle: _FakeAssetBundle(),
            child: const RewardScreen(
              stars: 1,
              badgeAssetPath: AssetPaths.noahBadge,
              storyTitle: "Noah's Ark",
              replayRoute: '/replay',
              doneRoute: '/stories',
            ),
          ),
        ),
        GoRoute(
          path: '/stories',
          builder: (_, __) => const Scaffold(body: Center(child: Text('stories'))),
        ),
        GoRoute(
          path: '/replay',
          builder: (_, __) => const Scaffold(body: Center(child: Text('replay'))),
        ),
      ],
    );

// ── Tests ────────────────────────────────────────────────────────────────────

void main() {
  group('StoryCard', () {
    testWidgets('locked card shows lock icon', (tester) async {
      await tester.pumpWidget(_buildCard(
        const StoryProgress(storyId: StoryId.noah, isUnlocked: false),
      ));
      await tester.pump();

      expect(find.byIcon(Icons.lock_rounded), findsOneWidget);
    });

    testWidgets('unlocked card has no lock icon', (tester) async {
      await tester.pumpWidget(_buildCard(
        const StoryProgress(storyId: StoryId.noah, isUnlocked: true),
      ));
      await tester.pump();

      expect(find.byIcon(Icons.lock_rounded), findsNothing);
    });

    testWidgets('completed card shows star badge', (tester) async {
      await tester.pumpWidget(_buildCard(
        const StoryProgress(
          storyId: StoryId.noah,
          isUnlocked: true,
          isCompleted: true,
        ),
      ));
      await tester.pump();

      expect(find.byIcon(Icons.star_rounded), findsOneWidget);
    });

    testWidgets('locked card tap does nothing', (tester) async {
      var tapped = false;

      await tester.pumpWidget(_buildCard(
        const StoryProgress(storyId: StoryId.noah, isUnlocked: false),
        onTap: () => tapped = true,
      ));
      await tester.pump();

      await tester.tap(find.byType(StoryCard));
      await tester.pump();

      expect(tapped, isFalse);
    });
  });

  group('RewardScreen', () {
    testWidgets('shows story title', (tester) async {
      await tester.pumpWidget(MaterialApp.router(
        theme: AppTheme.light,
        routerConfig: _buildTestRouter(),
      ));
      // Advance past entry animations without waiting for full settle,
      // as elasticOut / bounceOut curves are slow to converge.
      await tester.pump(const Duration(seconds: 2));

      expect(find.text("Noah's Ark"), findsOneWidget);
    });

    testWidgets('shows correct number of star slots', (tester) async {
      await tester.pumpWidget(MaterialApp.router(
        theme: AppTheme.light,
        routerConfig: _buildTestRouter(),
      ));
      await tester.pump(const Duration(seconds: 2));

      // _StarRow renders 3 ScaleTransition widgets (one per slot); router may add more.
      expect(find.byType(ScaleTransition), findsAtLeastNWidgets(3));
    });

    testWidgets('Done button navigates to doneRoute', (tester) async {
      await tester.pumpWidget(MaterialApp.router(
        theme: AppTheme.light,
        routerConfig: _buildTestRouter(),
      ));
      await tester.pump(const Duration(seconds: 2));

      await tester.tap(find.text('Done'));
      await tester.pumpAndSettle();

      expect(find.text('stories'), findsOneWidget);
    });
  });
}
