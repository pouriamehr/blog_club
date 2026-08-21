import 'package:blog_club/screens/article_screen.dart';
import 'package:blog_club/screens/profile_screen.dart';
import 'package:blog_club/screens/search_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/home_screen.dart';
import '../widgets/bottom_navigation.dart';

/// صفحه ریشه اپ: مدیریت تب فعال، نگه‌داشتن state هر صفحه با
/// [IndexedStack]، و ترکیب FAB وسط با نویگیشن‌بار پایین.
///
/// نکته: تب Search قبلاً یک Placeholder خالی بود؛ حالا از
/// [SearchScreen] واقعی استفاده می‌کند (widgets/search_screen.dart).
class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int currentIndex = 0;

  static const List<Widget> pages = [
    HomeScreen(),
    ArticleScreen(title: 'Article'),
    SearchScreen(),
    ProfileScreen(title: 'Profile'),
  ];

  void _onAddPressed() {
    // TODO: منطق واقعی دکمه + (مثلاً باز کردن مودال افزودن پست) را اینجا اضافه کن.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onAddPressed,
        backgroundColor: const Color(0xFF2864E8),
        elevation: 8,
        shape: const CircleBorder(),
        child: const Icon(
          CupertinoIcons.add,
          color: Colors.white,
          size: 32,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigation(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        onAddPressed: _onAddPressed,
      ),
    );
  }
}
