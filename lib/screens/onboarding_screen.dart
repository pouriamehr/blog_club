import 'package:blog_club/data/app_database.dart';
import 'package:blog_club/screens/auth_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  final items = AppDatabase.onBoardingItems;

  int currentPage = 0;

  bool get isLastPage => items.isNotEmpty && currentPage == items.length - 1;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToRoot() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => AuthScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    if (items.isEmpty) {
      return Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: _goToRoot,
            child: const Text('ورود'),
          ),
        ),
      );
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: themeData.colorScheme.surface,
        body: Stack(
          children: [
            /// تصویر تمام‌صفحه پشت همه المان‌ها
            Positioned.fill(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: ScaleTransition(
                      scale: Tween<double>(begin: 1.05, end: 1)
                          .animate(animation),
                      child: child,
                    ),
                  );
                },
                child: Image.asset(
                  items[currentPage].imagePath,
                  key: ValueKey<int>(currentPage),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),

            /// گرادیان ملایم بالای صفحه برای خوانایی Status Bar و Skip
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 140,
              child: IgnorePointer(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0x59000000),
                        Color(0x00000000),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            /// محتوای صفحه
            SafeArea(
              bottom: false,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: TextButton(
                        onPressed: _goToRoot,
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: const Color(0x40000000),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text('Skip'),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    height: 260,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 20,
                          color: Color(0x33000000),
                        ),
                      ],
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(32),
                      ),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: PageView.builder(
                            itemCount: items.length,
                            controller: _pageController,
                            onPageChanged: (index) {
                              setState(() {
                                currentPage = index;
                              });
                            },
                            itemBuilder: (context, index) {
                              final item = items[index];

                              return Padding(
                                padding: const EdgeInsets.all(32),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.title,
                                      style: themeData.textTheme.headlineLarge,
                                    ),
                                    const SizedBox(height: 24),
                                    Expanded(
                                      child: SingleChildScrollView(
                                        child: Text(
                                          item.description,
                                          style: (themeData.textTheme.titleLarge
                                              ?.apply(
                                              fontSizeFactor: 0.8) ??
                                              themeData.textTheme
                                                  .bodyMedium)
                                              ?.copyWith(height: 1.7),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        Container(
                          height: 60,
                          padding: const EdgeInsets.fromLTRB(32, 0, 32, 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SmoothPageIndicator(
                                controller: _pageController,
                                count: items.length,
                                effect: ExpandingDotsEffect(
                                  activeDotColor: themeData.colorScheme.primary,
                                  dotColor:
                                  themeData.colorScheme.primary.withAlpha(51),
                                  dotWidth: 8,
                                  dotHeight: 8,
                                ),
                              ),
                              Tooltip(
                                message: isLastPage ? 'شروع' : 'بعدی',
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (isLastPage) {
                                      _goToRoot();
                                    } else {
                                      _pageController.animateToPage(
                                        currentPage + 1,
                                        duration:
                                        const Duration(milliseconds: 500),
                                        curve: Curves.decelerate,
                                      );
                                    }
                                  },
                                  child: Icon(
                                    isLastPage
                                        ? CupertinoIcons.check_mark
                                        : CupertinoIcons.arrow_right,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}