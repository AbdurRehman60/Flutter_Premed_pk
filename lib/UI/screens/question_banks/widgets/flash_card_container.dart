import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants/sized_boxes.dart';

class QbankFlashCardContainer extends StatelessWidget {
  const QbankFlashCardContainer({super.key, required this.icon, required this.activityText, required this.title, required this.subTitle});
  final String icon;
  final String activityText;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,
      clipBehavior: Clip.hardEdge,
      borderRadius: BorderRadius.circular(15),
      color: const Color(0xFFF7F3F5),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            SvgPicture.asset(icon),
            SizedBoxes.horizontal2Px,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activityText,
                  style: GoogleFonts.rubik(
                    fontWeight: FontWeight.bold,
                    fontSize: 6,
                    color: const Color(0x80000000),
                    height: 1.3,
                  ),
                ),
                Text(
                 title,
                  style: GoogleFonts.rubik(
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                    color: const Color(0xFF000000),
                    height: 1.3,
                  ),
                ),
                Text(
                  subTitle,
                  style: GoogleFonts.rubik(
                    fontWeight: FontWeight.normal,
                    fontSize: 10,
                    color: const Color(0xFF000000),
                    height: 1.3,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
