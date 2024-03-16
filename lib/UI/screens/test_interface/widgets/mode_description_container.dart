import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../constants/sized_boxes.dart';

class ModeDescription extends StatelessWidget {
  const ModeDescription({super.key, required this.mode});
  final String mode;
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(24),
      clipBehavior: Clip.hardEdge,
      elevation: 4,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        color: const Color(0xFFFFFFFF),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/icons/TutorModeIcon.png',
              height: 48,
              width: 48,
            ),
            SizedBoxes.verticalTiny,
            if (mode == 'tutorMode')
              Column(
                children: [
                  Center(
                    child: Text(
                      'Tutor Mode',
                      style: GoogleFonts.rubik(
                          color: const Color(0xFF000000),
                          fontWeight: FontWeight.w600,
                          fontSize: 17),
                    ),
                  ),
                  SizedBoxes.verticalTiny,
                  const DescriptionText(
                      descriptionText: 'This paper is NOT timed'),
                  SizedBoxes.verticalTiny,
                  const DescriptionText(
                      descriptionText:
                          'The Correct answer and explanation will be shown instantly once you select any option'),
                  SizedBoxes.verticalTiny,
                  const DescriptionText(
                      descriptionText:
                          "Timer and detailed score report are not available in 'Tutor Mode' and can be accessed in 'Time Test Mode'"),
                  SizedBoxes.verticalMedium,
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00C8AC)),
                    onPressed: () {},
                    child: Text(
                      'Start Attempting Questions',
                      style: GoogleFonts.rubik(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.normal),
                    ),
                  )
                ],
              ),
            if (mode == 'testTimeMode')
              Column(
                children: [
                  Center(
                    child: Text(
                      'Timed Test Mode',
                      style: GoogleFonts.rubik(
                          color: const Color(0xFF000000),
                          fontWeight: FontWeight.w600,
                          fontSize: 17),
                    ),
                  ),
                  SizedBoxes.verticalTiny,
                  const DescriptionText(
                      descriptionText:
                          'Paper will be timed according to the original time given for the paper.'),
                  SizedBoxes.verticalTiny,
                  const DescriptionText(
                      descriptionText:
                          'Scored Report will be shown once you press the ‘Finish’ button.'),
                  SizedBoxes.verticalTiny,
                  const DescriptionText(
                      descriptionText:
                          "Correct answers and detailed explanations will be shown once you press the ‘Finish’ button."),
                  SizedBoxes.verticalMedium,
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00C8AC)),
                    onPressed: () {},
                    child: Text(
                      'Start Test',
                      style: GoogleFonts.rubik(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.normal),
                    ),
                  )
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class DescriptionText extends StatelessWidget {
  const DescriptionText({super.key, required this.descriptionText});
  final String descriptionText;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: SvgPicture.asset(
            'assets/icons/tickIcon.svg',
            colorFilter: const ColorFilter.mode(Colors.green, BlendMode.srcIn),
          ),
        ),
        SizedBoxes.horizontalTiny,
        Expanded(
          child: Text(
            descriptionText,
            style: GoogleFonts.rubik(
              fontWeight: FontWeight.normal,
              height: 1.3,
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }
}
