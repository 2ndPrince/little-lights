import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/routes/app_router.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_sizes.dart';
import '../../app/theme/app_text_styles.dart';

/// Reusable intro screen for any story.
///
/// Shows a large illustration, story title, a short intro sentence,
/// and a "Let's Go!" button that navigates to [startRoute].
class StoryIntroScreen extends StatelessWidget {
  /// Display title of the story (e.g. "Noah's Ark").
  final String title;

  /// Flutter full asset path for the hero illustration.
  final String illustrationAssetPath;

  /// One short sentence displayed below the title.
  final String introSentence;

  /// go_router route pushed when the child taps "Let's Go!".
  final String startRoute;

  /// Optional route to navigate to on back. If null, pops the current route.
  final String? backRoute;

  const StoryIntroScreen({
    super.key,
    required this.title,
    required this.illustrationAssetPath,
    required this.introSentence,
    required this.startRoute,
    this.backRoute,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 6,
                  child: Image.asset(
                    illustrationAssetPath,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.spaceL,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: AppTextStyles.storyTitle,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: AppSizes.spaceM),
                        Text(
                          introSentence,
                          style: AppTextStyles.body.copyWith(fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: AppSizes.spaceXL),
                        _LetsGoButton(startRoute: startRoute),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: AppSizes.spaceS,
              left: AppSizes.spaceS,
              child: _BackButton(backRoute: backRoute),
            ),
          ],
        ),
      ),
    );
  }
}

class _LetsGoButton extends StatelessWidget {
  final String startRoute;

  const _LetsGoButton({required this.startRoute});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppSizes.buttonWidth,
      height: AppSizes.buttonHeight,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accentOrange,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusButton),
          ),
        ),
        onPressed: () => context.go(startRoute),
        child: const Text("Let's Go!", style: AppTextStyles.button),
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  final String? backRoute;

  const _BackButton({this.backRoute});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppSizes.tapMin,
      height: AppSizes.tapMin,
      child: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 28),
        color: AppColors.textDark,
        onPressed: () {
          context.go(backRoute ?? AppRoutes.stories);
        },
      ),
    );
  }
}
