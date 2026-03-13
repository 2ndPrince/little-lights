import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_sizes.dart';
import '../../app/theme/app_text_styles.dart';
import '../../providers/settings_provider.dart';

/// Settings screen — accessible from the home screen (parent-friendly).
/// Exposes the sound toggle and a back button.
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final soundEnabled = ref.watch(settingsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: SizedBox(
          width: AppSizes.tapMin,
          height: AppSizes.tapMin,
          child: IconButton(
            iconSize: 32,
            onPressed: () => context.pop(),
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: AppColors.textDark),
          ),
        ),
        title: Text('Settings', style: AppTextStyles.heading),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.spaceL,
            vertical: AppSizes.spaceXL,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SoundToggleRow(
                soundEnabled: soundEnabled,
                onChanged: (v) =>
                    ref.read(settingsProvider.notifier).setSoundEnabled(v),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A labelled row with a large sound toggle.
class _SoundToggleRow extends StatelessWidget {
  const _SoundToggleRow({
    required this.soundEnabled,
    required this.onChanged,
  });

  final bool soundEnabled;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          soundEnabled ? Icons.volume_up_rounded : Icons.volume_off_rounded,
          color: AppColors.textDark,
          size: 36,
        ),
        const SizedBox(width: AppSizes.spaceM),
        Expanded(
          child: Text(
            soundEnabled ? 'Sound On' : 'Sound Off',
            style: AppTextStyles.body,
          ),
        ),
        // Wrap Switch in a minimum-tap-target SizedBox.
        SizedBox(
          width: AppSizes.tapMin,
          height: AppSizes.tapMin,
          child: Center(
            child: Transform.scale(
              scale: 1.4,
              child: Switch(
                value: soundEnabled,
                onChanged: onChanged,
                activeColor: AppColors.accentGreen,
                inactiveThumbColor: AppColors.cardLocked,
                inactiveTrackColor: AppColors.cardLocked.withValues(alpha: 0.4),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
