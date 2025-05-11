import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kelas_pintar/constants/color_constant.dart';
import 'package:kelas_pintar/presentation/pages/kelas/kelas7_page.dart';
import 'package:kelas_pintar/presentation/pages/kelas/kelas8_page.dart';
import 'package:kelas_pintar/presentation/pages/kelas/kelas9_page.dart';
import 'package:kelas_pintar/presentation/pages/mapel_kelas7/senibudaya.dart';
import 'package:kelas_pintar/presentation/widgets/page_widget.dart';
import 'package:kelas_pintar/presentation/widgets/button_widget.dart';
import 'package:gap/gap.dart';
import 'dart:math' as math;

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageWidget(
      child: SingleChildScrollView(
        child: Column(
          children: [
            _userInfo(),
            const Gap(6),
            _hasilKoinmu(),
            const Gap(2),
            _sapaanUser(imageWidth: 235, imageHeight: 235),
            const PilihKelasWidget(), // <-- Tambahan di sini
          ],
        ),
      ),
    );
  }

  Widget _userInfo() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: ColorConstant.primary),
                    borderRadius: BorderRadius.circular(50 / 2),
                  ),
                  child: Image.asset('assets/images/user_profile.png'),
                ),
                const Gap(12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Selamat Pagi!',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        AnimatedBuilder(
                          animation: _controller,
                          child: Image.asset(
                            'assets/images/tangan.png',
                            width: 30,
                            height: 30,
                          ),
                          builder: (context, child) {
                            return Transform.rotate(
                              angle: 0.5 *
                                  math.sin(_controller.value * 0.30 * math.pi),
                              child: child,
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                onPressed: () {},
                color: Colors.black,
                icon: const Icon(Icons.notification_add),
              ),
            )
          ],
        ),
      );

  Widget _hasilKoinmu() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFC5BAFF),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Hasil Koinmu',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              Row(
                children: [
                  Text(
                    '1082',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  const Gap(8),
                  Image.asset(
                    'assets/images/koinemas.png',
                    width: 35,
                    height: 35,
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  Widget _sapaanUser({double imageWidth = 260, double imageHeight = 260}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFC5BAFF),
              borderRadius: BorderRadius.circular(25),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                          children: [
                            const TextSpan(text: 'Hallo, '),
                            TextSpan(
                              text: 'Allie!',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Gap(6),
                      Text(
                        'Sudah siap untuk\nmencapai rekor baru?',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(12),
                const SizedBox(width: 130),
              ],
            ),
          ),
          Positioned(
            right: -40,
            top: -56,
            child: SizedBox(
              width: imageWidth,
              height: imageHeight,
              child: Image.asset(
                'assets/images/happy_koala.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================
// WIDGET PILIH KELAS
// ============================
class PilihKelasWidget extends StatelessWidget {
  const PilihKelasWidget({super.key});

  void _navigateToKelas(BuildContext context, int kelas) {
    Navigator.pushNamed(context, '/kelas$kelas');
  }

  Widget _kelasButton(BuildContext context, int kelas) {
    return GestureDetector(
      onTap: () => _navigateToKelas(context, kelas),
      child: Container(
        width: 94,
        height: 52,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(2, 2),
            )
          ],
        ),
        child: Center(
          child: Text(
            '$kelas',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Pilih Kelas',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Flexible(
                flex: 1,
                child: ButtonWidget(
                  text: '7',
                  isFullWidth: true,
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Kelas7Page()),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              Flexible(
                flex: 1,
                child: ButtonWidget(
                  text: '8',
                  isFullWidth: true,
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Kelas8Page()),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              Flexible(
                flex: 1,
                child: ButtonWidget(
                  text: '9',
                  isFullWidth: true,
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Kelas9Page()),
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Text(
            'Mata Pelajaran Yang Sering Anda Pelajari',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          const Gap(12),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PelajaranSeniPage()),
              );
            },
            borderRadius: BorderRadius.circular(24),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFD6C4FF),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Image.asset(
                      'assets/images/seniBudaya.png',
                      width: 60,
                      height: 60,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    'SENI BUDAYA',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),


          
          const Gap(12),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PelajaranSeniPage()),
              );
            },
            borderRadius: BorderRadius.circular(24),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFD6C4FF),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Image.asset(
                      'assets/images/seniBudaya.png',
                      width: 60,
                      height: 60,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    'SENI BUDAYA',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
