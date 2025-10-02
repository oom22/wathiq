import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: Color.fromARGB(255, 3, 92, 107),
        items: [
          TabItem(icon: FaIcon(FontAwesomeIcons.user), title: 'شخصي'),
          TabItem(icon: FaIcon(FontAwesomeIcons.receipt), title: 'الأملاك'),
          TabItem(icon: Icons.add, title: ''),
          TabItem(icon: FaIcon(FontAwesomeIcons.comments), title: 'مساعد ذكي'),
          TabItem(icon: Icons.category_outlined, title: 'لوحة التحكم'),
        ],
        onTap: (int i) => print('click index=$i'),
      ),
    );
  }
}

//hello
