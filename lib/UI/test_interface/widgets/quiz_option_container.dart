import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:premedpk_mobile_app/constants/sized_boxes.dart';

class QuizOptionContainer extends StatelessWidget {
  const QuizOptionContainer({
    super.key,
    required this.optionNumber,
    required this.quizOptionDetails,
    required this.onTap,
  });
  final String quizOptionDetails;
  final String optionNumber;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            width: 1.5,
            color: const Color(0xFFABABAB),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              optionNumber,
              style: GoogleFonts.rubik(
                fontWeight: FontWeight.w800,
                fontSize: 15,
                color: const Color(0xFFEC5863),
              ),
            ),
            SizedBoxes.horizontal12Px,
            Expanded(
              child: Text(
                quizOptionDetails,
                style: GoogleFonts.rubik(
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  color: const Color(0xFF000000),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
