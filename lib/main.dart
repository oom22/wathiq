import 'package:flutter/material.dart';
import 'package:wathiq/features/ai_assistant/screen/ai_assistant_screen.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:wathiq/features/navigation/screen/navigation_screen.dart';

const apiKey = 'AIzaSyD6Kr-m3v0yAyfoPz6jL1GeC0-hsGEOE_Y';

void main() {
  Gemini.init(apiKey: apiKey);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: NavigationScreen());
  }
}