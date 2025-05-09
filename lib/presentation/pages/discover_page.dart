import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kelas_pintar/constants/color_constant.dart';
import 'package:kelas_pintar/presentation/widgets/page_widget.dart';
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
    )..repeat(reverse: true); // Biar tangan melambai bolak balik
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
            const Gap(5),
            _hasilKoinmu(), // Tambahan widget koinmu di sini
            _sapaanUser(
                imageWidth: 200,
                imageHeight: 200), // Tambahan widget sapaanuser di sini
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
            // bagian kiri
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
                // info
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
                  icon: Icon(Icons.notification_add)),
            )
          ],
        ),
      );

  Widget _hasilKoinmu() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFC5BAFF), // warna ungu pastel
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

  Widget _sapaanUser({double imageWidth = 220, double imageHeight = 220}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Stack(
        clipBehavior: Clip.none, // supaya gambar bisa keluar dari Stack
        children: [
          // Container teks
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFC5BAFF),
              borderRadius: BorderRadius.circular(25),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              children: [
                // Kolom teks
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          children: [
                            const TextSpan(text: 'Hallo, '),
                            TextSpan(
                              text: 'Allie!',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
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
                const SizedBox(
                    width: 120), // Tempat gambar, agar Container tetap lebar
              ],
            ),
          ),
          // Gambar tumpuk di atas container, pojok kanan
          Positioned(
            right: 0,
            top: -30, // mengatur posisi keluar dari atas container
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
