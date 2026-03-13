import 'package:flutter/material.dart';
import '../app/theme/app_colors.dart';
import '../app/theme/app_sizes.dart';
import '../data/models/story.dart';
import '../data/models/story_progress.dart';

/// A tappable card representing a single story, with locked/unlocked/completed states.
class StoryCard extends StatelessWidget {
  final Story story;
  final StoryProgress progress;

  /// Called when tapped; null when locked (card is non-interactive).
  final VoidCallback? onTap;

  const StoryCard({
    super.key,
    required this.story,
    required this.progress,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool locked = !progress.isUnlocked;
    final bool completed = progress.isCompleted;

    return GestureDetector(
      onTap: locked ? null : onTap,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: AppSizes.tapMin,
          minHeight: AppSizes.tapMin,
        ),
        child: Stack(
          children: [
            _CardBody(
              story: story,
              locked: locked,
            ),
            if (locked) const _LockedOverlay(),
            if (completed) const _CompletedBadge(),
          ],
        ),
      ),
    );
  }
}

/// The core card body: thumbnail + title.
class _CardBody extends StatelessWidget {
  final Story story;
  final bool locked;

  const _CardBody({required this.story, required this.locked});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: locked ? AppColors.cardLocked : AppColors.background,
        borderRadius: BorderRadius.circular(AppSizes.radiusCard),
        boxShadow: locked
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.12),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ColorFiltered(
              colorFilter: locked
                  ? const ColorFilter.matrix(<double>[
                      0.2126, 0.7152, 0.0722, 0, 0,
                      0.2126, 0.7152, 0.0722, 0, 0,
                      0.2126, 0.7152, 0.0722, 0, 0,
                      0,      0,      0,      1, 0,
                    ])
                  : const ColorFilter.mode(
                      Colors.transparent,
                      BlendMode.multiply,
                    ),
              child: Image.asset(
                story.thumbnailPath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: AppSizes.spaceS,
              horizontal: AppSizes.spaceM,
            ),
            child: Text(
              story.titleFallback,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: locked
                    ? AppColors.textDark.withValues(alpha: 0.4)
                    : AppColors.textDark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Semi-transparent overlay with a lock icon for locked stories.
class _LockedOverlay extends StatelessWidget {
  const _LockedOverlay();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.18),
          borderRadius: BorderRadius.circular(AppSizes.radiusCard),
        ),
        child: const Center(
          child: Icon(
            Icons.lock_rounded,
            size: 40,
            color: Colors.white70,
          ),
        ),
      ),
    );
  }
}

/// Gold star badge shown in the top-right corner for completed stories.
class _CompletedBadge extends StatelessWidget {
  const _CompletedBadge();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: AppSizes.spaceS,
      right: AppSizes.spaceS,
      child: Container(
        width: 36,
        height: 36,
        decoration: const BoxDecoration(
          color: AppColors.starGold,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: const Icon(
          Icons.star_rounded,
          size: 22,
          color: Colors.white,
        ),
      ),
    );
  }
}
