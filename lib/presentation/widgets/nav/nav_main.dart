// lib/app/widgets/nav/navbar-main.dart
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'nav_controller.dart';
import '../../../constants/color_constant.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: NavigationController.instance,
      builder: (context, child) {
        return CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          color: ColorConstant.primary,
          buttonBackgroundColor: ColorConstant.primary,
          height: 60,
          animationDuration: const Duration(milliseconds: 300),
          animationCurve: Curves.easeInOut,
          index: NavigationController.instance.selectedIndex,
          onTap: NavigationController.instance.changeIndex,
          items: const [
            Icon(Icons.home, size: 35, color: Colors.white),
            Icon(Icons.book_rounded, size: 35, color: Colors.white),
            Icon(Icons.stacked_bar_chart_sharp, size: 35, color: Colors.white),
            Icon(Icons.person, size: 35, color: Colors.white),
          ],
        );
      },
    );
  }
}