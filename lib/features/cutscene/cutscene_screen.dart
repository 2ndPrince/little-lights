import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_text_styles.dart';
import '../../app/theme/app_sizes.dart';

/// Full-screen cutscene player that advances through [framePaths] automatically.
///
/// Tapping anywhere skips the cutscene and navigates to [nextRoute] immediately.
/// After the last frame the screen auto-advances to [nextRoute].
class CutsceneScreen extends StatefulWidget {
  /// Ordered list of Flutter asset paths (e.g. from [AssetPaths.noahCutsceneFrames]).
  final List<String> framePaths;

  /// How long each frame is shown. Defaults to 600 ms.
  final Duration frameDuration;

  /// Route to push when the cutscene ends (or is skipped).
  final String nextRoute;

  const CutsceneScreen({
    super.key,
    required this.framePaths,
    this.frameDuration = const Duration(milliseconds: 600),
    required this.nextRoute,
  });

  @override
  State<CutsceneScreen> createState() => _CutsceneScreenState();
}

class _CutsceneScreenState extends State<CutsceneScreen> {
  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _scheduleNext();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _scheduleNext() {
    _timer?.cancel();
    _timer = Timer(widget.frameDuration, _advanceFrame);
  }

  void _advanceFrame() {
    if (!mounted) return;
    final isLast = _currentIndex >= widget.framePaths.length - 1;
    if (isLast) {
      _navigate();
    } else {
      setState(() => _currentIndex++);
      _scheduleNext();
    }
  }

  void _navigate() {
    _timer?.cancel();
    if (mounted) context.go(widget.nextRoute);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _navigate,
      behavior: HitTestBehavior.opaque,
      child: Scaffold(
        backgroundColor: AppColors.textDark,
        body: Stack(
          fit: StackFit.expand,
          children: [
            _FrameImage(path: widget.framePaths[_currentIndex]),
            _SkipButton(onSkip: _navigate),
          ],
        ),
      ),
    );
  }
}

/// Displays a single cutscene frame, filling the screen.
class _FrameImage extends StatelessWidget {
  final String path;
  const _FrameImage({required this.path});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      path,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
    );
  }
}

/// Subtle skip button in the top-right corner.
class _SkipButton extends StatelessWidget {
  final VoidCallback onSkip;
  const _SkipButton({required this.onSkip});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: AppSizes.spaceM + MediaQuery.of(context).padding.top,
      right: AppSizes.spaceM,
      child: GestureDetector(
        onTap: onSkip,
        behavior: HitTestBehavior.opaque,
        child: Container(
          constraints: const BoxConstraints(
            minWidth: AppSizes.tapMin,
            minHeight: AppSizes.tapMin,
          ),
          alignment: Alignment.center,
          child: Text(
            'Skip',
            style: AppTextStyles.small.copyWith(
              color: AppColors.textLight.withValues(alpha: 0.7),
            ),
          ),
        ),
      ),
    );
  }
}
