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
<<<<<<< HEAD

import '../../providers/user_provider.dart';
import '../screens/global_qbank/widgets/build_error.dart';

class TestInterfacePage extends StatelessWidget {
  const TestInterfacePage({super.key, required this.deckName});

  final String deckName;

  final int currentIndex = 0;
=======
import '../screens/global_qbank/widgets/build_error.dart';

class TestInterfacePage extends StatelessWidget {
   TestInterfacePage({super.key, required this.deckName});
  final String deckName;

  int currentIndex = 0;
>>>>>>> 43a05c43aad6c8ce088d4ecd9acc5da9d40fe66e

  String? parse(String toParse) {
    return htmlParser.parse(toParse).body?.text;
  }

  @override
  Widget build(BuildContext context) {
    final questionPro = Provider.of<QuestionsProvider>(context, listen: false);
<<<<<<< HEAD
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    void nextQuestion() {
      questionPro.getNextQuestion();
    }

    void previousQuestion() {
      questionPro.getPreviousQuestion();
    }

=======
>>>>>>> 43a05c43aad6c8ce088d4ecd9acc5da9d40fe66e
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
<<<<<<< HEAD
                    previousQuestion();
=======
                    questionPro.getPreviousQuestion();
>>>>>>> 43a05c43aad6c8ce088d4ecd9acc5da9d40fe66e
                  },
                ),
              ),
            ),
            title: Center(
              child: Consumer<QuestionsProvider>(
                builder: (context, questionProvider, child) {
                  final questionNumber = questionProvider.questionIndex + 1;
                  final totalQuestions = questionProvider.questions.length;
                  return Text(
                    'QUESTION $questionNumber / $totalQuestions',
                    style: PreMedTextTheme().heading6.copyWith(
                          color: PreMedColorTheme().black,
                          fontWeight: FontWeight.bold,
                        ),
                  );
                },
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
<<<<<<< HEAD
                     nextQuestion();
=======
                      questionPro.getNextQuestion();
>>>>>>> 43a05c43aad6c8ce088d4ecd9acc5da9d40fe66e
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
            .fetchQuestions(deckName),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
<<<<<<< HEAD
            print('errorrrr in fetching ques');
=======
>>>>>>> 43a05c43aad6c8ce088d4ecd9acc5da9d40fe66e
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
<<<<<<< HEAD
                          crossAxisAlignment: CrossAxisAlignment.start,
=======
>>>>>>> 43a05c43aad6c8ce088d4ecd9acc5da9d40fe66e
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
<<<<<<< HEAD
                                    final buttonText =
                                        isSaved ? 'Remove' : 'Save';
=======
                                    final buttonText = isSaved
                                        ? 'Remove Question'
                                        : 'Save Question';
>>>>>>> 43a05c43aad6c8ce088d4ecd9acc5da9d40fe66e
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
<<<<<<< HEAD
                                              questionId,
                                              subject,
                                              userProvider.user?.userId ?? '');
                                        } else {
                                          saveQuestionProvider.saveQuestion(
                                              questionId,
                                              subject,
                                              userProvider.user?.userId ?? '');
                                        }
                                        print(
                                            'User ID of the user is: ${userProvider.user?.userId}');
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          if (buttonText == 'Save')
                                            const Icon(
                                                Icons.bookmark_border_rounded)
                                          else
                                            const Icon(Icons.bookmark),
                                          const SizedBox(width: 8),
                                          Text(buttonText),
                                        ],
                                      ),
=======
                                              questionId, subject);
                                        } else {
                                          saveQuestionProvider.saveQuestion(
                                              questionId, subject);
                                        }
                                      },
                                      child: Text(buttonText),
>>>>>>> 43a05c43aad6c8ce088d4ecd9acc5da9d40fe66e
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
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                    ),
                                    onPressed: () {
                                      final String currentQuestionId =
                                          questions[questionPro.questionIndex]
                                              .questionId;
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => ReportQuestion(
                                            questionId: currentQuestionId,
                                          ),
                                        ),
                                      );
                                    },
<<<<<<< HEAD
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(Icons.report_problem_outlined),
                                        SizedBox(width: 8),
                                        Text('Report'),
                                      ],
                                    ))
                              ],
                            ),
                            SizedBoxes.vertical15px,
=======
                                    child: const Text('Report'))
                              ],
                            ),
                            SizedBoxes.vertical15Px,
>>>>>>> 43a05c43aad6c8ce088d4ecd9acc5da9d40fe66e
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
<<<<<<< HEAD
                            SizedBoxes.vertical15px,
=======
                            SizedBoxes.vertical15Px,
>>>>>>> 43a05c43aad6c8ce088d4ecd9acc5da9d40fe66e
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: questions[questionPro.questionIndex]
                                  .options
                                  .length,
                              itemBuilder: (context, index) {
                                final option =
                                    questions[questionPro.questionIndex]
                                        .options[index];
                                return QuizOptionContainer(
                                  optionNumber: option.optionLetter,
                                  quizOptionDetails:
                                      parse(option.optionText) ?? '',
                                  onTap: () {},
                                  isCorrect: option.isCorrect,
                                );
                              },
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

<<<<<<< HEAD
class NavigationBar extends StatefulWidget {
  const NavigationBar({super.key});

  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }
=======
class NavigationBar extends StatelessWidget {
  const NavigationBar({Key? key});
>>>>>>> 43a05c43aad6c8ce088d4ecd9acc5da9d40fe66e

  @override
  Widget build(BuildContext context) {
    final questionProvider = Provider.of<QuestionsProvider>(context);
    final questionCount = questionProvider.questions.length;
<<<<<<< HEAD
    final Set<int> correctAnswerIndices = {};

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _scrollToCurrentIndex();
    });
=======
>>>>>>> 43a05c43aad6c8ce088d4ecd9acc5da9d40fe66e

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFFFFFFFF),
        elevation: 4,
        clipBehavior: Clip.hardEdge,
        child: Container(
          height: 100,
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
<<<<<<< HEAD
                  controller: _scrollController,
                  itemCount: questionCount,
                  itemBuilder: (context, index) {
                    final question = questionProvider.questions[index];
                    final isAttempted = questionProvider.selectedOptions.containsKey(index.toString());
                    final isCorrect = isAttempted &&
                        question.options.any((option) =>
                        option.isCorrect &&
                            questionProvider.selectedOptions[index.toString()] ==
                                option.optionLetter);

                    if (isCorrect) {
                      correctAnswerIndices.add(index);
                    }

                    return GestureDetector(
                      onTap: () => _onQuestionIndexTap(index, questionProvider),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: CircleAvatar(
                          backgroundColor: correctAnswerIndices.contains(index) ? Colors.blue : Colors.transparent,
=======
                  itemCount: questionCount,
                  itemBuilder: (context, index) {
                    final question = questionProvider.questions[index];
                    final isAttempted = questionProvider.selectedOptions
                        .containsKey(index.toString());
                    final isCorrect = isAttempted &&
                        question.options.any((option) =>
                            option.isCorrect &&
                            questionProvider
                                    .selectedOptions[index.toString()] ==
                                option.optionLetter);
                    return GestureDetector(
                      onTap: () {
                        questionProvider.questionIndex = index;
                        questionProvider.notifyListeners();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: CircleAvatar(
                          backgroundColor: isAttempted
                              ? (isCorrect ? Colors.blue : Colors.red)
                              : Colors.transparent,
>>>>>>> 43a05c43aad6c8ce088d4ecd9acc5da9d40fe66e
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: index == questionProvider.questionIndex
                                    ? Colors.blue
<<<<<<< HEAD
                                    : (index == questionProvider.questionIndex && isCorrect
                                    ? Colors.blue
                                    : (isAttempted && !isCorrect ? Colors.red : Colors.transparent)),
=======
                                    : Colors.transparent,
>>>>>>> 43a05c43aad6c8ce088d4ecd9acc5da9d40fe66e
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                '${index + 1}',
                                style: TextStyle(
<<<<<<< HEAD
                                  color: index == questionProvider.questionIndex && isCorrect ? Colors.white : Colors.black,
=======
                                  color: index == questionProvider.questionIndex
                                      ? Colors.blue
                                      : Colors.black,
>>>>>>> 43a05c43aad6c8ce088d4ecd9acc5da9d40fe66e
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Row(
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
                        '${questionProvider.questionIndex + 1} of ${Provider.of<QuestionsProvider>(context, listen: false).questions.length}',
                        style: GoogleFonts.rubik(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          height: 1.3,
                          color: const Color(0xFF000000),
                        ),
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
                          color: const Color(0xFF000000),
                        ),
                      ),
                      const SizedBox(width: 4),
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
            ],
          ),
        ),
      ),
    );
  }
<<<<<<< HEAD

  void _onQuestionIndexTap(int index, QuestionsProvider provider) {
    provider.questionIndex = index;
    provider.notifyListeners();
    _scrollToCurrentIndex();
  }

  void _scrollToCurrentIndex() {
    if (mounted && _scrollController.hasClients) {
      _scrollController.animateTo(
        (Provider.of<QuestionsProvider>(context, listen: false).questionIndex * 56).toDouble(),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
=======
}
>>>>>>> 43a05c43aad6c8ce088d4ecd9acc5da9d40fe66e
