import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html/parser.dart' as htmlParser;
import 'package:premedpk_mobile_app/UI/test_interface/widgets/quiz_option_container.dart';
import 'package:premedpk_mobile_app/UI/test_interface/widgets/report_question.dart';
import 'package:premedpk_mobile_app/models/question_model.dart';
import 'package:provider/provider.dart';
import '../../constants/constants_export.dart';
import '../../providers/questions_proivder.dart';
import '../../providers/save_question_provider.dart';
import '../screens/global_qbank/widgets/build_error.dart';

class TestInterfacePage extends StatefulWidget {
 const TestInterfacePage({super.key, required this.deckName});
  final String deckName;

  @override
  _TestInterfacePageState createState() => _TestInterfacePageState();
}

class _TestInterfacePageState extends State<TestInterfacePage> {

  int currentIndex = 0;
  String? parse(String toParse) {
    return htmlParser.parse(toParse).body?.text;
  }

  @override
  Widget build(BuildContext context) {
    final questionPro = Provider.of<QuestionsProvider>(context, listen: false);
    final int currentQuestionNumber = questionPro.questionIndex + 1;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: AppBar(
            backgroundColor: PreMedColorTheme().white,
            leading: Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 2),
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: Center(
                child: IconButton(
                  icon: Icon(Icons.arrow_back,
                      color: PreMedColorTheme().primaryColorRed),
                  onPressed: () {
                    setState(() {
                      Provider.of<QuestionsProvider>(context, listen: false).getPreviousQuestion();
                    });                  },
                ),
              ),
            ),
            title: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'QUESTION $currentQuestionNumber',
                    style: PreMedTextTheme().heading6.copyWith(
                      color: PreMedColorTheme().black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Text(
                  //   '',
                  //   style: PreMedTextTheme().heading6.copyWith(
                  //     color: PreMedColorTheme().black,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                ],
              ),
            ),
            actions: [
              Container(
                margin: const EdgeInsets.all(10),
                width: 40,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(0, 2),
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Center(
                  child: IconButton(
                    icon: Icon(Icons.arrow_forward,
                        color: PreMedColorTheme().primaryColorRed),
                    onPressed: () {
                      setState(() {
                        Provider.of<QuestionsProvider>(context, listen: false).getNextQuestion();
                      });
                    },
                  ),
                ),
              ),
            ],
            automaticallyImplyLeading: false,
          ),
        ),
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
            return buildError(); // Show error message
          } else {
            final Map<String, dynamic>? data = snapshot.data;
            if (data != null && data['status'] == true) {

              final List<QuestionModel> questions =
                  Provider.of<QuestionsProvider>(context).questions;
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
                                  fontWeight: FontWeight.w400,
                                  fontSize: 17,
                                  color: const Color(0xFF000000)),
                            ),
                            SizedBoxes.verticalTiny,
                            Row(
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
                                        if (isSaved) {
                                          saveQuestionProvider.removeQuestion(
                                              questionId, subject);
                                        } else {
                                          saveQuestionProvider.saveQuestion(
                                              questionId, subject);
                                        }
                                      },
                                      child: Text(buttonText),
                                    );
                                  },
                                ),
                                SizedBoxes.horizontalMedium,
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
                                      final String currentQuestionId = questions[questionPro.questionIndex].questionId;
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ReportQuestion(
                                                questionId: currentQuestionId,
                                              ),
                                        ),
                                      );
                                    },

                                    child: const Text('Report')
                                )
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
                                        image: NetworkImage(
                                            questions[questionPro.questionIndex]
                                                .questionImage!)),
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
                  border: Border.all(color: const Color(0xFFEC5863)),
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
