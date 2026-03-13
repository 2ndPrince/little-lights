import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/routes/app_router.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_sizes.dart';
import '../../app/theme/app_text_styles.dart';
import '../../constants/asset_paths.dart';
import '../../providers/audio_provider.dart';
import '../parent_gate/parent_gate_sheet.dart';

/// Home screen — entry point of the app.
/// Starts background music and provides navigation to stories and parent settings.
class HomeScreen extends ConsumerStatefulWidget {
  /// Creates a [HomeScreen].
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Defer audio start until after first frame so the widget tree is ready.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(audioProvider).playBgm(AssetPaths.bgmHome);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _LogoTitle(),
                  SizedBox(height: AppSizes.spaceXL),
                  _PlayButton(),
                ],
              ),
            ),
            Positioned(
              top: AppSizes.spaceS,
              right: AppSizes.spaceS,
              child: _SettingsButton(),
            ),
          ],
        ),
      ),
    );
  }
}

/// Displays the LittleLights logo and title.
class _LogoTitle extends StatelessWidget {
  const _LogoTitle();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text('✨', style: TextStyle(fontSize: 64)),
        SizedBox(height: AppSizes.spaceS),
        Text('LittleLights', style: AppTextStyles.storyTitle),
      ],
    );
  }
}

/// Primary "Play" button that navigates to the stories screen.
class _PlayButton extends StatelessWidget {
  const _PlayButton();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppSizes.buttonWidth,
      height: AppSizes.buttonHeight,
      child: ElevatedButton(
        onPressed: () => context.go(AppRoutes.stories),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accentOrange,
          foregroundColor: AppColors.textLight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusButton),
          ),
          textStyle: AppTextStyles.button,
        ),
        child: const Text('Play'),
      ),
    );
  }
}

/// Gear/settings button (80×80) that opens the [ParentGateSheet].
class _SettingsButton extends StatelessWidget {
  const _SettingsButton();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppSizes.tapMin,
      height: AppSizes.tapMin,
      child: IconButton(
        icon: const Icon(Icons.settings_rounded, size: 36),
        color: AppColors.textDark,
        onPressed: () => ParentGateSheet.show(context),
        tooltip: 'Parent Zone',
      ),
    );
  }
}
