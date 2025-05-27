import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kelas_pintar/presentation/widgets/page_widget.dart';

class BacaEbook extends StatelessWidget {
  const BacaEbook({super.key});

  @override
  Widget build(BuildContext context) {
    return PageWidget(
      child: Column(
        children: [
          // AppBar manual
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            height: kToolbarHeight,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
                  onPressed: () => Navigator.pop(context),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Pendidikan Pancasila',
                    style: GoogleFonts.poppins(
                      color: Colors.black87,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(width: 48), // ruang kosong untuk menyamakan posisi
              ],
            ),
          ),
          const Divider(height: 1, color: Colors.grey),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Chapter 1',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Broken Ribs',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      '''That summer, while her boy are on vacation with their father, she goes to visit her lover in Berlin.

“You see,” he says, leaning down toward her and lowering his voice so that those passing by won’t hear, “one thing you don’t know about me is that I like to serve.”

It is a surprising thing to hear, coming from a man two meters tall and built like a heavyweight. In fact, he is an amateur boxer. He fought in the ring for many years, until a sudden and unexplainable attack of Schwindel—of vertigo—briefly hospitalized him, turned up a scar in his brain, and put an end to it.

And yet, though he claims that he will never step foot in the ring again and though he is employed as an editor at a highly respected newspaper, she still privately refers to him, both to her friends and to herself, as the German Boxer. It is easier than using his name, which means “little gift from the gods”—because of that''',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        height: 1.6,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
