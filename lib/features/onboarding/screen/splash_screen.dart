import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:wathiq/features/onboarding/screen/auth_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wathiq/features/theme/app_colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 1500,
      splash: Image.asset("assets/images/splash_logo.png"),
      nextScreen: const AuthScreen(),
      splashTransition: SplashTransition.slideTransition,
      pageTransitionType: PageTransitionType.fade, // try fade first
      backgroundColor: AppColors.primary,
    );
  }
}
