import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Kelas7Page extends StatelessWidget {
  const Kelas7Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFDAD4FB), // warna ungu muda dari gambar
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          // Gambar Koala
          Image.asset(
            'assets/images/study_koala.png', // Pastikan gambar sesuai path kamu
            width: 80,
            height: 80,
          ),
          const SizedBox(width: 16),
          // Teks
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ayo Mulai Kerjakan Kuismu!",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Pilihlah Mata Pelajaran Yang Kamu Sukai",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
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
