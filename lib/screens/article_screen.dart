import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ArticleScreen extends StatelessWidget {
  const ArticleScreen({super.key, required this.title});

  // نکته: قبلاً `required String title` گرفته می‌شد ولی به هیچ فیلدی
  // assign نمی‌شد، یعنی مقدار ورودی همیشه نادیده گرفته می‌شد و AppBar
  // ثابت روی 'Article' می‌ماند. حالا واقعاً استفاده می‌شود.
  final String title;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final bodyStyle = themeData.textTheme.bodyMedium?.copyWith(
      fontSize: 14,
      height: 1.9,
    );

    return Scaffold(
      backgroundColor: themeData.colorScheme.surface,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: themeData.colorScheme.surface,
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
      floatingActionButton: Container(
        width: 111,
        height: 48,
        decoration: BoxDecoration(
          color: themeData.colorScheme.primary,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: themeData.colorScheme.primary.withAlpha(128),
            ),
          ],
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            _showSnackBar(context, 'Like button is clicked');
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/icons/Thumbs.svg'),
              const SizedBox(width: 8),
              Text(
                '2.1 K',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: themeData.colorScheme.onPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(32, 16, 32, 22),
                  child: Text(
                    'Four Things Every Woman Needs To Know',
                    style: themeData.textTheme.headlineLarge,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(32, 0, 18, 32),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          'assets/stories/story_9.jpg',
                          width: 48,
                          height: 48,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Richard Gervais',
                              style: themeData.textTheme.titleMedium,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '2m ago',
                              style: themeData.textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        tooltip: 'Share',
                        onPressed: () {},
                        icon: Icon(
                          CupertinoIcons.share,
                          color: themeData.colorScheme.primary,
                        ),
                      ),
                      IconButton(
                        tooltip: 'Bookmark',
                        onPressed: () {},
                        icon: Icon(
                          CupertinoIcons.bookmark,
                          color: themeData.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(32),
                  ),
                  child: Image.asset(
                    'assets/background/single_post.png',
                    width: double.infinity,
                    height: 280,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(32, 32, 32, 16),
                  child: Text(
                    'A man’s sexuality is never your mind responsibility.',
                    style: themeData.textTheme.headlineMedium,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(32, 0, 32, 24),
                  child: Text(
                    'This one got an incredible amount of backlash the last time I said it, so I’m going to say it again: a man’s sexuality is never, ever your responsibility, under any circumstances. Whether it’s the fifth date or your twentieth year of marriage, the correct determining factor for whether or not you have sex with your partner isn’t whether you ought to “take care of him” or “put out” because it’s been a while or he’s really horny — the correct determining factor for whether or not you have sex is whether or not you want to have sex.',
                    textAlign: TextAlign.justify,
                    style: bodyStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(32, 0, 32, 24),
                  child: Text(
                    'Understanding this boundary is not about pushing anyone away or keeping score in a relationship. It is about honesty, mutual respect, and the simple truth that intimacy only has meaning when it is chosen freely. When you act out of obligation or fear, resentment quietly builds in the background, and over time that resentment erodes the very closeness you were trying to protect. A partner who truly cares about you would rather hear an honest “not tonight” than receive a performance that hides how you really feel.',
                    textAlign: TextAlign.justify,
                    style: bodyStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(32, 0, 32, 24),
                  child: Text(
                    'The same principle extends far beyond the bedroom. Your time, your attention, your body, and your energy are yours to give — never debts to be collected. Many women are raised to believe that being “good” means being endlessly accommodating, and that saying no makes them selfish. But a relationship in which one person’s needs always win is not a partnership; it is a pattern of one-sided sacrifice. Learning to say no clearly and kindly is one of the most powerful things you can do for yourself, and, ironically, for the health of the relationship itself.',
                    textAlign: TextAlign.justify,
                    style: bodyStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(32, 0, 32, 32),
                  child: Text(
                    'So here is the takeaway: you are not responsible for managing anyone else’s desires, moods, or expectations at the expense of your own truth. The people who belong in your life will respect your boundaries once they understand them, and the ones who punish you for having them are showing you exactly who they are. Trust yourself, speak honestly, and remember that your “yes” only matters when your “no” is fully allowed.',
                    textAlign: TextAlign.justify,
                    style: bodyStyle,
                  ),
                ),

                /// فضای خالی هم‌اندازه گرادیان تا متن زیر آن پنهان نشود
                const SizedBox(height: 116),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: IgnorePointer(
              child: Container(
                height: 116,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      themeData.colorScheme.surface,
                      themeData.colorScheme.surface.withAlpha(0),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.fixed,
      ),
    );
  }
}
