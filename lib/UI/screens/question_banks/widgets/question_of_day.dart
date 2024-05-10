import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html/parser.dart' as htmlparser;
import 'package:premedpk_mobile_app/models/question_of_day_model.dart';
import '../../../../constants/sized_boxes.dart';

class QuestionOfDay extends StatelessWidget {
  const QuestionOfDay({super.key, required this.question});
  final QuestionOfTheDayModel question;

  @override
  Widget build(BuildContext context) {
    final String plainTextQuestion =
        htmlparser.parse(question.question).body!.text;
    return Material(
      elevation: 1,
      clipBehavior: Clip.hardEdge,
      borderRadius: BorderRadius.circular(15),
      color: const Color(0xFFF7F3F5),
      child: Container(
        padding: const EdgeInsets.all(15),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Question of the Day',
              style: GoogleFonts.rubik(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: const Color(0x59000000),
                height: 1.3,
              ),
            ),
            SizedBoxes.vertical15Px,
            Text(
              plainTextQuestion,
              style: GoogleFonts.rubik(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: const Color(0xFFEC5863),
                height: 1.3,
              ),
            ),
            SizedBoxes.vertical15Px,
            Row(
              children: [
                const OptionContainer(option: 'Tap to attempt the question. '),
                const Spacer(),
                SvgPicture.asset(
                  'assets/icons/right-arrow.svg',
                  height: 20,
                  width: 20,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class OptionContainer extends StatelessWidget {
  const OptionContainer({super.key, required this.option});
  final String option;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: Text(
        option,
        style: GoogleFonts.rubik(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF5898FF),
          height: 1.2,
        ),
      ),
    );
  }
}
