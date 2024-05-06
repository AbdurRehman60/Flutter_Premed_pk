import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:premedpk_mobile_app/UI/test_interface/widgets/material_button.dart';
import 'package:premedpk_mobile_app/UI/test_interface/widgets/quiz_option_container.dart';
import 'package:premedpk_mobile_app/UI/test_interface/widgets/report_question.dart';
import 'package:premedpk_mobile_app/models/question_model.dart';
import 'package:provider/provider.dart';
import 'package:html/parser.dart' as htmlParser;
import '../../constants/constants_export.dart';
import '../../providers/questions_proivder.dart';
import '../../providers/save_question_provider.dart';
import '../Widgets/global_widgets/custom_button.dart';
import '../screens/global_qbank/widgets/build_error.dart';

import 'package:flutter/material.dart'; // Import necessary packages

class TestInterfacePage extends StatefulWidget {
  TestInterfacePage({Key? key, required this.deckName}) : super(key: key);
  final String deckName;

  @override
  _TestInterfacePageState createState() => _TestInterfacePageState();
}

class _TestInterfacePageState extends State<TestInterfacePage> {
  int currentIndex = 0; // Maintain the current index
  String? parse(String toParse) {
    return htmlParser.parse(toParse).body?.text;
  }

  @override
  Widget build(BuildContext context) {
    final questionPro = Provider.of<QuestionsProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
          // Your app bar code here
          ),
      body: FutureBuilder(
        future: Provider.of<QuestionsProvider>(context, listen: false)
            .fetchQuestions(widget.deckName),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            print('!!!');
            return buildError(); // Show error message
          } else {
            print('object');
            final Map<String, dynamic>? data = snapshot.data;
            if (data != null && data['status'] == true) {
              print('???');

              final List<QuestionModel> questions =
                  Provider.of<QuestionsProvider>(context).questions;
              print(questions.length);
              print('dddd ${questions[0].published}');

              // Data loaded successfully
              return PageView.builder(
                itemCount: questions.length,
                controller: PageController(
                  initialPage: currentIndex,
                ),
                itemBuilder: (context, index) {
                  return SingleChildScrollView(
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 15, 16, 0),
                        child: Column(
                          children: [
                            Text(
                              parse(questions[questionPro.questionIndex]
                                      .questionText) ??
                                  '',
                              style: GoogleFonts.rubik(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 17,
                                  color: const Color(0xFF000000)),
                            ),
                            SizedBoxes.vertical15Px,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Consumer<SaveQuestionProvider>(
                                  builder:
                                      (context, saveQuestionProvider, child) {
                                    final String questionId = questionPro
                                        .questions[questionPro.questionIndex]
                                        .questionId;
                                    final String subject = questionPro
                                        .questions[questionPro.questionIndex]
                                        .subject;
                                    final bool isSaved = saveQuestionProvider
                                        .isQuestionSaved(questionId, subject);
                                    final buttonText = isSaved
                                        ? 'Remove Question'
                                        : 'Save Question';
                                    return ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        foregroundColor: Colors.orange,
                                        elevation: 4,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(24),
                                        ),
                                      ),
                                      onPressed: () {
                                        print('Button pressed');
                                        print(
                                            'Question ID: $questionId, Subject: $subject, Status: ${saveQuestionProvider.status}');

                                        if (isSaved) {
                                          print('Removing question...');
                                          saveQuestionProvider.removeQuestion(
                                              questionId, subject);
                                        } else {
                                          print('Saving question...');
                                          saveQuestionProvider.saveQuestion(
                                              questionId, subject);
                                        }
                                      },
                                      child: Text(buttonText),
                                    );
                                  },
                                ),
                                const MaterialOptionButton(
                                  title: 'Elimination Tool',
                                  iconName: 'elimination',
                                  color: Color(0xFF0C5ABC),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.redAccent,
                                      foregroundColor: Colors.white,
                                      elevation: 4,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(24),
                                      ),
                                  ),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const ReportQuestion(),
                                        ),
                                      );
                                    },
                                    child: Text('Report'))
                              ],
                            ),
                            SizedBoxes.vertical15Px,
                            if (questions[questionPro.questionIndex]
                                        .questionImage ==
                                    null ||
                                questions[questionPro.questionIndex]
                                        .questionImage ==
                                    '')
                              const SizedBox()
                            else
                              Material(
                                borderRadius: BorderRadius.circular(10),
                                elevation: 4,
                                clipBehavior: Clip.hardEdge,
                                child: Container(
                                  height: 163,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: MemoryImage(
                                        base64Decode(
                                          questions[questionPro.questionIndex].questionImage!.split(',').last,
                                        ),
                                      ),
                                      fit: BoxFit.cover, // adjust this based on your requirement
                                    ),
                                  ),
                                ),
                              ),
                            SizedBoxes.vertical15Px,
                            Column(
                              children: [
                                QuizOptionContainer(
                                    optionNumber: 'A',
                                    quizOptionDetails: parse(
                                            questions[questionPro.questionIndex]
                                                .options[0]['OptionText']) ??
                                        '',
                                    onTap: () {
                                      questionPro.getNextQuestion();
                                    }),
                                QuizOptionContainer(
                                    optionNumber: 'B',
                                    quizOptionDetails: parse(
                                            questions[questionPro.questionIndex]
                                                .options[1]['OptionText']) ??
                                        '',
                                    onTap: () {
                                      questionPro.getNextQuestion();
                                    }),
                                QuizOptionContainer(
                                    optionNumber: 'C',
                                    quizOptionDetails: parse(
                                            questions[questionPro.questionIndex]
                                                .options[2]['OptionText']) ??
                                        '',
                                    onTap: () {
                                      questionPro.getNextQuestion();
                                    }),
                                QuizOptionContainer(
                                    optionNumber: 'D',
                                    quizOptionDetails: parse(
                                            questions[questionPro.questionIndex]
                                                .options[3]['OptionText']) ??
                                        '',
                                    onTap: () {
                                      questionPro.getNextQuestion();
                                    }),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              // Handle case where data is null or status is false
              return buildError(); // Show error message or empty state
            }
          }
        },
      ),
      bottomNavigationBar: const NavigationBar(),
    );
  }
}

class NavigationBar extends StatelessWidget {
  const NavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final questionProvider = Provider.of<QuestionsProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFFFFFFFF),
        elevation: 4,
        clipBehavior: Clip.hardEdge,
        child: Container(
          height: 55,
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 35,
                width: 35,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xFFEC5863),
                ),
                child: SvgPicture.asset('assets/icons/dots-menu.svg'),
              ),
              Column(
                children: [
                  Text(
                    '${questionProvider.questionIndex} of ${Provider.of<QuestionsProvider>(context, listen: false).questions.length}',
                    style: GoogleFonts.rubik(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        height: 1.3,
                        color: const Color(0xFF000000)),
                  ),
                  Text(
                    'ATTEMPTED',
                    style: GoogleFonts.rubik(
                      fontWeight: FontWeight.w500,
                      fontSize: 8,
                      height: 1.3,
                      color: const Color(0x80000000),
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Text(
                    '45:56',
                    style: GoogleFonts.rubik(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        height: 1.3,
                        color: const Color(0xFF000000)),
                  ),
                  SizedBoxes.horizontalMicro,
                  Text(
                    'TIME LEFT',
                    style: GoogleFonts.rubik(
                      fontWeight: FontWeight.w500,
                      fontSize: 8,
                      height: 1.3,
                      color: const Color(0x80000000),
                    ),
                  )
                ],
              ),
              Container(
                height: 35,
                width: 35,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFEC5863), width: 1),
                ),
                child: SvgPicture.asset('assets/icons/flask-icon.svg'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
