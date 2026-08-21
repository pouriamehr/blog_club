import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2)).then((_) {
      // نکته: اگر کاربر قبل از پایان تایمر از این صفحه خارج شده باشد،
      // ویجت dispose شده و context دیگر معتبر نیست. این چک از کرش
      // و از warning "used after dispose" جلوگیری می‌کند.
      if (!mounted) return;

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/background/splash.png',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            // نکته: Image.asset فرمت SVG را رندر نمی‌کند. اگر فایل واقعاً
            // SVG است باید پکیج flutter_svg را به pubspec.yaml اضافه کنی:
            //   flutter_svg: ^2.0.10+1
            // اگر لوگو در واقع PNG است، فقط پسوند 'LOGO.svg' را به
            // 'LOGO.png' اصلاح کن و این خط را با Image.asset جایگزین کن.
            child: SvgPicture.asset(
              'assets/icons/LOGO.svg',
              width: 100,
            ),
          ),
        ],
      ),
    );
  }
}
