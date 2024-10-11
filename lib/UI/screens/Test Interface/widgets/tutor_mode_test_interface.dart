import 'package:flutter_svg/svg.dart';
import 'package:html/parser.dart' as htmlparser;
import 'package:premedpk_mobile_app/UI/screens/Test%20Interface/report_question.dart';
import 'package:premedpk_mobile_app/UI/screens/navigation_screen/main_navigation_screen.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/vaultProviders/premed_provider.dart';
import 'package:provider/provider.dart';
import '../../../../models/question_model.dart';
import '../../../../models/recent_attempts_model.dart';
import '../../../../providers/deck_info_provider.dart';
import '../../../../providers/flashcard_provider.dart';
import '../../../../providers/paper_provider.dart';
import '../../../../providers/question_provider.dart';
import '../../../../providers/recent_atempts_provider.dart';
import '../../../../providers/save_question_provider.dart';
import '../../../../providers/savedquestion_provider.dart';
import '../../../../providers/update_attempt_provider.dart';
import '../../../../providers/user_provider.dart';
import '../../Dashboard_Screen/dashboard_screen.dart';
import '../test_bottom_sheet.dart';
import 'analytics.dart';

class TutorMode extends StatefulWidget {
  const TutorMode({
    super.key,
    required this.deckName,
    required this.attemptId,
    this.startFromQuestion = 0,
    required this.subject,
    required this.isContinuingAttempt,
    this.isReview,
    this.isRecent,
    required this.totalquestions,
    this.questionlist,
    this.buttontext,
    required this.lastdone,
  });

  final String? buttontext;
  final List<String>? questionlist;
  final int totalquestions;
  final bool? isRecent;
  final bool? isReview;
  final bool isContinuingAttempt;
  final String attemptId;
  final String deckName;
  final int startFromQuestion;
  final String subject;
  final String lastdone;

  @override
  State<TutorMode> createState() => _TutorModeState();
}

class _TutorModeState extends State<TutorMode> {
  List<Option> _eliminatedOptions = [];
  bool isLoading = false;

  void _eliminateOptions(List<Option> options) {
    _eliminatedOptions = [options.removeAt(0), options.removeAt(0)];
    setState(() {});
  }

  void _undoElimination(List<Option> options) {
    options.addAll(_eliminatedOptions);
    _eliminatedOptions = [];
    setState(() {});
  }

  Future<void> _showComingSoonPopup(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Coming Soon!"),
          content: const Text(
              "We are working on this, come back later for updates."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  void _startTimer() {
    if (widget.isReview == true) {
      return;
    }

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!isPaused && _durationNotifier.value.inSeconds > 0) {
        _durationNotifier.value =
            _durationNotifier.value - const Duration(seconds: 1);
      } else if (_durationNotifier.value.inSeconds == 0) {
        timer.cancel();
      }
    });
  }

  String? parse(String toParse) {
    return htmlparser.parse(toParse).body?.text;
  }

  void showSnackBarr() {
    final flashcardpro = Provider.of<FlashcardProvider>(context, listen: false);
    final message = flashcardpro.additionStatus == 'Added'
        ? 'Added To FlashCards'
        : 'Removed from FlashCards';
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                message,
                style: PreMedTextTheme().body.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              actions: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 40,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Provider.of<PreMedProvider>(context).isPreMed
                            ? PreMedColorTheme().red
                            : PreMedColorTheme().blue,
                        borderRadius: BorderRadius.circular(15)),
                    child: Center(
                      child: Text(
                        'OK',
                        style: PreMedTextTheme()
                            .body
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ));
  }

  bool isBase64(String str) {
    try {
      base64Decode(str.split(',').last);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> _showFinishDialog() async {
    final attemptProvider =
        Provider.of<AttemptProvider>(context, listen: false);
    final unattemptedQuestions =
        widget.totalquestions - correctAttempts - incorrectAttempts;

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
                  avgTimeTaken: totalTimeTaken / widget.totalquestions,
                  deckName: widget.deckName,
                  negativesDueToWrong: 0,
                  noOfNegativelyMarked: 0,
                  totalMarks: correctAttempts,
                  totalQuestions: widget.totalquestions,
                  totalTimeTaken: totalTimeTaken,
                );
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MainNavigationScreen(),
                  ),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        );
      },
    );
  }

  int currentQuestionIndex = 0;
  int currentPage = 1;
  String? selectedOption;
  bool optionSelected = false;
  final Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;
  bool showNumberLine = false;
  bool isPaused = false;

  int correctAttempts = 0;
  int incorrectAttempts = 0;
  int skippedAttempts = 0;
  int totalTimeTaken = 0;
  bool isPrefetched = false;
  late List<String?> selectedOptions;
  late List<bool?> isCorrectlyAnswered;
  int dotCount = 0;
  Timer? timer;
  String loadingText = "Questions are loading";
  final ValueNotifier<int> _dotCountNotifier = ValueNotifier<int>(0);
  final ValueNotifier<Duration> _durationNotifier =
  ValueNotifier(const Duration(hours: 2));

  @override
  void initState() {
    super.initState();
    startLoadingAnimation();

    print(
        "Navigating to test interface with attemptId: ${widget.attemptId}, deck name: ${widget.deckName}, startFromQuestion: ${widget.startFromQuestion}, isContinueAttempt: ${widget.isContinuingAttempt}");

    selectedOptions =
        List<String?>.filled(widget.totalquestions, null, growable: true);
    isCorrectlyAnswered =
        List<bool?>.filled(widget.totalquestions, null, growable: true);

    if (widget.isReview == true &&
        (widget.lastdone == 'Past Paper' || widget.lastdone == 'Practice')) {
      _fetchAllQuestions().then((_) {
        _loadPastPaperReviewData();
      });
    } else if (widget.isContinuingAttempt == true &&
        (widget.lastdone == 'Past Paper' || widget.lastdone == 'Practice')) {
      _fetchAllQuestions().then((_) {
        _loadPastPaperAttemptData();
      });
    } else if (widget.isReview == true) {
      _fetchAllQuestions().then((_) {
        _loadReviewData();
      });
    } else if (widget.isContinuingAttempt == true) {
      _fetchAllQuestions().then((_) {
        _loadAttemptData();
      });
    } else if (widget.isRecent == true) {
      _fetchAllQuestions().then((_) {
        _loadPreviousSelections();
      });
    } else {
      _clearSelectionsForReattempt();
    }

    if (widget.isReview != true) {
      _startTimer();
    }
  }

  Future<void> _loadPastPaperReviewData() async {
    print("DEBUG: Starting Past Paper/Practice Review Mode");

    final paperProvider = Provider.of<PaperProvider>(context, listen: false);
    final deckInfo = paperProvider.deckInformation?.lastAttempt;

    if (deckInfo != null && deckInfo['attempts'] != null) {
      final attempts = deckInfo['attempts'];

      Set<String> loadedQuestionIds = {};
      int attemptedQuestionCount = 0;

      for (final attempt in attempts) {
        final questionId = attempt['questionId'];
        final questionIndex = getIndexForQuestionId(questionId);

        if (questionIndex != -1) {
          if (loadedQuestionIds.contains(questionId)) {
            print("DEBUG: Skipping duplicate entry for questionId $questionId");
            continue;
          }
          loadedQuestionIds.add(questionId);

          selectedOptions[questionIndex] = attempt['selection'];
          isCorrectlyAnswered[questionIndex] = attempt['isCorrect'];

          if (attempt['attempted'] == true) {
            _highlightAttemptedQuestion(questionIndex);
            attemptedQuestionCount++;
          }
        }
      }

      print(
          "DEBUG: Total attempted questions fetched: $attemptedQuestionCount");

      setState(() {
        currentQuestionIndex = 0;
        print("DEBUG: Starting review from the 0th question.");
      });
    } else {
      setState(() {
        currentQuestionIndex = 0;
      });
    }
  }

  Future<void> _loadPastPaperAttemptData() async {
    print("DEBUG: Continuing Past Paper/Practice Attempt Mode");

    final paperProvider = Provider.of<PaperProvider>(context, listen: false);
    final lastAttempt = paperProvider.deckInformation?.lastAttempt;

    if (lastAttempt != null && lastAttempt['attempts'] != null) {
      final attempts = lastAttempt['attempts'];

      if (attempts.isEmpty) {
        setState(() {
          currentQuestionIndex = 0;
        });
        return;
      }

      Set<String> loadedQuestionIds = {};
      int lastAttemptedIndex = -1;

      for (int i = 0; i < attempts.length; i++) {
        final attempt = attempts[i];
        final questionId = attempt['questionId'];
        final questionIndex = getIndexForQuestionId(questionId);

        if (questionIndex != -1) {
          if (loadedQuestionIds.contains(questionId)) {
            print("DEBUG: Skipping duplicate entry for questionId $questionId");
            continue;
          }
          loadedQuestionIds.add(questionId);

          selectedOptions[questionIndex] = attempt['selection'];
          isCorrectlyAnswered[questionIndex] = attempt['isCorrect'];

          if (attempt['attempted'] == true) {
            _highlightAttemptedQuestion(questionIndex);
            lastAttemptedIndex = i;
          }
        }
      }

      if (lastAttemptedIndex != -1) {
        final lastAttemptedQuestionId =
            attempts[lastAttemptedIndex]['questionId'];
        final lastAttemptedIndexValue =
            getIndexForQuestionId(lastAttemptedQuestionId);

        setState(() {
          currentQuestionIndex =
              lastAttemptedIndexValue != -1 ? lastAttemptedIndexValue : 0;
          print(
              "DEBUG: Continuing from last attempted question at index: $currentQuestionIndex");
        });
      } else {
        setState(() {
          currentQuestionIndex = 0;
          print("DEBUG: No attempted question found, starting from index 0.");
        });
      }
    } else {
      setState(() {
        currentQuestionIndex = 0;
      });
    }
  }

  void _clearSelectionsForReattempt() {
    selectedOptions.fillRange(0, widget.totalquestions, null);
    isCorrectlyAnswered.fillRange(0, widget.totalquestions, null);

    setState(() {
      _fetchInitialQuestions();
    });

    _startTimer();
  }

  Future<void> _fetchInitialQuestions() async {
    setState(() {
      isLoading = true;
    });

    final questionProvider =
        Provider.of<QuestionProvider>(context, listen: false);
    questionProvider.clearQuestions();

    Set<String> loadedQuestionIds = {};

    int startPage = (widget.startFromQuestion) ~/ 10 + 1;

    for (int page = 1; page <= startPage; page++) {
      if (!questionProvider.isPageLoaded(page)) {
        print("DEBUG: Fetching questions from page: $page");
        await questionProvider.fetchQuestions(widget.deckName, page);

        questionProvider.questions
            ?.removeWhere((q) => loadedQuestionIds.contains(q.questionId));
        loadedQuestionIds
            .addAll(questionProvider.questions?.map((q) => q.questionId) ?? []);
      }
    }

    setState(() {
      isLoading = false;
      currentPage = startPage;
    });
  }

  Future<void> _loadAttemptData() async {
    print("DEBUG: Continuing Attempt Mode");

    final deckProvider = Provider.of<DeckProvider>(context, listen: false);
    final lastAttempt = deckProvider.deckInformation?.lastAttempt;

    if (lastAttempt != null && lastAttempt['attempts'] != null) {
      final attempts = lastAttempt['attempts'];

      if (attempts.isEmpty) {
        setState(() {
          currentQuestionIndex = 0;
        });
        return;
      }

      Set<String> loadedQuestionIds = {};
      int lastAttemptedIndex = -1;

      for (int i = 0; i < attempts.length; i++) {
        final attempt = attempts[i];
        final questionId = attempt['questionId'];
        final questionIndex = getIndexForQuestionId(questionId);

        if (questionIndex != -1) {
          if (loadedQuestionIds.contains(questionId)) {
            print("DEBUG: Skipping duplicate entry for questionId $questionId");
            continue;
          }
          loadedQuestionIds.add(questionId);

          selectedOptions[questionIndex] = attempt['selection'];
          isCorrectlyAnswered[questionIndex] = attempt['isCorrect'];

          if (attempt['attempted'] == true) {
            _highlightAttemptedQuestion(questionIndex);
            lastAttemptedIndex = i;
          }
        }
      }

      if (lastAttemptedIndex != -1) {
        final lastAttemptedQuestionId =
            attempts[lastAttemptedIndex]['questionId'];
        final lastAttemptedIndexValue =
            getIndexForQuestionId(lastAttemptedQuestionId);

        setState(() {
          currentQuestionIndex =
              lastAttemptedIndexValue != -1 ? lastAttemptedIndexValue : 0;
          print(
              "DEBUG: Continuing from last attempted question at index: $currentQuestionIndex");
        });
      } else {
        setState(() {
          currentQuestionIndex = 0;
          print("DEBUG: No attempted question found, starting from index 0.");
        });
      }
    } else {
      setState(() {
        currentQuestionIndex = 0;
      });
    }
  }

  Future<void> _loadReviewData() async {
    print("DEBUG: Starting Review Mode");

    final deckProvider = Provider.of<DeckProvider>(context, listen: false);
    final lastAttempt = deckProvider.deckInformation?.lastAttempt;

    if (lastAttempt != null && lastAttempt['attempts'] != null) {
      final attempts = lastAttempt['attempts'];

      Set<String> loadedQuestionIds = {};
      int attemptedQuestionCount = 0;

      for (final attempt in attempts) {
        final questionId = attempt['questionId'];
        final questionIndex = getIndexForQuestionId(questionId);

        if (questionIndex != -1) {
          if (loadedQuestionIds.contains(questionId)) {
            print("DEBUG: Skipping duplicate entry for questionId $questionId");
            continue;
          }
          loadedQuestionIds.add(questionId);

          selectedOptions[questionIndex] = attempt['selection'];
          isCorrectlyAnswered[questionIndex] = attempt['isCorrect'];

          if (attempt['attempted'] == true) {
            _highlightAttemptedQuestion(questionIndex);
            attemptedQuestionCount++;
          }
        }
      }

      print(
          "DEBUG: Total attempted questions fetched: $attemptedQuestionCount");

      setState(() {
        currentQuestionIndex = 0;
        print("DEBUG: Starting review from the 0th question.");
      });
    } else {
      setState(() {
        currentQuestionIndex = 0;
      });
    }
  }

  void _highlightAttemptedQuestion(int questionIndex) {
    setState(() {
      isCorrectlyAnswered[questionIndex] = true;
    });
  }

  int getIndexForQuestionId(String questionId) {
    final questions =
        Provider.of<QuestionProvider>(context, listen: false).questions;

    if (questions != null && questions.isNotEmpty) {
      for (int i = 0; i < questions.length; i++) {
        if (questions[i].questionId == questionId) {
          print("DEBUG: Found questionId $questionId at index $i");
          return i;
        }
      }
    }
    print("DEBUG: questionId $questionId not found in current questions list");
    return -1;
  }

  Future<void> nextQuestion() async {
    if (isLoading) return;

    updateAttempt();

    final questionProvider =
        Provider.of<QuestionProvider>(context, listen: false);
    final deckInfo =
        Provider.of<DeckProvider>(context, listen: false).deckInformation;

    if (currentQuestionIndex < widget.totalquestions - 1) {
      setState(() {
        currentQuestionIndex++;

        print("Current Question Index: $currentQuestionIndex");
        print("Current Page: $currentPage");
        print("isPrefetched: $isPrefetched");

        if (currentQuestionIndex % 10 >= 8 && !isPrefetched) {
          int nextPage = (currentQuestionIndex ~/ 10) + 2;
          print("Prefetching next set of questions from page: $nextPage");
          _fetchNextSetOfQuestions(nextPage);
          isPrefetched = true;
        }

        if (questionProvider.questions!.length > currentQuestionIndex) {
          final question = questionProvider.questions![currentQuestionIndex];
          selectedOption = selectedOptions[currentQuestionIndex];
          optionSelected = selectedOption != null;

          if (widget.isReview == true && selectedOption == null) {
            selectedOption = deckInfo?.getSelectionForQuestion(
                question.questionId, widget.attemptId);
            optionSelected = selectedOption != null;
          }

          _stopwatch.reset();
          if (widget.isReview != true) {
            _stopwatch.start();
          }

          questionProvider.notifyListeners();
        } else {
          print(
              "Error: Attempted to access a question that hasn't been loaded yet.");
        }
        if (currentQuestionIndex % 10 == 0) {
          isPrefetched = false;
          print("Resetting isPrefetched flag after the 10th question.");
        }
      });
    } else {
      print("Error: Attempted to access an invalid question index.");
    }
  }

  Future<void> _fetchNextSetOfQuestions(int nextPage) async {
    setState(() {
      isLoading = true;
    });

    final questionProvider =
        Provider.of<QuestionProvider>(context, listen: false);

    if (!questionProvider.isPageLoaded(nextPage)) {
      print("Fetching questions from page: $nextPage");
      await questionProvider.fetchQuestions(widget.deckName, nextPage);
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> _fetchAllQuestions() async {
    setState(() {
      isLoading = true;
    });

    final questionProvider =
        Provider.of<QuestionProvider>(context, listen: false);
    questionProvider.clearQuestions();

    Set<String> loadedQuestionIds = {};
    int page = 1;
    bool hasMoreQuestions = true;
    int totalQuestions = widget.totalquestions;
    int questionsPerPage = 10;

    print("DEBUG: Fetching all questions until all are loaded");

    while (hasMoreQuestions && (page - 1) * questionsPerPage < totalQuestions) {
      print("DEBUG: Fetching questions from page: $page");
      await questionProvider.fetchQuestions(widget.deckName, page);

      questionProvider.questions
          ?.removeWhere((q) => loadedQuestionIds.contains(q.questionId));

      final fetchedQuestionIds =
          questionProvider.questions?.map((q) => q.questionId) ?? [];

      if (fetchedQuestionIds.isNotEmpty) {
        loadedQuestionIds.addAll(fetchedQuestionIds);
        page++;
      } else {
        hasMoreQuestions = false;
      }
    }

    setState(() {
      isLoading = false;
      currentPage = page - 1;
    });
  }

  Future<void> previousQuestion() async {
    if (isLoading) return;
    updateAttempt();

    final questionProvider =
        Provider.of<QuestionProvider>(context, listen: false);
    final deckInfo =
        Provider.of<DeckProvider>(context, listen: false).deckInformation;

    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;

        if (currentQuestionIndex % 10 == 9 && currentPage > 1) {
          currentPage--;
          _fetchNextSetOfQuestions(currentPage).then((_) {
            if (questionProvider.questions!.length > currentQuestionIndex) {
              final question =
                  questionProvider.questions![currentQuestionIndex];
              selectedOption = selectedOptions[currentQuestionIndex];
              optionSelected = selectedOption != null;

              if (widget.isReview == true && selectedOption == null) {
                selectedOption = deckInfo?.getSelectionForQuestion(
                    question.questionId, widget.attemptId);
                optionSelected = selectedOption != null;
              }

              _stopwatch.reset();
              if (widget.isReview != true) {
                _stopwatch.start();
              }

              questionProvider.notifyListeners();
            } else {
              print(
                  "Error: Attempted to access a question that hasn't been loaded yet.");
            }
          });
        } else if (questionProvider.questions!.length > currentQuestionIndex) {
          final question = questionProvider.questions![currentQuestionIndex];
          selectedOption = selectedOptions[currentQuestionIndex];
          optionSelected = selectedOption != null;

          if (widget.isReview == true && selectedOption == null) {
            selectedOption = deckInfo?.getSelectionForQuestion(
                question.questionId, widget.attemptId);
            optionSelected = selectedOption != null;
          }

          _stopwatch.reset();
          if (widget.isReview != true) {
            _stopwatch.start();
          }

          questionProvider.notifyListeners();
        } else {
          print("Error: Attempted to access an invalid question index.");
        }
      });
    } else if (currentQuestionIndex == 0) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const MainNavigationScreen(),
        ),
      );
    }
  }

  Future<void> _loadQuestionsBetween(
      int startQuestionIndex, int endQuestionIndex) async {
    setState(() {
      isLoading = true;
    });
    final questionProvider =
        Provider.of<QuestionProvider>(context, listen: false);

    int startPage = (startQuestionIndex ~/ 10) + 1;
    int endPage = (endQuestionIndex ~/ 10) + 1;
    for (int page = startPage; page <= endPage; page++) {
      if (!questionProvider.isPageLoaded(page)) {
        await questionProvider.fetchQuestions(widget.deckName, page);
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> _skipToQuestion(int targetIndex) async {
    final questionProvider =
        Provider.of<QuestionProvider>(context, listen: false);

    if (currentQuestionIndex == targetIndex) return;

    if (currentQuestionIndex < targetIndex) {
      await _loadQuestionsBetween(currentQuestionIndex, targetIndex);
    }

    int targetPage = (targetIndex ~/ 10) + 1;

    if (!questionProvider.isPageLoaded(targetPage)) {
      await _fetchNextSetOfQuestions(targetPage);
    }

    setState(() {
      currentQuestionIndex = targetIndex;
      selectedOption = selectedOptions[currentQuestionIndex];
      optionSelected = selectedOption != null;

      if (widget.isRecent == true) {
        final recentProvider =
            Provider.of<RecentAttemptsProvider>(context, listen: false);
        final List<RecentAttempt> recentAttempts =
            recentProvider.recentAttempts;

        final recentAttempt = recentAttempts.firstWhere(
          (attempt) => attempt.id == widget.attemptId,
          orElse: () => RecentAttempt(attempts: Attempts(attempts: [])),
        );

        if (recentAttempt.attempts != null) {
          final question = questionProvider.questions![currentQuestionIndex];

          final recentSelection = recentAttempt.attempts!.attempts!
              .firstWhere(
                (attempt) => attempt.questionId == question.questionId,
                orElse: () =>
                    AttemptofQuestions(questionId: question.questionId),
              )
              .selection;

          selectedOption =
              recentSelection ?? selectedOptions[currentQuestionIndex];
          optionSelected = selectedOption != null;
        }
      } else if (widget.isContinuingAttempt) {
        final deckProvider = Provider.of<DeckProvider>(context, listen: false);
        final deckInfo = deckProvider.deckInformation;

        if (deckInfo != null && deckInfo.lastAttempt.isNotEmpty) {
          final lastAttempt = deckInfo.lastAttempt;

          final question = questionProvider.questions![currentQuestionIndex];

          final continuingSelection = lastAttempt['attempts']!.firstWhere(
            (attempt) => attempt['questionId'] == question.questionId,
            orElse: () => {},
          )['selection'];

          selectedOption =
              continuingSelection ?? selectedOptions[currentQuestionIndex];
          optionSelected = selectedOption != null;
        }
      } else if (widget.isReview == true) {
        final deckProvider = Provider.of<DeckProvider>(context, listen: false);
        final deckInfo = deckProvider.deckInformation;
        if (deckInfo != null && deckInfo.lastAttempt.isNotEmpty) {
          final lastAttempt = deckInfo.lastAttempt;

          final question = questionProvider.questions![currentQuestionIndex];

          final reviewSelection = lastAttempt['attempts']!.firstWhere(
            (attempt) => attempt['questionId'] == question.questionId,
            orElse: () => {},
          )['selection'];

          selectedOption =
              reviewSelection ?? selectedOptions[currentQuestionIndex];
          optionSelected = selectedOption != null;
        }
      }

      _stopwatch.reset();
      if (widget.isReview != true) {
        _stopwatch.start();
      }

      questionProvider.notifyListeners();
    });
  }

  Future<void> _loadPreviousSelections() async {
    if (widget.isRecent == true) {
      print("DEBUG: Recent attempt mode activated");

      final recentProvider =
          Provider.of<RecentAttemptsProvider>(context, listen: false);
      final List<RecentAttempt> recentAttempts = recentProvider.recentAttempts;

      final recentAttempt = recentAttempts.firstWhere(
        (attempt) => attempt.id == widget.attemptId,
        orElse: () => RecentAttempt(attempts: Attempts(attempts: [])),
      );

      if (recentAttempt.attempts != null &&
          recentAttempt.attempts!.attempts != null &&
          recentAttempt.attempts!.attempts!.isNotEmpty) {
        final allAttempts = recentAttempt.attempts!.attempts!;
        final lastAttemptedQuestionId = allAttempts.last.questionId;
        print("Last Attempted Question ID: $lastAttemptedQuestionId");

        int startQuestionIndex =
            getIndexForQuestionId(lastAttemptedQuestionId ?? '');

        print(
            "startQuestionIndex calculated by getIndexForQuestionId: $startQuestionIndex");

        if (startQuestionIndex == -1) {
          print("Invalid startQuestionIndex. Fallback to 0.");
          startQuestionIndex = 0;
        }

        final endQuestionIndex = allAttempts.length - 1;

        await _loadQuestionsBetween(startQuestionIndex, endQuestionIndex);

        for (final attempt in allAttempts) {
          final int questionIndex =
              getIndexForQuestionId(attempt.questionId ?? '');
          if (questionIndex != -1) {
            print("Processing question at index: $questionIndex");
            selectedOptions[questionIndex] = attempt.selection;
            isCorrectlyAnswered[questionIndex] = attempt.isCorrect;

            if (questionIndex == currentQuestionIndex) {
              selectedOption = attempt.selection;
              optionSelected = selectedOption != null;
            }
          }
        }

        setState(() {
          currentQuestionIndex = startQuestionIndex;
          print("Set currentQuestionIndex to start from $startQuestionIndex");
        });
      } else {
        print("No previous attempts found for Recent mode");
        setState(() {
          currentQuestionIndex = 0;
        });
      }
    } else if (widget.isContinuingAttempt) {
      _loadAttemptData();
    } else if (widget.isReview == true) {
      _loadReviewData();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _durationNotifier.dispose();
    _stopwatch.stop();
    timer?.cancel();
    _dotCountNotifier.dispose();

    super.dispose();
  }

  void updateAttempt() {
    if (widget.isReview == true) {
      return;
    }

    final questionProvider =
        Provider.of<QuestionProvider>(context, listen: false);
    final attemptProvider =
        Provider.of<AttemptProvider>(context, listen: false);

    if (currentQuestionIndex < widget.totalquestions) {
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

  Set<int> loadedPages = {};

  void selectOption(String optionLetter) {
    if (widget.isReview != true && !optionSelected) {
      setState(() {
        selectedOption = optionLetter;
        optionSelected = true;
        selectedOptions[currentQuestionIndex] = selectedOption;
      });
    }
  }

  void restart() {
    setState(() {
      currentQuestionIndex = 0;
      selectedOptions =
          List<String?>.filled(widget.totalquestions, null, growable: true);
      isCorrectlyAnswered =
          List<bool?>.filled(widget.totalquestions, null, growable: true);
      _stopwatch.reset();
      _durationNotifier.value = const Duration(hours: 2);
      _timer?.cancel();
      if (widget.isReview != true) {
        _startTimer();
      }
    });
  }
  void startLoadingAnimation() {
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      _dotCountNotifier.value = (_dotCountNotifier.value + 1) % 4; 
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final questionProvider = Provider.of<QuestionProvider>(context, listen: false);
    final questions = questionProvider.questions;

    if (isLoading || questions == null || questions.isEmpty) {
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
                    icon: Icon(
                      Icons.arrow_back,
                      color: Provider.of<PreMedProvider>(context).isPreMed
                          ? PreMedColorTheme().primaryColorRed
                          : PreMedColorTheme().blue,
                    ),
                    onPressed: previousQuestion,
                  ),
                ),
              ),
              title: const Text('Loading...'),
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
                      icon: Icon(
                        Icons.arrow_forward,
                        color: Provider.of<PreMedProvider>(context).isPreMed
                            ? PreMedColorTheme().primaryColorRed
                            : PreMedColorTheme().blue,
                      ),
                      onPressed: nextQuestion,
                    ),
                  ),
                ),
              ],
              automaticallyImplyLeading: false,
            ),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              const SizedBox(height: 16),
              ValueListenableBuilder<int>(
                valueListenable: _dotCountNotifier,
                builder: (context, dotCount, child) {
                  return Text(
                    "Questions are loading${'.' * dotCount}", 
                    style: const TextStyle(fontSize: 16),
                  );
                },
              ),
            ],
          ),
        ),
      );
    }

    final question = questions[currentQuestionIndex];

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
                      color: Provider.of<PreMedProvider>(context).isPreMed
                          ? PreMedColorTheme().primaryColorRed
                          : PreMedColorTheme().blue),
                  onPressed: () {
                    setState(() {
                      previousQuestion();
                    });
                  },
                ),
              ),
            ),
            title: Center(
              child: Text(
                'QUESTION ${currentQuestionIndex + 1}',
                style: PreMedTextTheme().heading6.copyWith(
                      color: PreMedColorTheme().black,
                      fontWeight: FontWeight.bold,
                    ),
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
                        color: Provider.of<PreMedProvider>(context).isPreMed
                            ? PreMedColorTheme().primaryColorRed
                            : PreMedColorTheme().blue),
                    onPressed: nextQuestion,
                  ),
                ),
              ),
            ],
            automaticallyImplyLeading: false,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                parse(question.questionText) ?? '',
                style: PreMedTextTheme().body.copyWith(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: PreMedColorTheme().black,
                    ),
              ),
              Row(
                children: [
                  Consumer2<SaveQuestionProvider, SavedQuestionsProvider>(
                    builder: (context, saveQuestionProvider,
                        savedQuestionsProvider, child) {
                      final String questionId = question.questionId;
                      final String subject = question.subject;
                      final bool isSaved = savedQuestionsProvider
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
                        onPressed: () async {
                          if (isSaved) {
                            print('isSaved');
                            await saveQuestionProvider.removeQuestion(
                              questionId,
                              widget.subject,
                              userProvider.user?.userId ?? '',
                            );
                            savedQuestionsProvider.getSavedQuestions(
                                userId: userProvider.user?.userId ?? '');
                          } else {
                            print('Removed');
                            await saveQuestionProvider.saveQuestion(
                              questionId,
                              widget.subject,
                              userProvider.user?.userId ?? '',
                            );
                            savedQuestionsProvider.getSavedQuestions(
                                userId: userProvider.user?.userId ?? '');
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
                      final question =
                          Provider.of<QuestionProvider>(context, listen: false)
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
                      final question =
                          Provider.of<QuestionProvider>(context, listen: false)
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
                final isCorrect = option.isCorrect;
                final borderColor = isSelected
                    ? (isCorrect ? Colors.green : Colors.red)
                    : (optionSelected && isCorrect
                        ? Colors.green
                        : PreMedColorTheme().neutral400);
                final color = isSelected
                    ? (isCorrect
                        ? Colors.greenAccent
                        : PreMedColorTheme().primaryColorRed200)
                    : (optionSelected && isCorrect
                        ? Colors.greenAccent
                        : PreMedColorTheme().white);

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: GestureDetector(
                    onTap: () => selectOption(option.optionLetter),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: borderColor),
                              borderRadius: BorderRadius.circular(8),
                              color: color),
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
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        parsedOptionText ?? '',
                                        style: PreMedTextTheme().body.copyWith(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                              color: PreMedColorTheme().black,
                                            ),
                                      ),
                                      SizedBoxes.verticalTiny,
                                      if (optionSelected)
                                        ExplanationButton(
                                          isCorrect: isCorrectlyAnswered[
                                              currentQuestionIndex],
                                          explanationText: parse(option
                                                      .explanationText ??
                                                  'Refer to the explanation given at the bottom of the screen') ??
                                              '',
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
              if (optionSelected)
                Container(
                  margin: const EdgeInsets.only(top: 8.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: PreMedColorTheme().neutral400),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Explanation',
                        style: PreMedTextTheme().body.copyWith(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      SizedBoxes.verticalMedium,
                      Column(
                        children: [
                          Text(
                            textAlign: TextAlign.justify,
                            parse(question.explanationText ?? '') ?? '',
                            style: PreMedTextTheme().body.copyWith(
                                  color: PreMedColorTheme().black,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
                height: 55,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.buttontext == 'Attempt 5 Questions for Free'
                      ? 5
                      : widget.totalquestions,
                  itemBuilder: (context, index) {
                    final bool isAttempted = selectedOptions[index] != null;
                    final bool isCurrent = index == currentQuestionIndex;

                    return GestureDetector(
                      onTap: () async {
                        if (widget.buttontext ==
                                'Attempt 5 Questions for Free' &&
                            index >= 5) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Limit Reached'),
                              content: const Text(
                                  'You can only attempt 5 questions for free.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                          return;
                        }

                        updateAttempt();
                        await _skipToQuestion(index);
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
                                color: isCurrent ? Colors.blue : Colors.white,
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
                )),
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
                        onTap: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (context) => TestBottomSheet(
                              addFlasCards: () async {
                                await Provider.of<FlashcardProvider>(context,
                                        listen: false)
                                    .removeFlashcard(
                                  userId: userProvider.user!.userId,
                                  subject: widget.subject,
                                  questionId: question.questionId,
                                );
                                showSnackBarr();
                              },
                              questionNumber:
                                  "${currentQuestionIndex + 1} of ${widget.totalquestions}",
                              timerWidget: const SizedBox(width: 0),
                              submitNow: _showFinishDialog,
                              reportNow: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ReportQuestion(
                                        questionId: '$currentQuestionIndex'),
                                  ),
                                );
                              },
                              pauseOrContinue: () {},
                              restart: () {
                                Navigator.of(context).pop();
                                restart();
                              },
                              showButton: false,
                              continueLater: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const MainNavigationScreen(),
                                  ),
                                );
                              },
                            ),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(25.0)),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: PreMedColorTheme().primaryColorRed,
                          ),
                          child: Image.asset(
                              Provider.of<PreMedProvider>(context).isPreMed
                                  ? PremedAssets.MENU
                                  : PremedAssets.BlueMenu),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${currentQuestionIndex + 1} of ${widget.totalquestions}",
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
                          child: InkWell(
                            onTap: () async {
                              _showComingSoonPopup(context);
                            },
                            child: Image.asset(PremedAssets.Flask),
                          ),
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

class ExplanationButton extends StatefulWidget {
  const ExplanationButton(
      {super.key, this.explanationText, required this.isCorrect});

  final String? explanationText;
  final bool? isCorrect;

  @override
  ExplanationButtonState createState() => ExplanationButtonState();
}

class ExplanationButtonState extends State<ExplanationButton> {
  bool showExplanation = false;

  @override
  Widget build(BuildContext context) {
    Color getButtonColor() {
      if (widget.isCorrect == true) {
        return Colors.greenAccent;
      } else if (widget.isCorrect == false) {
        return PreMedColorTheme().primaryColorRed300;
      } else {
        return Colors.white;
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 163,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                showExplanation = !showExplanation;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: getButtonColor(),
              foregroundColor: Colors.black,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Explanation"),
                const SizedBox(width: 8),
                Icon(
                  showExplanation
                      ? Icons.arrow_drop_up_rounded
                      : Icons.arrow_drop_down_rounded,
                  color: PreMedColorTheme().black,
                ),
              ],
            ),
          ),
        ),
        if (showExplanation &&
            widget.explanationText != null &&
            widget.explanationText!.isNotEmpty)
          Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(8),
                color: Colors.white),
            child: Text(
              widget.explanationText!,
              style: PreMedTextTheme().body.copyWith(
                    color: PreMedColorTheme().black,
                  ),
            ),
          ),
      ],
    );
  }
}


