import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants/sized_boxes.dart';

class ModeContainer extends StatelessWidget {
  const ModeContainer(
      {super.key,
      required this.modeTitle,
      required this.colors,
      required this.onTap, required this.buttonColor});
  final String modeTitle;
  final List<Color> colors;
  final void Function() onTap;
  final Color buttonColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(55),
          color: buttonColor,
        ),
        child: Column(
          children: [
            Text(
              modeTitle,
              style: GoogleFonts.rubik(
                fontWeight: FontWeight.normal,
                fontSize: 14,
                color: const Color(0xFFFFFFFF),
              ),
            ),
            SizedBoxes.verticalMicro,
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: colors),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Free',
                style: GoogleFonts.rubik(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
