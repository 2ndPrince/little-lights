import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../constants/puzzle_content_registry.dart';
import '../../data/models/story.dart';

/// Full-screen lesson flow shown after the puzzle is completed.
///
/// Steps through 3 lesson scenes (tap-to-advance). After the last scene,
/// navigates to the story's reward screen.
class LessonScreen extends StatefulWidget {
  /// The story whose lesson scenes should be shown.
  final StoryId storyId;

  const LessonScreen({required this.storyId, super.key});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final content = puzzleContentRegistry[widget.storyId]!;
    final paths = content.lessonFlutterPaths;
    final captions = content.lessonCaptions;

    return GestureDetector(
      onTap: _advance,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          fit: StackFit.expand,
          children: [
            // Scene image
            Image.asset(
              paths[_currentIndex],
              fit: BoxFit.cover,
            ),

            // Caption overlay at bottom
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 20,
                ),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Color(0xCC000000), Colors.transparent],
                  ),
                ),
                child: Text(
                  captions[_currentIndex],
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    height: 1.4,
                  ),
                ),
              ),
            ),

            // Progress dots at top
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(paths.length, (i) {
                      final isCurrent = i == _currentIndex;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: isCurrent ? 14 : 8,
                        height: isCurrent ? 14 : 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isCurrent
                              ? Colors.white
                              : Colors.white.withValues(alpha: 0.4),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),

            // Back button (top-left)
            Positioned(
              top: 0,
              left: 0,
              child: SafeArea(
                child: IconButton(
                  onPressed: () {
                    if (_currentIndex > 0) {
                      setState(() => _currentIndex--);
                    } else if (context.canPop()) {
                      context.pop();
                    }
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  color: Colors.white,
                  iconSize: 28,
                  padding: const EdgeInsets.all(16),
                  constraints: const BoxConstraints(
                    minWidth: 80,
                    minHeight: 80,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _advance() {
    final content = puzzleContentRegistry[widget.storyId]!;
    if (_currentIndex < content.lessonFlutterPaths.length - 1) {
      setState(() => _currentIndex++);
    } else {
      context.go('/stories/${widget.storyId.name}/reward');
    }
  }
}
