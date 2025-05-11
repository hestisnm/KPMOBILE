import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kelas_pintar/constants/color_constant.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isFullWidth;
  final Color? backgroundColor;
  final Color? textColor;

  const ButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
    this.isFullWidth = false,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor ?? ColorConstant.primary,
          padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
            side: BorderSide(
              color: ColorConstant.primary,
              width: 2,
            ),
          ),
        ),
        child: Text(
          text,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: textColor ?? Colors.black, // teks warna default hitam
          ),
        ),
      ),
    );
  }
}
