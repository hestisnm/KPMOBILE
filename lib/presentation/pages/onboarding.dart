import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';
import 'package:kelas_pintar/presentation/pages/pilihan.dart';
import 'package:kelas_pintar/presentation/widgets/button_widget.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> _pages = [
    {
      "image": 'assets/images/onboarding1.png',
      "title": "Bingung mau belajar mulai\ndari mana?",
      "subtitle":
          "Tenang, kamu nggak sendiri!\nKelas Pintar hadir untuk bantu kamu belajar\ndengan seru!",
    },
    {
      "image": 'assets/images/onboarding2.png',
      "title": "Latihan soal kapan aja!",
      "subtitle":
          "Pilih kelas, pilih topik, kerjain soal, dan\ndapatkan koinmu!",
    },
    {
      "image": 'assets/images/onboarding3.png',
      "title": "Belajar makin fokus dan asik",
      "subtitle":
          "Mulai sekarang pantau progresmu dan\ncapai target belajar bareng\nKelas Pintar!",
    },
  ];

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Pilihan()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFEBE8FB),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _pages.length,
              onPageChanged: (index) => setState(() => _currentPage = index),
              itemBuilder: (context, index) {
                final page = _pages[index];
                return Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                  child: Column(
                    children: [
                      Center(
                        child: Image.asset(
                          page['image'],
                          width: screenWidth * 0.7,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const Gap(15),
                      Text(
                        page['title'],
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          height: 1.3,
                        ),
                      ),
                      const Gap(10),
                      Text(
                        page['subtitle'],
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const Gap(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _pages.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: _currentPage == index ? 12 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: _currentPage == index
                      ? Colors.deepPurple
                      : Colors.deepPurple.shade200,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          const Gap(30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: ButtonWidget(
              text:
                  _currentPage == _pages.length - 1 ? 'Selesai' : 'Selanjutnya',
              isFullWidth: true,
              onPressed: _nextPage,
            ),
          ),
          const Gap(40),
        ],
      ),
    );
  }
}
