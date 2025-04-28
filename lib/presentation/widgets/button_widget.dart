import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kelas_pintar/constants/color_constant.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isFullWidth;

  const ButtonWidget(
      {super.key,
      required this.text,
      required this.onPressed,
      this.isFullWidth = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 20), // Jarak di atas button
        TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            minimumSize: isFullWidth ? const Size.fromHeight(50) : null,
            backgroundColor: ColorConstant.primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 14),
          ),
          child: Text(
            text,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
