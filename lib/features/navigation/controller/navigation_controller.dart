import 'package:flutter/material.dart';
import 'package:wathiq/features/add/screen/add_screen.dart';
import 'package:wathiq/features/ai_assistant/screen/ai_assistant_screen.dart';
import 'package:wathiq/features/belongings/screen/belongings_screen.dart';
import 'package:wathiq/features/dashboard/screen/dashboard_screen.dart';
import 'package:wathiq/features/personal/screen/personal_screen.dart';

class NavigationController {
  int index = 4;
  List<Widget> pages = [
    PersonalScreen(),
    BelongingsScreen(),
    AddScreen(),
    AiAssistantScreen(),
    DashboardScreen(),
  ];
}
