import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:kelas_pintar/constants/color_constant.dart';
import 'package:kelas_pintar/kuis/senbudKuis.dart';
import 'package:kelas_pintar/presentation/pages/discover_page.dart';
import 'package:kelas_pintar/presentation/pages/kelas/kelas7_page.dart';
import 'package:kelas_pintar/presentation/pages/kelas/kelas8_page.dart';
import 'package:kelas_pintar/presentation/pages/kelas/kelas9_page.dart';
import 'package:kelas_pintar/presentation/pages/navbar.dart';

class MainNavigation extends StatefulWidget {
  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    DiscoverPage(),
    Kelas7Page(),
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: ColorConstant.primary,
        buttonBackgroundColor: ColorConstant.primary,
        animationDuration: Duration(milliseconds: 300),
        index: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: <Widget>[
          Icon(Icons.home, size: 35, color: Colors.white),
          Icon(Icons.book_rounded, size: 35, color: Colors.white),
          Icon(Icons.stacked_bar_chart_sharp, size: 35, color: Colors.white),
          Icon(Icons.person, size: 35, color: Colors.white),
        ],
      ),
      body: _pages[_selectedIndex],
    );
  }
}
