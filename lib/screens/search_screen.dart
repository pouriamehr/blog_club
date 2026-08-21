import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data/app_database.dart';
import '../models/post_data.dart';
import '../widgets/post_list.dart';

/// صفحه جستجو.
///
/// قبلاً این تب (در RootScreen) فقط یک Placeholder خالی بود:
/// `Center(child: Text('Search'))` و هیچ عملکردی نداشت — یعنی یکی از
/// ۴ آیتم نویگیشن پایین اصلاً کار نمی‌کرد.
/// این نسخه یک جستجوی محلی روی عنوان و کپشن پست‌های موجود در
/// [AppDatabase] پیاده‌سازی می‌کند. وقتی به API واقعی وصل شدید، کافی‌ست
/// متد `_search` را با یک فراخوانی شبکه (ترجیحاً با debounce) جایگزین کنید.
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  late List<PostData> _results = AppDatabase.posts;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _search(String query) {
    final normalized = query.trim().toLowerCase();

    setState(() {
      if (normalized.isEmpty) {
        _results = AppDatabase.posts;
        return;
      }

      _results = AppDatabase.posts.where((post) {
        return post.title.toLowerCase().contains(normalized) ||
            post.caption.toLowerCase().contains(normalized);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 16, 32, 8),
              child: Text('Search', style: themeData.textTheme.headlineLarge),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: TextField(
                controller: _controller,
                onChanged: _search,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  hintText: 'Search articles...',
                  prefixIcon: const Icon(CupertinoIcons.search),
                  suffixIcon: _controller.text.isEmpty
                      ? null
                      : IconButton(
                          tooltip: 'Clear',
                          icon: const Icon(CupertinoIcons.clear_circled_solid),
                          onPressed: () {
                            _controller.clear();
                            _search('');
                          },
                        ),
                  filled: true,
                  fillColor: const Color(0xffF4F6FC),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              // نکته: اینجا ListView.builder تنها اسکرول‌شونده است (نه
              // تودرتوی یک SingleChildScrollView دیگر)، پس مشکل
              // shrinkWrap که در post_list.dart توضیح داده شد اینجا وجود
              // ندارد و ساخت آیتم‌ها واقعاً تنبل (lazy) است.
              child: _results.isEmpty
                  ? Center(
                      child: Text(
                        'No articles found',
                        style: themeData.textTheme.bodyMedium,
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.only(top: 8),
                      itemCount: _results.length,
                      itemBuilder: (context, index) {
                        return Post(post: _results[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
