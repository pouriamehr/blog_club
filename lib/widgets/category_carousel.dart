import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../data/app_database.dart';

class CategoryCarousel extends StatelessWidget {
  const CategoryCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = AppDatabase.categories;

    return CarouselSlider.builder(
      itemCount: categories.length,
      itemBuilder: (BuildContext context, int index, int realIndex) {
        final category = categories[index];

        // فاصله یکسان بین همه کارت‌ها
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CategoryCard(
            key: ValueKey(category.id),
            title: category.title,
            imageFileName: category.imageFileName,
          ),
        );
      },
      options: CarouselOptions(
        // ============================================================
        // CAROUSEL SIZE
        // ============================================================
        height: 300,

        // ============================================================
        // CARD WIDTH
        // ============================================================
        viewportFraction: 0.8,

        // ============================================================
        // CENTER CARD
        // ============================================================
        enlargeCenterPage: true,
        enlargeFactor: 0.65,
        enlargeStrategy: CenterPageEnlargeStrategy.zoom,

        // ============================================================
        // START
        // ============================================================
        initialPage: 0,

        // ============================================================
        // SCROLL
        // ============================================================
        scrollDirection: Axis.horizontal,
        enableInfiniteScroll: false,
        autoPlay: false,
        pageSnapping: true,

        // ============================================================
        // SPACING
        // ============================================================
        // با فعال بودن padEnds، آیتم اول و آخر هم می‌توانند
        // به مرکز صفحه بیایند و بزرگ‌نمایی شوند.
        padEnds: true,

        scrollPhysics: const BouncingScrollPhysics(),
      ),
    );
  }
}

// ============================================================================
// CATEGORY CARD
// ============================================================================

class CategoryCard extends StatelessWidget {
  final String title;
  final String imageFileName;

  const CategoryCard({
    super.key,
    required this.title,
    required this.imageFileName,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // ============================================================
          // CATEGORY IMAGE
          // ============================================================
          Image.asset(
            'assets/posts/$imageFileName',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Center(
                child: Icon(
                  Icons.broken_image,
                  color: Colors.white54,
                  size: 40,
                ),
              );
            },
          ),

          // ============================================================
          // DARK GRADIENT
          // ============================================================
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.transparent,
                  Color(0xDD000000),
                ],
                stops: [0.0, 0.45, 1.0],
              ),
            ),
          ),

          // ============================================================
          // CATEGORY TITLE
          // ============================================================
          Positioned(
            left: 24,
            right: 18,
            bottom: 24,
            child: Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: 'Avener',
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                height: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
