import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final VoidCallback onAddPressed;

  const BottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.onAddPressed,
  });

  static const Color primaryColor = Color(0xFF2864E8);

  static const List<IconData> icons = [
    CupertinoIcons.house,
    CupertinoIcons.book,
    CupertinoIcons.search,
    CupertinoIcons.person,
  ];

  static const List<IconData> activeIcons = [
    CupertinoIcons.house_fill,
    CupertinoIcons.book_fill,
    CupertinoIcons.search,
    CupertinoIcons.person_fill,
  ];

  static const List<String> titles = [
    'Home',
    'Article',
    'Search',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 92,
      child: AnimatedBottomNavigationBar.builder(
        itemCount: icons.length,
        tabBuilder: (index, isActive) {
          final color = isActive ? primaryColor : const Color(0xFF9BA6B8);

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                transitionBuilder: (child, animation) {
                  return ScaleTransition(scale: animation, child: child);
                },
                child: Icon(
                  isActive ? activeIcons[index] : icons[index],
                  key: ValueKey('${index}_$isActive'),
                  size: isActive ? 25 : 23,
                  color: color,
                ),
              ),
              const SizedBox(height: 4),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOut,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                  color: color,
                ),
                child: Text(titles[index]),
              ),
            ],
          );
        },
        activeIndex: currentIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        backgroundColor: Colors.white,
        splashColor: primaryColor.withAlpha(38), // withOpacity منسوخ شده؛ معادلش withAlpha(38) تقریباً 0.15 است
        leftCornerRadius: 26,
        rightCornerRadius: 26,
        elevation: 10,
        onTap: onTap,
      ),
    );
  }
}
