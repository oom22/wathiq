import 'package:flutter/material.dart';
import 'package:wathiq/features/onboarding/screen/auth_screen.dart';
import 'package:wathiq/features/onboarding/screen/splash_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // test
    return MaterialApp(home: SplashScreen());
  }
}
