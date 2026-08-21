import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/category_carousel.dart';
import '../widgets/post_list.dart';
import '../widgets/story_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _handleRefresh() async {
    // TODO: وقتی API واقعی وصل شد، اینجا دیتای تازه از سرور بگیر.
    // فعلاً چون دیتا لوکاله فقط یک تاخیر کوچیک شبیه‌سازی می‌کنیم
    // تا افکت Pull-to-refresh درست کار کنه.
    await Future.delayed(const Duration(milliseconds: 600));
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _handleRefresh,
          color: themeData.colorScheme.primary,
          child: CustomScrollView(
            // AlwaysScrollableScrollPhysics لازم است تا حتی وقتی محتوا کوتاه‌تر
            // از صفحه است هم بشود Pull-to-refresh را فعال کرد.
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: [
              // ============================================================
              // HEADER
              // ============================================================
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(32, 16, 32, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Hi, Jonathan!',
                        style: themeData.textTheme.titleLarge,
                      ),
                      const Icon(CupertinoIcons.bell),
                    ],
                  ),
                ),
              ),

              // ============================================================
              // EXPLORE TODAY
              // ============================================================
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(32, 0, 0, 18),
                  child: Text(
                    'Explore today',
                    style: themeData.textTheme.headlineSmall,
                  ),
                ),
              ),

              // ============================================================
              // STORIES
              // ============================================================
              const SliverToBoxAdapter(child: StoryList()),

              const SliverToBoxAdapter(child: SizedBox(height: 16)),

              // ============================================================
              // CATEGORY CAROUSEL
              // ============================================================
              const SliverToBoxAdapter(child: CategoryCarousel()),

              const SliverToBoxAdapter(child: SizedBox(height: 24)),

              // ============================================================
              // POST LIST
              // ------------------------------------------------------------
              // PostList خودش یک Sliver برمی‌گرداند (به‌جای یک ListView
              // تودرتوی shrinkWrap) تا آیتم‌ها واقعاً به‌صورت تنبل (lazy)
              // ساخته شوند. جزئیات دلیل تغییر در widgets/post_list.dart
              // توضیح داده شده.
              // ============================================================
              const PostList(),

              const SliverToBoxAdapter(child: SizedBox(height: 32)),
            ],
          ),
        ),
      ),
    );
  }
}
