import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kelas_pintar/presentation/pages/sign_up_page.dart';
import 'package:kelas_pintar/presentation/pages/sign_up_page_guru.dart';
import 'package:kelas_pintar/presentation/widgets/button_widget.dart';
import 'package:kelas_pintar/presentation/widgets/page_widget.dart';

class Start extends StatelessWidget {
  const Start({super.key});

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
                      Image.asset(
                        'assets/images/happy_koala.png',
                        width: isSmallScreen ? screenSize.width * 0.5 : 300,
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
                      SizedBox(height: screenSize.height * 0.01),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenSize.width * 0.07),
                        child: Text(
                          'AYO DAFTARKAN DIRI ANDA',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: isSmallScreen ? 14 : 16,
                            height: 1.4,
                          ),
                        ),
                      ),
                      SizedBox(height: screenSize.height * 0.025),
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
                      const Spacer(), // Mendorong wave ke bawah
                    ],
                  ),
                ),
              ),
              // Wave tetap di bawah dan full width
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
