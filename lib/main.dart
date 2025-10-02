import 'package:flutter/material.dart';
import 'package:wathiq/features/dashboard/screen/dashboard_screen.dart';
import 'package:wathiq/features/navigation/screen/navigation_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: NavigationScreen());
  }
}
