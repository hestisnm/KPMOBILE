import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kelas_pintar/constants/color_constant.dart';
import 'package:kelas_pintar/guru/eboookGuru.dart';
import 'package:kelas_pintar/guru/homePageGuru.dart';
import 'tambah_kuis_page.dart';
import 'nilai_murid_page.dart';
import 'profil_guru_page.dart';

class DashboardGuru extends StatefulWidget {
  @override
  State<DashboardGuru> createState() => _DashboardGuruState();
}

class _DashboardGuruState extends State<DashboardGuru> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePageGuru(),
    TambahKuisPage(),
    BacaEbookGuru(),
    NilaiMuridPage(),
    ProfilGuruPage(),
  ];

  final List<Widget> _navItems = [
    Icon(Icons.home, size: 30),
    Icon(Icons.edit, size: 30),
    Icon(Icons.book_online, size: 30),
    Icon(Icons.bar_chart, size: 30),
    Icon(Icons.person, size: 30),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _pages[_selectedIndex]),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: ColorConstant.primary,
        buttonBackgroundColor: ColorConstant.primary,
        height: 60,
        index: _selectedIndex,
        items: _navItems,
        animationDuration: Duration(milliseconds: 300),
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
