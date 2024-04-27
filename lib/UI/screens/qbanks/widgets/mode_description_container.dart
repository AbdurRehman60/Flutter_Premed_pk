import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:premedpk_mobile_app/UI/screens/qbanks/test_i.dart';
import 'package:premedpk_mobile_app/providers/questions_proivder.dart';
import 'package:provider/provider.dart';
import '../../../../constants/color_theme.dart';
import '../../../../constants/sized_boxes.dart';
import '../../../../constants/text_theme.dart';

class ModeDescription extends StatelessWidget {
  const ModeDescription({super.key, required this.mode});
  final bool mode;
  @override
  Widget build(BuildContext context) {
    final qPro = Provider.of<QuestionsProvider>(context);
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
            // Image.asset(
            //   // 'assets/icons/TutorModeIcon.png',
            //   height: 48,
            //   width: 48,
            // ),
            SizedBoxes.verticalTiny,
            if (mode)
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                      height: 45, 'assets/images/QuestionMarkDocument.png'),
                  SizedBoxes.verticalTiny,
                  Center(
                    child: Text(
                      'Tutor Mode',
                      style: PreMedTextTheme().heading2.copyWith(
                          color: PreMedColorTheme().primaryColorRed,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
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
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        backgroundColor: PreMedColorTheme().primaryColorRed),
                    onPressed: () {},
                    child: Text(
                      'Start Test',
                      style: PreMedTextTheme().heading2.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                    ),
                  )
                ],
              ),
            if (!mode)
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                      height: 45, 'assets/images/QuestionMarkDocument.png'),
                  SizedBoxes.verticalTiny,
                  Center(
                    child: Text(
                      'Timed Test Mode',
                      style: PreMedTextTheme().heading2.copyWith(
                          color: PreMedColorTheme().primaryColorRed,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
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
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        backgroundColor: PreMedColorTheme().primaryColorRed),
                    onPressed: () {},
                    child: Text(
                      'Start Test',
                      style: PreMedTextTheme().heading2.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
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
