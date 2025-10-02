import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:wathiq/features/add/screen/add_screen.dart';
import 'package:wathiq/features/ai_assistant/screen/ai_assistant_screen.dart';
import 'package:wathiq/features/belongings/screen/belongings_screen.dart';
import 'package:wathiq/features/dashboard/screen/dashboard_screen.dart';
import 'package:wathiq/features/personal/screen/personal_screen.dart';
import 'package:wathiq/features/theme/app_colors.dart';
import '../controller/navigation_controller.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  List<Widget> _buildScreens() {
    return [
    PersonalScreen(),
    BelongingsScreen(),
    AddScreen(),
    AiAssistantScreen(),
    DashboardScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [

      PersistentBottomNavBarItem(
        icon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: const Icon(Icons.person),
        ),
        title: ("شخصي"),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white70,
      ),

      PersistentBottomNavBarItem(
        icon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: const Icon(Icons.receipt_long),
        ),
        title: ("الأملاك"),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white70,
      ),

      PersistentBottomNavBarItem(

        icon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: const Icon(Icons.add,color: Colors.white, size: 29,),
        ),
        activeColorPrimary: AppColors.secondary2,
        inactiveColorPrimary: Colors.white70,
      ),

      PersistentBottomNavBarItem(
        icon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: const Icon(Icons.chat_bubble_outline),
        ),
        title: ("مساعد ذكي"),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white70,
      ),

      PersistentBottomNavBarItem(
        icon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: const Icon(Icons.dashboard),
        ),
        title: ("لوحة التحكم"),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white70,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final navController = NavigationController();

    return PersistentTabView(
      context,
      controller: navController.controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      backgroundColor: AppColors.secondary1,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(20),
        colorBehindNavBar: Colors.white,
      ),
      navBarStyle: NavBarStyle.style15,


        // padding: const EdgeInsets.only(top: 0),
    );
  }
}
