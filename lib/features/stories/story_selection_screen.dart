import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../app/routes/app_router.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_sizes.dart';
import '../../data/models/story.dart';
import '../../data/models/story_progress.dart';
import '../../data/shared/stories_registry.dart';
import '../../providers/progress_provider.dart';
import '../../widgets/story_card.dart';

/// Displays all available stories as a grid of [StoryCard] widgets.
///
/// Reads [progressProvider] to determine lock/unlock/completed state per story.
class StorySelectionScreen extends ConsumerWidget {
  const StorySelectionScreen({super.key});

  /// Returns the route path for a given [StoryId].
  String _routeFor(StoryId id) {
    switch (id) {
      case StoryId.noah:
        return AppRoutes.noahIntro;
      case StoryId.david:
        return AppRoutes.davidIntro;
      case StoryId.jonah:
        return AppRoutes.jonahIntro;
      case StoryId.adam:
        return AppRoutes.adamIntro;
      case StoryId.moses:
        return AppRoutes.mosesIntro;
      case StoryId.daniel:
        return AppRoutes.danielIntro;
      case StoryId.samaritan:
        return AppRoutes.samaritanIntro;
      case StoryId.zacchaeus:
        return AppRoutes.zacchaeusIntro;
      case StoryId.feeding:
        return AppRoutes.feedingIntro;
      case StoryId.creation:
        return AppRoutes.creationIntro;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progressMap = ref.watch(progressProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.spaceM),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: AppSizes.spaceM,
              crossAxisSpacing: AppSizes.spaceM,
              childAspectRatio: 0.75,
            ),
            itemCount: allStories.length,
            itemBuilder: (context, index) {
              final story = allStories[index];
              final progress = progressMap[story.id] ??
                  StoryProgress(storyId: story.id, isUnlocked: false);

              return StoryCard(
                story: story,
                progress: progress,
                onTap: progress.isUnlocked
                    ? () => context.go(_routeFor(story.id))
                    : null,
              );
            },
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      leading: SizedBox(
        width: AppSizes.tapMin,
        height: AppSizes.tapMin,
        child: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          color: AppColors.textDark,
          iconSize: 32,
          onPressed: () => context.go(AppRoutes.home),
        ),
      ),
      title: const Text(
        'Stories',
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: AppColors.textDark,
        ),
      ),
      centerTitle: true,
    );
  }
}
