import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const defaultFontFamily = 'Avener';

  /// رنگ اصلی دیزاین؛ در صورت نیاز عدد دقیق را از Figma جایگزین بفرمایید
  static const primaryColor = Color(0xff2F6BED);

  static const primaryTextColor = Color(0xff0D253C);
  static const secondaryTextColor = Color(0xff2D4379);

  static const backgroundColor = Color(0xffFBFCFF);
  static const mutedTextColor = Color(0xff7B8BB2);

  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: defaultFontFamily,
      scaffoldBackgroundColor: backgroundColor,

      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        onPrimary: Colors.white,
        surface: Colors.white,
        onSurface: primaryTextColor,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          minimumSize: const Size(84, 60),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 8,
          shadowColor: const Color(0x4D2F6BED),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          textStyle: WidgetStateProperty.all(
            const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          foregroundColor: WidgetStateProperty.all(primaryColor),
        ),
      ),

      textTheme: const TextTheme(
        titleLarge: TextStyle(
          color: secondaryTextColor,
          fontWeight: FontWeight.w200,
          fontSize: 18,
        ),
        headlineSmall: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: primaryTextColor,
        ),
        headlineLarge: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 24,
          color: primaryTextColor,
        ),
        headlineMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: primaryTextColor,
        ),
        bodySmall: TextStyle(
          fontWeight: FontWeight.w700,
          color: mutedTextColor,
          fontSize: 10,
        ),
        titleMedium: TextStyle(
          color: primaryTextColor,
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
        bodyMedium: TextStyle(
          color: secondaryTextColor,
          fontSize: 12,
        ),
      ),
    );
  }
}