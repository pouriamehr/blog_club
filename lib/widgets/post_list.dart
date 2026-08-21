import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data/app_database.dart';
import '../models/post_data.dart';
import '../root/app_theme.dart';

/// لیست پست‌ها به‌صورت یک Sliver مستقل، طوری که مستقیم داخل
/// `CustomScrollView.slivers` در HomeScreen قرار می‌گیرد.
///
/// نکته پرفرمنسی مهم (قبل/بعد):
/// قبلاً این ویجت یک `ListView.builder` با `shrinkWrap: true` بود که
/// داخل یک `SingleChildScrollView` دیگر (در HomeScreen) قرار داشت.
/// این ترکیب باعث می‌شود Flutter برای اندازه‌گیری ارتفاع لیست مجبور
/// شود همهٔ آیتم‌ها را بلافاصله بسازد — یعنی دقیقاً همان ساخت تنبل
/// (lazy building) که هدف اصلی `ListView.builder` است از بین می‌رود.
/// با تعداد کم آیتم دمو (۳ پست) این مشکل حس نمی‌شود، ولی به محض
/// وصل‌شدن به یک API واقعی با صدها پست، هر بار اسکرول صفحه اصلی همهٔ
/// پست‌ها را می‌سازد و جنک/افت فریم ایجاد می‌کند.
/// با تبدیل این ویجت به یک Sliver واقعی که مستقیماً در همان
/// CustomScrollView بیرونی می‌نشیند، فقط آیتم‌های داخل viewport ساخته
/// می‌شوند.
class PostList extends StatefulWidget {
  const PostList({super.key});

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  late final List<PostData> _posts = AppDatabase.posts;

  /// نکته: چون دیتای دمو از یک لیست `const` می‌آید، برای پیاده‌سازی
  /// قابلیت بوکمارک‌کردن (که قبلاً فقط یک آیکون تزئینی و غیرفعال بود و
  /// هیچ `onTap`ـی نداشت) وضعیتِ بوکمارک‌شده‌ها را جدا نگه می‌داریم.
  /// وقتی به بک‌اند واقعی وصل شدید، به‌جای این Set از پاسخ سرور استفاده کنید.
  late final Set<int> _bookmarkedIds = _posts
      .where((post) => post.isBookmarked)
      .map((post) => post.id)
      .toSet();

  void _toggleBookmark(int postId) {
    setState(() {
      if (_bookmarkedIds.contains(postId)) {
        _bookmarkedIds.remove(postId);
      } else {
        _bookmarkedIds.add(postId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(left: 32, right: 18),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Latest News',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'More',
                    style: TextStyle(color: Color(0xff376AED)),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final post = _posts[index];
              return Post(
                post: post,
                isBookmarked: _bookmarkedIds.contains(post.id),
                onBookmarkToggle: () => _toggleBookmark(post.id),
              );
            },
            childCount: _posts.length,
            // نکته: قبلاً `itemExtent: 142` روی ListView.builder ست شده بود،
            // در حالی که ارتفاع واقعی هر آیتم (Container با height: 150 +
            // margin عمودی 10+8=18) برابر 168 بود. این ناهماهنگی باعث
            // برش‌خوردن/هم‌پوشانی بصری آیتم‌ها هنگام اسکرول می‌شد. اینجا
            // دیگر extent ثابت اشتباه ست نمی‌کنیم و هر آیتم اندازهٔ واقعی
            // خودش را می‌گیرد.
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// POST CARD
// ============================================================================

class Post extends StatelessWidget {
  const Post({
    super.key,
    required this.post,
    this.isBookmarked,
    this.onBookmarkToggle,
  });

  final PostData post;

  /// اگر مقدار داده نشود، از خودِ `post.isBookmarked` استفاده می‌شود —
  /// برای سازگاری با جاهایی مثل ProfileScreen که فقط نمایش می‌دهند و
  /// تعامل بوکمارک لازم ندارند.
  final bool? isBookmarked;
  final VoidCallback? onBookmarkToggle;

  @override
  Widget build(BuildContext context) {
    final bookmarked = isBookmarked ?? post.isBookmarked;

    return Container(
      height: 150,
      margin: const EdgeInsets.fromLTRB(32, 10, 32, 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [BoxShadow(blurRadius: 16, color: Color(0x1a5282FF))],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Image.asset(
              'assets/posts/${post.imageFileName}',
              width: 120,
              height: double.infinity,
              fit: BoxFit.cover,
              // نکته: قبلاً بدون errorBuilder بود؛ اگر اسم فایل عکس اشتباه
              // باشد (مثلاً از یک API واقعی) کل صفحه با خطای رندر می‌شکند.
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 120,
                  color: const Color(0xffF4F6FC),
                  child: const Icon(
                    Icons.broken_image,
                    color: Color(0xff9BA6B8),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.caption,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: AppTheme.defaultFontFamily,
                      color: Color(0xff376AED),
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    post.title,
                    // نکته: قبلاً maxLines نداشت. چون کارت ارتفاع ثابت 150
                    // دارد، یک عنوان بلند (مثلاً از یک API واقعی) می‌توانست
                    // از کارت بیرون بزند (overflow). حالا حداکثر ۲ خط و
                    // بقیه با ellipsis.
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Icon(
                            CupertinoIcons.hand_thumbsup,
                            size: 16,
                            color: Theme.of(context).textTheme.bodyMedium!.color,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            post.likes,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            CupertinoIcons.clock,
                            size: 16,
                            color: Theme.of(context).textTheme.bodyMedium!.color,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            post.time,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      // نکته: قبلاً این آیکون فقط تزئینی بود و هیچ onTap
                      // نداشت — بوکمارک‌کردن عملاً کار نمی‌کرد. حالا با تپ
                      // روی آیکون، وضعیت واقعاً toggle می‌شود.
                      GestureDetector(
                        onTap: onBookmarkToggle,
                        behavior: HitTestBehavior.opaque,
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Icon(
                            bookmarked
                                ? CupertinoIcons.bookmark_fill
                                : CupertinoIcons.bookmark,
                            size: 16,
                            color: Theme.of(context).textTheme.bodyMedium!.color,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
