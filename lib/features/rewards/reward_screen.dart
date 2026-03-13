import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_text_styles.dart';
import '../../app/theme/app_sizes.dart';
import '../../constants/asset_paths.dart';

/// Celebration screen shown after completing a story.
///
/// Stars scale in with an elastic pop, then the badge slides up from below.
/// Two buttons let the child replay the story or return to the story select.
class RewardScreen extends StatefulWidget {
  /// Number of stars earned (1–3).
  final int stars;

  /// Flutter asset path for the story badge image.
  final String badgeAssetPath;

  /// Display name of the completed story, shown as the heading.
  final String storyTitle;

  /// Route to navigate to when "Play Again" is tapped.
  final String replayRoute;

  /// Route to navigate to when "Done" is tapped.
  final String doneRoute;

  const RewardScreen({
    super.key,
    required this.stars,
    required this.badgeAssetPath,
    required this.storyTitle,
    required this.replayRoute,
    required this.doneRoute,
  });

  @override
  State<RewardScreen> createState() => _RewardScreenState();
}

class _RewardScreenState extends State<RewardScreen>
    with TickerProviderStateMixin {
  late final AnimationController _starController;
  late final AnimationController _badgeController;

  late final Animation<double> _starScale;
  late final Animation<Offset> _badgeSlide;

  @override
  void initState() {
    super.initState();

    _starController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _badgeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _starScale = CurvedAnimation(
      parent: _starController,
      curve: Curves.elasticOut,
    );

    _badgeSlide = Tween<Offset>(
      begin: const Offset(0, 1.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _badgeController,
      curve: Curves.bounceOut,
    ));

    // Stars animate first, badge starts after stars finish.
    _starController.forward().whenComplete(() {
      if (mounted) _badgeController.forward();
    });
  }

  @override
  void dispose() {
    _starController.dispose();
    _badgeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _HeadingText(storyTitle: widget.storyTitle),
            _StarRow(stars: widget.stars, scaleAnimation: _starScale),
            _BadgeImage(
              path: widget.badgeAssetPath,
              slideAnimation: _badgeSlide,
            ),
            _ActionButtons(
              replayRoute: widget.replayRoute,
              doneRoute: widget.doneRoute,
            ),
          ],
        ),
      ),
    );
  }
}

/// Encouraging heading with story title.
class _HeadingText extends StatelessWidget {
  final String storyTitle;
  const _HeadingText({required this.storyTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Amazing!', style: AppTextStyles.storyTitle),
        const SizedBox(height: AppSizes.spaceS),
        Text(storyTitle, style: AppTextStyles.heading),
        const SizedBox(height: AppSizes.spaceXS),
        Text('Great job!', style: AppTextStyles.body),
      ],
    );
  }
}

/// Row of 1–3 stars that scale in together.
class _StarRow extends StatelessWidget {
  final int stars;
  final Animation<double> scaleAnimation;

  const _StarRow({required this.stars, required this.scaleAnimation});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        final earned = index < stars.clamp(1, 3);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.spaceS),
          child: ScaleTransition(
            scale: scaleAnimation,
            child: Image.asset(
              earned ? AssetPaths.starReward : AssetPaths.starEmpty,
              width: 72,
              height: 72,
            ),
          ),
        );
      }),
    );
  }
}

/// Badge that slides up from below the screen.
class _BadgeImage extends StatelessWidget {
  final String path;
  final Animation<Offset> slideAnimation;

  const _BadgeImage({required this.path, required this.slideAnimation});

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: slideAnimation,
      child: Image.asset(path, width: 160, height: 160),
    );
  }
}

/// "Play Again" and "Done" buttons with minimum 80×80 tap targets.
class _ActionButtons extends StatelessWidget {
  final String replayRoute;
  final String doneRoute;

  const _ActionButtons({
    required this.replayRoute,
    required this.doneRoute,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _RewardButton(
          label: 'Play Again',
          color: AppColors.accentOrange,
          onTap: () => context.go(replayRoute),
        ),
        _RewardButton(
          label: 'Done',
          color: AppColors.grassGreen,
          onTap: () => context.go(doneRoute),
        ),
      ],
    );
  }
}

/// Single styled action button with enforced minimum tap target.
class _RewardButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _RewardButton({
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(
          minWidth: AppSizes.buttonWidth,
          minHeight: AppSizes.buttonHeight,
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(AppSizes.radiusButton),
          boxShadow: const [
            BoxShadow(
              color: Color(0x33000000),
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Text(label, style: AppTextStyles.button),
      ),
    );
  }
}
