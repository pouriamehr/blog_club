import 'package:blog_club/data/app_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/post_list.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.title});

  // نکته: قبلاً `required String title` گرفته می‌شد ولی به هیچ فیلدی
  // assign نمی‌شد، یعنی مقدار ورودی همیشه نادیده گرفته می‌شد و AppBar
  // ثابت روی 'Profile' می‌ماند. حالا واقعاً استفاده می‌شود.
  final String title;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final posts = AppDatabase.posts;

    return Scaffold(
      backgroundColor: themeData.scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: themeData.scaffoldBackgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          tooltip: 'Back',
          onPressed: () {
            Navigator.of(context).maybePop();
          },
          icon: const Icon(CupertinoIcons.back),
        ),
        title: Text(
          title,
          style: themeData.textTheme.headlineSmall,
        ),
        actions: [
          IconButton(
            tooltip: 'More options',
            onPressed: () {},
            icon: const Icon(CupertinoIcons.ellipsis),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// کارت پروفایل + نوار آمار
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(24, 16, 24, 40),
                  decoration: BoxDecoration(
                    color: themeData.colorScheme.surface,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 20,
                        // نکته: `colorScheme.onBackground` در Flutter جدید
                        // منسوخ (deprecated) شده؛ معادل درست در Material 3
                        // همان `onSurface` است که بقیه فایل هم استفاده می‌کند.
                        color:
                        themeData.colorScheme.onSurface.withAlpha(13),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
                        child: Row(
                          children: [
                            /// تصویر پروفایل با حلقه آبی
                            Container(
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: themeData.colorScheme.primary,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.asset(
                                  'assets/stories/story_8.jpg',
                                  width: 76,
                                  height: 76,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '@javabean',
                                    style: themeData.textTheme.bodySmall
                                        ?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Jovo Daniel',
                                    style: themeData.textTheme.titleMedium
                                        ?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    'UX Designer',
                                    style: themeData.textTheme.titleMedium
                                        ?.copyWith(
                                      color: themeData.colorScheme.primary,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          'About me',
                          style: themeData.textTheme.headlineMedium,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 8, 24, 44),
                        child: Text(
                          'Madison Blackstone is a director of user experience design, with experience managing global teams.',
                          style: themeData.textTheme.bodyMedium?.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            height: 1.7,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                /// سایه آبی زیر نوار آمار
                Positioned(
                  bottom: 0,
                  left: 96,
                  right: 96,
                  child: Container(
                    height: 32,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 30,
                          color: themeData.colorScheme.primary.withAlpha(102),
                        ),
                      ],
                    ),
                  ),
                ),

                /// نوار آمار بیرون‌زده از لبه پایین کارت
                Positioned(
                  bottom: 6,
                  left: 44,
                  right: 44,
                  child: Container(
                    height: 68,
                    decoration: BoxDecoration(
                      color: themeData.colorScheme.primary,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: const [
                        _StatItem(
                          value: '52',
                          label: 'Post',
                          isSelected: true,
                        ),
                        _StatItem(
                          value: '250',
                          label: 'Following',
                        ),
                        _StatItem(
                          value: '4.5K',
                          label: 'Followers',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 40,),

            /// بخش پست‌ها
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(32),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 20, 12, 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            'My Posts',
                            style: themeData.textTheme.headlineSmall?.copyWith(
                              fontSize: 20,
                            ),
                          ),
                        ),
                        IconButton(
                          tooltip: 'Grid view',
                          onPressed: () {},
                          icon: Icon(
                            CupertinoIcons.square_grid_2x2,
                            color: themeData.colorScheme.primary,
                          ),
                        ),
                        IconButton(
                          tooltip: 'List view',
                          onPressed: () {},
                          icon: const Icon(
                            CupertinoIcons.list_bullet,
                            color: Color(0xff9AA7C7),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // نکته پرفرمنس (کوچک، فعلاً بدون تغییر ساختاری):
                  // این حلقه همه پست‌ها را همزمان می‌سازد چون دیتای دمو
                  // فقط ۳ پست دارد و هزینه‌اش ناچیز است. اگر این صفحه هم
                  // بعداً از یک API با لیست بزرگ پست‌ها تغذیه شد، همان
                  // تکنیک Sliver که در post_list.dart پیاده شد (به‌جای
                  // for-loop داخل SingleChildScrollView) باید اینجا هم
                  // اعمال شود.
                  for (final post in posts) Post(post: post),

                ],
              ),
            ),
            SizedBox(height:150,)
          ],
        ),
      ),
    );
  }
}

/// ستون‌های بخش آمار (Post / Following / Followers)
class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.value,
    required this.label,
    this.isSelected = false,
  });

  final String value;
  final String label;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return Expanded(
      child: Container(
        decoration: isSelected
            ? BoxDecoration(
          color: const Color(0xff2151CD),
          borderRadius: BorderRadius.circular(12),
        )
            : null,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: themeData.colorScheme.onPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: themeData.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w300,
                color: themeData.colorScheme.onPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
