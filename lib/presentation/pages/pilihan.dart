import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';
import 'package:kelas_pintar/presentation/pages/start.dart';
import 'package:kelas_pintar/presentation/pages/startMasuk.dart';
import 'package:kelas_pintar/presentation/pages/buat_kode_sekolah.dart'; // Tambahan: Import halaman BuatKodeSekolah
import 'package:kelas_pintar/presentation/widgets/button_widget.dart';

class Pilihan extends StatefulWidget {
  const Pilihan({super.key});

  @override
  State<Pilihan> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<Pilihan> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFEBE8FB),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 90),
            child: Center(
              child: Image.asset(
                'assets/images/onboarding2.png',
                width: screenWidth * 0.7,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const Gap(15),
          Text(
            "Latihan soal kapan aja!",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              height: 1.3,
            ),
          ),
          const Gap(10),
          Text(
            "Pilih kelas, pilih topik, kerjain soal, dan\ndapatkan koinmu!",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              height: 1.3,
            ),
          ),
          const Gap(30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                ButtonWidget(
                  text: "DAFTAR",
                  isFullWidth: true,
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const Start(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),
                ButtonWidget(
                  text: "MASUK",
                  isFullWidth: true,
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const Startmasuk(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 30),
                Text(
                  'Belum punya kode sekolah?',
                  style: GoogleFonts.poppins(fontSize: 12),
                ),
                const SizedBox(height: 5),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BuatKodeSekolahPage(),
                      ),
                    );
                  },
                  child: Text(
                    'Daftarkan Kode Sekolah',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
