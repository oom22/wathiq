import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class NavigationController {
  static final NavigationController _instance = NavigationController._internal();
  factory NavigationController() => _instance;

  NavigationController._internal();

  final PersistentTabController controller = PersistentTabController(initialIndex: 2);

  void changeTab(int index) {
    controller.index = index;
  }
}
