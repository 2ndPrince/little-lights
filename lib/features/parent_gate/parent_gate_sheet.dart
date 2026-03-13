import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../app/routes/app_router.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_sizes.dart';
import '../../app/theme/app_text_styles.dart';
import '../../providers/progress_provider.dart';
import '../../providers/settings_provider.dart';

/// Bottom-sheet content for the parent-only zone.
///
/// Locked by default: the parent must hold the "Hold to enter" button for
/// 2 seconds to unlock. Once unlocked, sound toggle, reset-progress, and
/// settings navigation are available.
///
/// Show via [ParentGateSheet.show].
class ParentGateSheet extends ConsumerStatefulWidget {
  const ParentGateSheet({super.key});

  /// Shows this sheet as a modal bottom sheet.
  static void show(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const ParentGateSheet(),
    );
  }

  @override
  ConsumerState<ParentGateSheet> createState() => _ParentGateSheetState();
}

class _ParentGateSheetState extends ConsumerState<ParentGateSheet>
    with SingleTickerProviderStateMixin {
  static const _holdDuration = Duration(seconds: 2);

  late final AnimationController _holdController;
  bool _unlocked = false;

  @override
  void initState() {
    super.initState();
    _holdController = AnimationController(vsync: this, duration: _holdDuration)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() => _unlocked = true);
        }
      });
  }

  @override
  void dispose() {
    _holdController.dispose();
    super.dispose();
  }

  void _startHold() => _holdController.forward();

  void _cancelHold() {
    if (!_unlocked) _holdController.reverse();
  }

  Future<void> _confirmReset(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusCard),
        ),
        title: Text('Reset Progress?', style: AppTextStyles.heading),
        content: Text(
          'All story progress and stars will be cleared. This cannot be undone.',
          style: AppTextStyles.small,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text('Cancel',
                style: AppTextStyles.small
                    .copyWith(color: AppColors.accentOrange)),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text('Reset',
                style: AppTextStyles.small.copyWith(color: Colors.redAccent)),
          ),
        ],
      ),
    );
    if (confirmed == true && context.mounted) {
      await ref.read(progressProvider.notifier).resetAll();
      if (context.mounted) Navigator.of(context).pop(); // close sheet
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSizes.radiusCard),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(
        AppSizes.spaceL,
        AppSizes.spaceM,
        AppSizes.spaceL,
        AppSizes.spaceXL,
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _SheetHandle(),
            const SizedBox(height: AppSizes.spaceM),
            const _ParentZoneTitle(),
            const SizedBox(height: AppSizes.spaceXL),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _unlocked
                  ? _UnlockedContent(onReset: _confirmReset)
                  : _LockedContent(
                      controller: _holdController,
                      onHoldStart: _startHold,
                      onHoldEnd: _cancelHold,
                    ),
            ),
            const SizedBox(height: AppSizes.spaceM),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Sub-widgets
// ---------------------------------------------------------------------------

class _SheetHandle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: AppColors.cardLocked,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}

class _ParentZoneTitle extends StatelessWidget {
  const _ParentZoneTitle();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.lock_rounded, color: AppColors.textDark, size: 28),
        const SizedBox(width: AppSizes.spaceS),
        Text('Parent Zone', style: AppTextStyles.heading),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Locked state
// ---------------------------------------------------------------------------

/// Shown before the parent completes the 2-second hold.
class _LockedContent extends StatelessWidget {
  const _LockedContent({
    required this.controller,
    required this.onHoldStart,
    required this.onHoldEnd,
  });

  final AnimationController controller;
  final VoidCallback onHoldStart;
  final VoidCallback onHoldEnd;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Hold the button below to enter',
          style: AppTextStyles.body,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSizes.spaceXL),
        GestureDetector(
          onTapDown: (_) => onHoldStart(),
          onTapUp: (_) => onHoldEnd(),
          onTapCancel: onHoldEnd,
          child: _HoldCircle(controller: controller),
        ),
        const SizedBox(height: AppSizes.spaceM),
        Text('Hold for 2 seconds', style: AppTextStyles.small),
      ],
    );
  }
}

/// Animated circle that fills as the user holds down.
class _HoldCircle extends StatelessWidget {
  const _HoldCircle({required this.controller});

  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return SizedBox(
          width: AppSizes.tapMin * 1.3,
          height: AppSizes.tapMin * 1.3,
          child: CustomPaint(
            painter: _HoldProgressPainter(progress: controller.value),
            child: Center(
              child: Icon(
                Icons.lock_open_rounded,
                color: Color.lerp(
                  AppColors.cardLocked,
                  AppColors.accentGreen,
                  controller.value,
                ),
                size: 36,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _HoldProgressPainter extends CustomPainter {
  const _HoldProgressPainter({required this.progress});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 4;

    // Background track
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = AppColors.cardLocked.withValues(alpha: 0.4)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 6,
    );

    // Fill arc — sweeps clockwise from the top
    if (progress > 0) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -math.pi / 2,
        2 * math.pi * progress,
        false,
        Paint()
          ..color = AppColors.accentGreen
          ..style = PaintingStyle.stroke
          ..strokeWidth = 6
          ..strokeCap = StrokeCap.round,
      );
    }
  }

  @override
  bool shouldRepaint(_HoldProgressPainter old) => old.progress != progress;
}

// ---------------------------------------------------------------------------
// Unlocked state
// ---------------------------------------------------------------------------

/// Shown after the hold is complete.
class _UnlockedContent extends ConsumerWidget {
  const _UnlockedContent({required this.onReset});

  final Future<void> Function(BuildContext context) onReset;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final soundEnabled = ref.watch(settingsProvider);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Sound toggle row
        Row(
          children: [
            Icon(
              soundEnabled
                  ? Icons.volume_up_rounded
                  : Icons.volume_off_rounded,
              color: AppColors.textDark,
              size: 32,
            ),
            const SizedBox(width: AppSizes.spaceM),
            Expanded(
              child: Text(
                soundEnabled ? 'Sound On' : 'Sound Off',
                style: AppTextStyles.body,
              ),
            ),
            SizedBox(
              width: AppSizes.tapMin,
              height: AppSizes.tapMin,
              child: Center(
                child: Transform.scale(
                  scale: 1.4,
                  child: Switch(
                    value: soundEnabled,
                    onChanged: (v) =>
                        ref.read(settingsProvider.notifier).setSoundEnabled(v),
                    activeColor: AppColors.accentGreen,
                    inactiveThumbColor: AppColors.cardLocked,
                    inactiveTrackColor:
                        AppColors.cardLocked.withValues(alpha: 0.4),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSizes.spaceL),

        // Reset progress button
        SizedBox(
          width: double.infinity,
          height: AppSizes.buttonHeight,
          child: OutlinedButton.icon(
            onPressed: () => onReset(context),
            icon: const Icon(Icons.refresh_rounded, color: Colors.redAccent),
            label: Text(
              'Reset Progress',
              style: AppTextStyles.button.copyWith(color: Colors.redAccent),
            ),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.redAccent, width: 2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusButton),
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSizes.spaceM),

        // Settings navigation button
        SizedBox(
          width: double.infinity,
          height: AppSizes.buttonHeight,
          child: TextButton.icon(
            onPressed: () {
              Navigator.of(context).pop(); // close sheet first
              context.go(AppRoutes.settings);
            },
            icon: const Icon(Icons.settings_rounded,
                color: AppColors.accentOrange),
            label: Text(
              'Settings',
              style:
                  AppTextStyles.button.copyWith(color: AppColors.accentOrange),
            ),
          ),
        ),
      ],
    );
  }
}
