
import 'package:flutter/material.dart';

class NavigationController extends ChangeNotifier {
  static final NavigationController _instance = NavigationController._internal();
  factory NavigationController() => _instance;
  NavigationController._internal();

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  void changeIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  // Static access methods for easy use
  static NavigationController get instance => _instance;
  static int get currentIndex => _instance._selectedIndex;
  static void goToHome() => _instance.changeIndex(0);
  static void goToKelas() => _instance.changeIndex(1);
  static void goToProgress() => _instance.changeIndex(2);
  static void goToProfile() => _instance.changeIndex(3);
}