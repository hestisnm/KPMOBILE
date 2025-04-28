import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kelas_pintar/presentation/pages/sign_up_page.dart';
import 'package:kelas_pintar/presentation/pages/sign_in_page.dart';
import 'package:kelas_pintar/presentation/pages/sign_in_page_guru.dart';
import 'package:kelas_pintar/presentation/pages/sign_up_page_guru.dart';
import 'package:kelas_pintar/presentation/widgets/button_widget.dart';
import 'package:kelas_pintar/presentation/widgets/page_widget.dart';

class Start extends StatefulWidget {
  const Start({super.key});

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: -30).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 600;

        return PageWidget(
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenSize.width * 0.08,
                    vertical: screenSize.height * 0.03,
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: screenSize.height * 0.02),
                      AnimatedBuilder(
                        animation: _animation,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(0, _animation.value),
                            child: child,
                          );
                        },
                        child: Image.asset(
                          'assets/images/happy_koala.png',
                          width: isSmallScreen ? screenSize.width * 0.5 : 300,
                        ),
                      ),
                      SizedBox(height: screenSize.height * 0.02),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenSize.width * 0.05),
                        child: Text(
                          'BELAJAR BERSAMA SUKSES SEMUA',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: isSmallScreen ? 18 : 22,
                            fontWeight: FontWeight.w600,
                            height: 1.3,
                          ),
                        ),
                      ),
                      SizedBox(height: screenSize.height * 0.05),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenSize.width * 0.07),
                        child: Text(
                          'Ayo daftarkan diri anda!',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: isSmallScreen ? 14 : 16,
                            height: 1.4,
                          ),
                        ),
                      ),
                      SizedBox(height: screenSize.height * 0.016),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: ButtonWidget(
                              text: "MURID",
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => const SignUpPage()),
                                );
                              },
                            ),
                          ),
                          SizedBox(width: screenSize.width * 0.03),
                          Flexible(
                            child: ButtonWidget(
                              text: "GURU",
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SignUpPageGuru()),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenSize.height * 0.032),
                      Text(
                        'Atau sudah punya akun?',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: screenSize.height * 0.033),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: ButtonWidget(
                              text: "MURID",
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => const SignInPage()),
                                );
                              },
                            ),
                          ),
                          SizedBox(width: screenSize.width * 0.03),
                          Flexible(
                            child: ButtonWidget(
                              text: "GURU",
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SignInPageGuru()),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Image.asset(
                  'assets/images/wave.png',
                  width: screenSize.width,
                  height: screenSize.height * 0.17,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
