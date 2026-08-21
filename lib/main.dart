import 'package:blog_club/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'root/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.theme,
      home: const SplashScreen(),
    );
  }
}
