import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class SubjectPercentage extends StatelessWidget {
  const SubjectPercentage({super.key, required this.percentage, required this.subject, required this.textColor});
  final String percentage;
  final String subject;
  final Color textColor;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          percentage,
          style: GoogleFonts.rubik(
            height: 1.3,
            fontWeight: FontWeight.w800,
            fontSize: 20,
            color: textColor,
          ),
        ),
        Text(
          subject,
          style: GoogleFonts.rubik(
            height: 1.3,
            fontWeight: FontWeight.normal,
            fontSize: 10,
            color: textColor,
          ),
        ),
      ],
    );
  }
}
