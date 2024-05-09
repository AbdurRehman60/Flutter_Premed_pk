import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/models/question_model.dart';
import 'package:provider/provider.dart';

import '../../../providers/questions_proivder.dart';

class QuizOptionContainer extends StatelessWidget {
  const QuizOptionContainer({
    Key? key,
    required this.optionNumber,
    required this.quizOptionDetails,
    required this.isCorrect,
    required this.onTap,
  }) : super(key: key);

  final String quizOptionDetails;
  final String optionNumber;
  final bool isCorrect;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final selectedOption = Provider.of<QuestionsProvider>(context).selectedOption;
    final correctOption = Provider.of<QuestionsProvider>(context).questions[Provider.of<QuestionsProvider>(context).questionIndex].options.firstWhere((option) => option.isCorrect).optionLetter;
    //final selectedOption = Provider.of<QuestionsProvider>(context).selectedOption;
    final currentQuestionIndex = Provider.of<QuestionsProvider>(context).questionIndex;
    final providerSelectedOption = Provider.of<QuestionsProvider>(context).selectedOptions[currentQuestionIndex.toString()];

    Color? bgColor;
    if (providerSelectedOption != null) {
      if (optionNumber == providerSelectedOption && isCorrect) {
        bgColor = PreMedColorTheme().customCheckboxColor;
      } else if (optionNumber == providerSelectedOption && !isCorrect) {
        bgColor = PreMedColorTheme().primaryColorRed200;
      } else if (optionNumber == correctOption && providerSelectedOption != optionNumber) {
        bgColor = PreMedColorTheme().customCheckboxColor;
      }
    } else if (selectedOption != null) {
      if (optionNumber == selectedOption && isCorrect) {
        bgColor = PreMedColorTheme().customCheckboxColor;
      } else if (optionNumber == selectedOption && !isCorrect) {
        bgColor = PreMedColorTheme().primaryColorRed200;
      } else if (optionNumber == correctOption && selectedOption != optionNumber) {
        bgColor = PreMedColorTheme().customCheckboxColor;
      }
    }

    return GestureDetector(
      onTap: () {
        Provider.of<QuestionsProvider>(context, listen: false).setSelectedOption(optionNumber);
        onTap();
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            width: 1.5,
            color: const Color(0xFFABABAB),
          ),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 6),
              child: Text(
                optionNumber,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
                  color: PreMedColorTheme().black,
                ),
              ),
            ),
            Expanded(
              child: Text(
                quizOptionDetails,
                style: TextStyle(
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
