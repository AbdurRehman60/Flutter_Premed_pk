import 'package:flutter_svg/flutter_svg.dart';
import 'package:html/parser.dart' as htmlparser;
import 'package:premedpk_mobile_app/UI/screens/Test%20Interface/report_question.dart';
import 'package:premedpk_mobile_app/UI/screens/Test%20Interface/widgets/analytics.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:provider/provider.dart';
import '../../../models/question_model.dart';
import '../../../providers/question_provider.dart';
import '../../../providers/save_question_provider.dart';
import '../../../providers/update_attempt_provider.dart';
import '../../../providers/user_provider.dart';

class TestInterface extends StatefulWidget {
  const TestInterface({
    super.key,
    required this.deckName,
    required this.attemptId,
    this.startFromQuestion = 0,
  });

  final String attemptId;
  final String deckName;
  final int startFromQuestion;

  @override
  State<TestInterface> createState() => _TestInterfaceState();
}

class _TestInterfaceState extends State<TestInterface> {
  List<Option> _eliminatedOptions = [];

  void _eliminateOptions(List<Option> options) {
    _eliminatedOptions = [options.removeAt(0), options.removeAt(0)];
    setState(() {});
  }

  void _undoElimination(List<Option> options) {
    options.addAll(_eliminatedOptions);
    _eliminatedOptions = [];
    setState(() {});
  }

  int currentQuestionIndex = 0;
  int currentPage = 1;
  String? selectedOption;
  bool optionSelected = false;
  final Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;
  final ValueNotifier<Duration> _durationNotifier =
      ValueNotifier(const Duration(hours: 2));
  bool showNumberLine = false;
  bool isPaused = false;

  int correctAttempts = 0;
  int incorrectAttempts = 0;
  int skippedAttempts = 0;
  int totalTimeTaken = 0;

  List<String?> selectedOptions =
      List<String?>.filled(200, null, growable: true);
  List<bool?> isCorrectlyAnswered =
      List<bool?>.filled(200, null, growable: true);

  @override
  void initState() {
    super.initState();
    currentQuestionIndex = widget.startFromQuestion;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final questionProvider =
          Provider.of<QuestionProvider>(context, listen: false);
      questionProvider.clearQuestions();
      questionProvider.deckName = widget.deckName;
      questionProvider.fetchQuestions(widget.deckName, currentPage);
    });
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _durationNotifier.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!isPaused && _durationNotifier.value.inSeconds > 0) {
        _durationNotifier.value =
            _durationNotifier.value - const Duration(seconds: 1);
      } else if (_durationNotifier.value.inSeconds == 0) {
        timer.cancel();
      }
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$hours:$minutes:$seconds';
  }

  String? parse(String toParse) {
    return htmlparser.parse(toParse).body?.text;
  }

  void updateAttempt() {
    final questionProvider =
        Provider.of<QuestionProvider>(context, listen: false);
    final attemptProvider =
        Provider.of<AttemptProvider>(context, listen: false);

    if (currentQuestionIndex < questionProvider.questions!.length) {
      _stopwatch.stop();
      final timeTaken = _stopwatch.elapsedMilliseconds;
      totalTimeTaken += (timeTaken / 1000).round();

      final question = questionProvider.questions![currentQuestionIndex];
      if (optionSelected) {
        final selectedOptionObj = question.options
            .singleWhere((option) => option.optionLetter == selectedOption);
        if (selectedOptionObj.isCorrect) {
          correctAttempts++;
          isCorrectlyAnswered[currentQuestionIndex] = true;
        } else {
          incorrectAttempts++;
          isCorrectlyAnswered[currentQuestionIndex] = false;
        }
      } else {
        skippedAttempts++;
        isCorrectlyAnswered[currentQuestionIndex] = null;
      }

      print('this is the: $correctAttempts');

      final correctOption =
          question.options.singleWhere((option) => option.isCorrect);

      final attemptData = {
        'attemptId': widget.attemptId,
        'questionId': question.questionId,
        'correctAnswer': correctOption.optionLetter,
        'isCorrect': selectedOption == correctOption.optionLetter,
        'selection': selectedOption,
        'subject': question.subject,
        'timeTaken': timeTaken,
        'attempted': optionSelected,
      };

      attemptProvider.updateAttempt(
        attemptId: widget.attemptId,
        attemptData: attemptData,
        totalTimeTaken: totalTimeTaken,
      );

      selectedOptions[currentQuestionIndex] = selectedOption;
    }
  }

  void nextQuestion() {
    setState(() {
      updateAttempt();

      final questionProvider =
          Provider.of<QuestionProvider>(context, listen: false);

      if (currentQuestionIndex < questionProvider.questions!.length - 1) {
        currentQuestionIndex++;
        selectedOption = null;
        optionSelected = false;

        if (currentQuestionIndex % 10 == 7 && currentPage < 20) {
          currentPage++;
          questionProvider.fetchQuestions(widget.deckName, currentPage);
        }

        selectedOption = selectedOptions[currentQuestionIndex];
        optionSelected = selectedOption != null;

        _stopwatch.reset();
        _stopwatch.start();
      }
    });
  }

  void previousQuestion() {
    setState(() {
      updateAttempt();

      if (currentQuestionIndex > 0) {
        currentQuestionIndex--;
        selectedOption = null;
        optionSelected = false;

        selectedOption = selectedOptions[currentQuestionIndex];
        optionSelected = selectedOption != null;

        _stopwatch.reset();
        _stopwatch.start();
      }
    });
  }

  void selectOption(String optionLetter) {
    setState(() {
      selectedOption = optionLetter;
      optionSelected = true;
      selectedOptions[currentQuestionIndex] = selectedOption;
    });
  }

  bool isBase64(String str) {
    try {
      base64Decode(str.split(',').last);
      return true;
    } catch (e) {
      return false;
    }
  }

  void toggleNumberLine() {
    setState(() {
      showNumberLine = !showNumberLine;
    });
  }

  void _togglePauseResume() {
    setState(() {
      isPaused = !isPaused;
    });
  }

  Future<void> _showFinishDialog() async {
    //final questionProvider = Provider.of<QuestionProvider>(context, listen: false);
    final attemptProvider =
        Provider.of<AttemptProvider>(context, listen: false);
    final unattemptedQuestions = 200 - correctAttempts - incorrectAttempts;

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(child: Text('Confirm!')),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                if (unattemptedQuestions > 0)
                  Text(
                    'You still have $unattemptedQuestions unattempted questions.',
                    style: const TextStyle(fontSize: 15),
                    textAlign: TextAlign.justify,
                  ),
                const Text(
                  'Once you select the ‘Finish’ button, you will receive your score report and will be able to review your attempted answers.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 15),
                ),
                Text(
                  'Please note that once you press the ‘Finish’ button, you will not be able to attempt this paper in Mock Mode again. However, you can review your answers and explanations at any time later.',
                  textAlign: TextAlign.justify,
                  style: PreMedTextTheme()
                      .body
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Finish'),
              onPressed: () {
                final attempted = correctAttempts + incorrectAttempts;
                attemptProvider.updateResult(
                  attemptId: widget.attemptId,
                  attempted: attempted,
                  avgTimeTaken: totalTimeTaken / 200,
                  deckName: widget.deckName,
                  negativesDueToWrong: 0,
                  noOfNegativelyMarked: 0,
                  totalMarks: correctAttempts,
                  totalQuestions: 200,
                  totalTimeTaken: totalTimeTaken,
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Analytics(
                      attemptId: widget.attemptId,
                      correct: correctAttempts,
                      incorrect: incorrectAttempts,
                      skipped: skippedAttempts,
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
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
                  onPressed: previousQuestion,
                ),
              ),
            ),
            title: Center(
              child: Consumer<QuestionProvider>(
                builder: (context, questionProvider, child) {
                  final questionNumber = currentQuestionIndex + 1;
                  return Text(
                    'QUESTION $questionNumber',
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
                    onPressed: nextQuestion,
                  ),
                ),
              ),
            ],
            automaticallyImplyLeading: false,
          ),
        ),
      ),
      body: Consumer<QuestionProvider>(
        builder: (context, questionProvider, child) {
          final questions = questionProvider.questions;
          if (questions == null) {
            return const Center(child: CircularProgressIndicator());
          }
          if (questions.isEmpty) {
            return const Center(child: Text('No questions available'));
          }

          if (currentQuestionIndex >= questions.length) {
            currentQuestionIndex = questions.length - 1;
          }
          if (currentQuestionIndex < 0) {
            currentQuestionIndex = 0;
          }

          final question = questions[currentQuestionIndex];
          final parsedQuestionText = parse(question.questionText);
          _stopwatch.start();

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    parsedQuestionText ?? '',
                    style: PreMedTextTheme().body.copyWith(
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          color: PreMedColorTheme().black,
                        ),
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: _showFinishDialog,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: PreMedColorTheme().tickcolor,
                          foregroundColor: Colors.white,
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.check_circle_outline,
                              color: PreMedColorTheme().white,
                            ),
                            const SizedBox(width: 8),
                            const Text("Finish"),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: _togglePauseResume,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          foregroundColor: Colors.white,
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              isPaused
                                  ? Icons.play_circle_outline
                                  : Icons.pause_circle_outline,
                              color: PreMedColorTheme().white,
                            ),
                            const SizedBox(width: 8),
                            Text(isPaused ? "Resume" : "Pause"),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Consumer<SaveQuestionProvider>(
                        builder: (context, saveQuestionProvider, child) {
                          final String questionId = question.questionId;
                          final String subject = question.subject;
                          final bool isSaved = saveQuestionProvider
                              .isQuestionSaved(questionId, subject);
                          final buttonText = isSaved ? 'Remove' : 'Save';
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.orange,
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                            onPressed: () {
                              if (isSaved) {
                                saveQuestionProvider.removeQuestion(
                                  questionId,
                                  subject,
                                  userProvider.user?.userId ?? '',
                                );
                              } else {
                                saveQuestionProvider.saveQuestion(
                                  questionId,
                                  subject,
                                  userProvider.user?.userId ?? '',
                                );
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                if (buttonText == 'Save')
                                  const Icon(Icons.bookmark_border_rounded)
                                else
                                  const Icon(Icons.bookmark),
                                const SizedBox(width: 8),
                                Text(buttonText),
                              ],
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 16),
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
                          final String currentQuestionId = question.questionId;
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  ReportQuestion(questionId: currentQuestionId),
                            ),
                          );
                        },
                        child: const Text('Report'),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                          backgroundColor: Colors.white,
                          foregroundColor: const Color.fromRGBO(12, 90, 188, 1),
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        onPressed: () {
                          final question = Provider.of<QuestionProvider>(
                                  context,
                                  listen: false)
                              .questions![currentQuestionIndex];
                          _eliminateOptions(question.options);
                        },
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/icons/elimination.svg'),
                            const SizedBox(width: 5),
                            const Text('Elimination Tool'),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                          backgroundColor: const Color.fromRGBO(12, 90, 188, 1),
                          foregroundColor: Colors.white,
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        onPressed: () {
                          final question = Provider.of<QuestionProvider>(
                                  context,
                                  listen: false)
                              .questions![currentQuestionIndex];
                          _undoElimination(question.options);
                        },
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/elimination.svg',
                              color: Colors.white,
                            ),
                            const SizedBox(width: 5),
                            const Text('Exit Elimination'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (question.questionImage != null &&
                      question.questionImage!.isNotEmpty)
                    if (isBase64(question.questionImage!))
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          elevation: 4,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: Image.memory(
                                base64Decode(
                                    question.questionImage!.split(',').last),
                              ),
                            ),
                          ),
                        ),
                      )
                    else if (question.questionImage!.startsWith('http'))
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          elevation: 4,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: Image.network(question.questionImage!),
                            ),
                          ),
                        ),
                      )
                    else
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Material(
                          elevation: 4,
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 16.0),
                              child: Text('Invalid image format'),
                            ),
                          ),
                        ),
                      ),
                  const SizedBox(height: 16),
                  ...question.options.map((option) {
                    final parsedOptionText = parse(option.optionText);
                    final isSelected = option.optionLetter == selectedOption;
                    final borderColor = isSelected
                        ? Colors.blue
                        : PreMedColorTheme().neutral400;

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: GestureDetector(
                        onTap: () => selectOption(option.optionLetter),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: borderColor),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '${option.optionLetter}. ',
                                  style: PreMedTextTheme().body.copyWith(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 15,
                                      color:
                                          PreMedColorTheme().primaryColorRed),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    parsedOptionText ?? '',
                                    style: PreMedTextTheme().body.copyWith(
                                          color: PreMedColorTheme().black,
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showNumberLine)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                height: 55,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount:
                      Provider.of<QuestionProvider>(context).questions!.length,
                  itemBuilder: (context, index) {
                    final bool isAttempted = selectedOptions[index] != null;
                    final bool isCurrent = index == currentQuestionIndex;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          updateAttempt();
                          currentQuestionIndex = index;
                          selectedOption = null;
                          optionSelected = false;

                          if (currentQuestionIndex % 10 == 7 &&
                              currentPage < 20) {
                            currentPage++;
                            Provider.of<QuestionProvider>(context,
                                    listen: false)
                                .fetchQuestions(widget.deckName, currentPage);
                          }

                          selectedOption =
                              selectedOptions[currentQuestionIndex];
                          optionSelected = selectedOption != null;

                          _stopwatch.reset();
                          _stopwatch.start();
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0),
                        child: Center(
                          child: Container(
                            width: 46,
                            height: 46,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(23),
                              border: Border.all(
                                color: isAttempted
                                    ? Colors.transparent
                                    : (isCurrent ? Colors.blue : Colors.white),
                                width: 3,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: isAttempted
                                  ? Colors.blue
                                  : PreMedColorTheme().white,
                              child: Text(
                                '${index + 1}',
                                style: TextStyle(
                                  color:
                                      isAttempted ? Colors.white : Colors.black,
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
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                height: MediaQuery.of(context).size.width > 600 ? 80 : 60,
                width: MediaQuery.of(context).size.width > 600 ? 480 : 360,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 8),
                      child: GestureDetector(
                        onTap: toggleNumberLine,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: PreMedColorTheme().primaryColorRed,
                          ),
                          child: Image.asset(PremedAssets.MENU),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${currentQuestionIndex + 1} of 200",
                          style: PreMedTextTheme().body.copyWith(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: PreMedColorTheme().neutral800,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "ATTEMPTED",
                          style: PreMedTextTheme().body.copyWith(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: PreMedColorTheme().neutral400,
                              ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ValueListenableBuilder<Duration>(
                          valueListenable: _durationNotifier,
                          builder: (context, duration, child) {
                            return Text(
                              _formatDuration(duration),
                              style: PreMedTextTheme().body.copyWith(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: PreMedColorTheme().neutral800,
                                  ),
                            );
                          },
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "TIME LEFT",
                          style: PreMedTextTheme().body.copyWith(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: PreMedColorTheme().neutral400,
                              ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 8),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: PreMedColorTheme().primaryColorRed),
                          color: PreMedColorTheme().white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(PremedAssets.Flask),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
