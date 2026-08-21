import 'package:flutter/material.dart';

import '../data/app_database.dart';
import '../models/story_data.dart';
import '../painters/story_border_painter.dart';
import '../root/app_theme.dart';

class StoryList extends StatefulWidget {
  const StoryList({super.key});

  @override
  State<StoryList> createState() => _StoryListState();
}

class _StoryListState extends State<StoryList> {
  late final List<StoryData> _stories = AppDatabase.stories;

  /// نکته: مثل PostList، چون دیتای دمو `const` است، وضعیت «دیده‌شده»
  /// بودن استوری‌ها را لوکال نگه می‌داریم. قبلاً هیچ `onTap`ـی روی
  /// استوری‌ها نبود، یعنی این فیلد در مدل عملاً هیچ‌وقت استفاده
  /// نمی‌شد. حالا با تپ روی یک استوری، حلقه دور آن (که با
  /// StoryBorderPainter رسم می‌شود) به حالت "دیده‌شده" تغییر می‌کند.
  late final Set<int> _viewedIds = _stories
      .where((story) => story.isViewed)
      .map((story) => story.id)
      .toSet();

  void _markViewed(int storyId) {
    if (_viewedIds.contains(storyId)) return;
    setState(() {
      _viewedIds.add(storyId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 108,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 32, right: 20),
        physics: const BouncingScrollPhysics(),
        itemCount: _stories.length,
        separatorBuilder: (_, __) {
          return const SizedBox(width: 13);
        },
        itemBuilder: (context, index) {
          final story = _stories[index];
          final isViewed = _viewedIds.contains(story.id);

          return GestureDetector(
            onTap: () => _markViewed(story.id),
            behavior: HitTestBehavior.opaque,
            child: SizedBox(
              width: 68,
              child: Column(
                children: [
                  // ==========================================================
                  // STORY IMAGE
                  // ==========================================================
                  SizedBox(
                    width: 68,
                    height: 68,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned.fill(
                          child: CustomPaint(
                            painter: StoryBorderPainter(isViewed: isViewed),
                            child: Padding(
                              padding: const EdgeInsets.all(6),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.asset(
                                  'assets/stories/${story.imageFileName}',
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const ColoredBox(
                                      color: Color(0xffF4F6FC),
                                      child: Icon(
                                        Icons.broken_image,
                                        color: Color(0xff9BA6B8),
                                        size: 20,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),

                        // ====================================================
                        // STORY ICON
                        // ====================================================
                        Positioned(
                          right: -2,
                          bottom: -2,
                          child: Container(
                            width: 20,
                            height: 20,
                            padding: const EdgeInsets.all(2),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                'assets/icons/${story.iconFileName}',
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const SizedBox.shrink();
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 7),

                  // ==========================================================
                  // STORY NAME
                  // ==========================================================
                  Text(
                    story.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: AppTheme.defaultFontFamily,
                      fontSize: 12,
                      color: Color(0xff6E6E6E),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
