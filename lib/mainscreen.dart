// lib/main_screen.dart
import 'package:flutter/material.dart';
import 'presentation/widgets/nav/nav_controller.dart';
import 'presentation/widgets/nav/nav_main.dart';
import 'presentation/pages/discover_page.dart';
import 'presentation/pages/kelas/kelas7_page.dart';
import 'presentation/pages/peringkat.dart';
import 'presentation/pages/profil.dart';

// Placeholder pages (you can replace these with your actual pages)
class DiscoverPageTemp extends StatelessWidget {
  const DiscoverPageTemp({super.key});
  @override
  Widget build(BuildContext context) => const Center(child: Text('Discover Page'));
}

class Kelas7PageTemp extends StatelessWidget {
  const Kelas7PageTemp({super.key});
  @override
  Widget build(BuildContext context) => const Center(child: Text('Kelas 7 Page'));
}

class WinPageTemp extends StatelessWidget {
  const WinPageTemp({super.key});
  @override
  Widget build(BuildContext context) => const Center(child: Text('Win Page'));
}

class ProfilTemp extends StatelessWidget {
  const ProfilTemp({super.key});
  @override
  Widget build(BuildContext context) => const Center(child: Text('Profil Page'));
}

// --- End Placeholder Pages ---

class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  
  final List<Widget> _pages = const [
    DiscoverPage(),  
    Kelas7Page(),      
    PeringkatPage(),   
    Profil(),          
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListenableBuilder(
        listenable: NavigationController.instance,
        builder: (context, child) {
          return IndexedStack(
            index: NavigationController.instance.selectedIndex,
            children: _pages,
          );
        },
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}