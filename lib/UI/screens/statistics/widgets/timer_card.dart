import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';

class StatDetailHolder1 extends StatelessWidget {
  const StatDetailHolder1({
    Key? key,
    required this.count,
    required this.details,
    this.preDetails,
    required this.textColor,
  }) : super(key: key);

  final dynamic count;
  final String? preDetails;
  final String details;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final double screenWidth = mediaQuery.size.width;
    final double screenHeight = mediaQuery.size.height;

    double fontSizeCount = 24;
    double fontSizePreDetails = 12;

    if (screenWidth < 600) {
      // Adjust font sizes for smaller screens
      fontSizeCount = 20;
      fontSizePreDetails = 10;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$count',
          style: GoogleFonts.rubik(
            height: 1.3,
            fontWeight: FontWeight.w800,
            fontSize: fontSizeCount,
            color: textColor,
          ),
        ),
        if (preDetails != null)
          Text(
            preDetails ?? '',
            style: GoogleFonts.rubik(
              height: 1.3,
              fontWeight: FontWeight.w800,
              fontSize: fontSizePreDetails,
              color: const Color(0x59000000),
            ),
          ),
        Text(
          details,
          textAlign: TextAlign.center,
          style: GoogleFonts.rubik(
            height: 1.3,
            fontWeight: FontWeight.w600,
            fontSize: 12, // This size remains constant
            color: const Color(0xFF000000),
          ),
        )
      ],
    );
  }
}
