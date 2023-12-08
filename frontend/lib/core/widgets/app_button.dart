import 'package:flutter/material.dart';
import 'package:frontend/core/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AppButton extends StatelessWidget {
  final VoidCallback onTap;
  final String buttonText;
  final Color textColor;
  final Color buttonColor;

  const AppButton({
    super.key,
    required this.onTap,
    required this.buttonText,
    this.textColor = Colors.white,
    this.buttonColor = purpleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 0,
      ),
      child: FilledButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          backgroundColor: buttonColor,
          minimumSize: const Size(double.infinity, 60),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Text(
          buttonText,
          style: GoogleFonts.inter(
            color: textColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
