import 'package:flutter_svg/flutter_svg.dart';
import 'package:html/parser.dart' as htmlparser;
import 'package:premedpk_mobile_app/UI/screens/Test%20Interface/report_question.dart';
import 'package:premedpk_mobile_app/UI/screens/Test%20Interface/test_bottom_sheet.dart';
import 'package:premedpk_mobile_app/UI/screens/Test%20Interface/widgets/analytics.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/flashcard_provider.dart';
import 'package:premedpk_mobile_app/providers/vaultProviders/premed_provider.dart';
import 'package:provider/provider.dart';
import '../../../models/question_model.dart';
import '../../../models/recent_attempts_model.dart';
import '../../../providers/deck_info_provider.dart';
import '../../../providers/question_provider.dart';
import '../../../providers/recent_atempts_provider.dart';
import '../../../providers/save_question_provider.dart';
import '../../../providers/savedquestion_provider.dart';
import '../../../providers/update_attempt_provider.dart';
import '../../../providers/user_provider.dart';
import '../navigation_screen/main_navigation_screen.dart';
class TestInterface extends StatefulWidget {
  const TestInterface({
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

  });

  final List<String>? questionlist;
  final int totalquestions;
  final bool? isRecent;
  final bool? isReview;
  final bool isContinuingAttempt;
  final String attemptId;
  final String deckName;
  final int startFromQuestion;
  final String subject;


  @override
  State<TestInterface> createState() => _TestInterfaceState();
}

class _TestInterfaceState extends State<TestInterface> {
  Set<String> _eliminatedOptions = {};
  bool isLoading = false;
  bool _isLoading = false;



  void _startTimer() {
    _stopwatch.reset();
    _stopwatch.start();

    _durationNotifier.value = const Duration(hours: 2);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _durationNotifier.value =
          _durationNotifier.value - const Duration(seconds: 1);
      if (_durationNotifier.value <= Duration.zero) {
        _timer?.cancel();
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
    return htmlparser
        .parse(toParse)
        .body
        ?.text;
  }

  bool isBase64(String str) {
    try {
      base64Decode(str
          .split(',')
          .last);
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
    final attemptProvider = Provider.of<AttemptProvider>(context, listen: false);

    await attemptProvider.getAttemptInfo(widget.attemptId);

    final attemptInfo = attemptProvider.attemptInfo;

    if (attemptInfo == null) {
      print('Error: attemptInfo is null');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to load valid attempt info. Please try again.')),
      );
      return;
    }

    if (attemptInfo.incorrectAttempts == null) {
      print('Error: One or more fields in attemptInfo are null');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid attempt data. Please try again.')),
      );
      return;
    }

    final int correctAttempts = attemptInfo.correctAttempts;
    final int incorrectAttempts = attemptInfo.incorrectAttempts;
    final int skippedAttempts = attemptInfo.skippedAttempts ?? 0;
    final totalTimeTaken = attemptInfo.totalTimeTaken;
    final unattemptedQuestions = attemptInfo.totalQuestions - correctAttempts - incorrectAttempts;

    print("Total attempted questions: ${correctAttempts + incorrectAttempts}");

    // Show the dialog
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
              onPressed: _isLoading
                  ? null
                  : () async {
                setState(() {
                  _isLoading = true;
                });

                final attempted = correctAttempts + incorrectAttempts;

                await attemptProvider.updateResult(
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

                setState(() {
                  _isLoading = false;
                });

                if (attemptProvider.status == AStatus.success) {
                  Navigator.pop(context);

                  // Navigate to Analytics screen with filtered data
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
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'Failed to update the result: ${attemptProvider.message}'),
                    ),
                  );
                }
              },
              child: _isLoading
                  ? const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
                  : const Text('Finish'),
            ),
          ],
        );
      },
    );
  }

  void showSnackBarr() {
    final flashcardpro = Provider.of<FlashcardProvider>(context, listen: false);
    final message = flashcardpro.additionStatus == 'Added'
        ? 'Added To Saved Facts'
        : 'Removed from Saved Facts';
    showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
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
                        color: Provider
                            .of<PreMedProvider>(context)
                            .isPreMed
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
  bool _isEliminationActive = false;

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

  @override
  void initState() {
    super.initState();
    startLoadingAnimation();

    print(
        "Navigating to test interface with attemptId: ${widget
            .attemptId}, deck name: ${widget
            .deckName}, startFromQuestion: ${widget
            .startFromQuestion}, isContinueAttempt: ${widget
            .isContinuingAttempt}"
    );

    print('yeh hy iss point py ${widget.totalquestions}');
    selectedOptions = List<String?>.filled(widget.totalquestions, null);
    isCorrectlyAnswered = List<bool?>.filled(widget.totalquestions, null);



    if (widget.isReview == true) {
      _fetchAllQuestions().then((_) {
        _loadReviewData();
      });
    } else if (widget.isContinuingAttempt) {
      _fetchAllQuestions().then((_) {
        _loadAttemptData();
      });
    }  else if (widget.isRecent == true) {
      _fetchAllQuestions().then((_) {
        _loadPreviousSelections();
      });    }  else {
      _clearSelectionsForReattempt();
    }


    if (widget.isReview != true) {
      _startTimer();
    }
  }


  void _clearSelectionsForReattempt() {
    print('yeh hy iss point py ${widget.totalquestions}');

    selectedOptions = List<String?>.filled(widget.totalquestions, null);



  isCorrectlyAnswered = List<bool?>.filled(widget.totalquestions, null);


  setState(() {
      _fetchInitialQuestions();
    });


    _startTimer();
  }

  Future<void> _fetchInitialQuestions() async {
    setState(() {
      isLoading = true;
    });

    final questionProvider = Provider.of<QuestionProvider>(
        context, listen: false);
    questionProvider.clearQuestions();

    final Set<String> loadedQuestionIds = {};


    final int startPage = (widget.startFromQuestion) ~/ 10 + 1;

    for (int page = 1; page <= startPage; page++) {
      if (!questionProvider.isPageLoaded(page)) {
        print("DEBUG: Fetching questions from page: $page");
        await questionProvider.fetchQuestions(widget.deckName, page);


        questionProvider.questions.removeWhere((q) =>
            loadedQuestionIds.contains(q.questionId));
        loadedQuestionIds.addAll(
            questionProvider.questions.map((q) => q.questionId) ?? []);
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

      final Set<String> loadedQuestionIds = {};
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
        final lastAttemptedQuestionId = attempts[lastAttemptedIndex]['questionId'];
        final lastAttemptedIndexValue = getIndexForQuestionId(
            lastAttemptedQuestionId);

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


      final Set<String> loadedQuestionIds = {};
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
    final questions = Provider
        .of<QuestionProvider>(context, listen: false)
        .questions;

    if (questions.isNotEmpty) {
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

  Future<void> previousQuestion() async {
    if (isLoading) return;
    updateAttempt();

    final questionProvider =
    Provider.of<QuestionProvider>(context, listen: false);
    final deckInfo =
        Provider
            .of<DeckProvider>(context, listen: false)
            .deckInformation;

    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
        _eliminatedOptions.clear();
        _isEliminationActive = false;
        if (currentQuestionIndex % 10 == 9 && currentPage > 1) {
          currentPage--;
          _fetchNextSetOfQuestions(currentPage).then((_) {
            if (questionProvider.questions.length > currentQuestionIndex) {
              final question =
              questionProvider.questions[currentQuestionIndex];
              selectedOption = selectedOptions[currentQuestionIndex];
              optionSelected = selectedOption != null;

              if (widget.isReview == true && selectedOption == null) {
                selectedOption =
                    deckInfo?.getSelectionForQuestion(
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
        } else if (questionProvider.questions.length > currentQuestionIndex) {
          final question = questionProvider.questions[currentQuestionIndex];
          selectedOption = selectedOptions[currentQuestionIndex];
          optionSelected = selectedOption != null;

          if (widget.isReview == true && selectedOption == null) {
            selectedOption =
                deckInfo?.getSelectionForQuestion(
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
      Navigator.pop(context);
    }
  }
  Future<void> nextQuestion() async {
    if (isLoading) {
      print("nextQuestion() called but already loading");
      return;
    }

    // Debug: Current state before proceeding
    print("nextQuestion() called. Current index: $currentQuestionIndex, Total questions: ${widget.totalquestions}");

    // Update current attempt progress
    updateAttempt();

    final questionProvider = Provider.of<QuestionProvider>(context, listen: false);

    // Calculate potential next index and required page
    final potentialNewIndex = currentQuestionIndex + 1;
    final requiredPage = (potentialNewIndex ~/ 10) + 1;

    // Debug: Next index and page
    print("Potential new index: $potentialNewIndex, Required page: $requiredPage");

    // Only proceed if within total question bounds
    if (potentialNewIndex >= widget.totalquestions) {
      print("Reached end of questions at index: $currentQuestionIndex");
      return;
    }

    // Check if we need to load more questions
    if (!questionProvider.isPageLoaded(requiredPage)) {
      print("Page $requiredPage not loaded. Fetching...");
      setState(() => isLoading = true);

      try {
        await questionProvider.fetchQuestions(widget.deckName, requiredPage);

        // Validate that questions are loaded
        final totalLoaded = questionProvider.questions?.length ?? 0;
        print("Questions after fetching page $requiredPage: $totalLoaded");

        // Ensure the last questions are loaded
        if (totalLoaded < widget.totalquestions) {
          print("Warning: Only $totalLoaded questions loaded, expected ${widget.totalquestions}.");
        }

        // Exit if the target index is still out of bounds
        if (totalLoaded <= potentialNewIndex) {
          print("Error: Attempting to access index $potentialNewIndex but only $totalLoaded questions loaded.");
          setState(() => isLoading = false);
          return;
        }
      } catch (e) {
        print("Error fetching page $requiredPage: $e");
        setState(() => isLoading = false);
        return;
      }

      setState(() => isLoading = false);
    }

    // Safety check after loading
    if (potentialNewIndex >= questionProvider.questions!.length) {
      print("Out-of-bounds after loading. Current questions: ${questionProvider.questions!.length}, Attempted index: $potentialNewIndex");
      return;
    }

    // Update state for new question
    setState(() {
      currentQuestionIndex = potentialNewIndex;

      // Debug: New index and related info
      print("Moved to question index: $currentQuestionIndex");
      print("Current question details: ${questionProvider.questions![currentQuestionIndex]}");

      // Handle selection state
      selectedOption = selectedOptions[currentQuestionIndex];
      optionSelected = selectedOption != null;

      // Prefetch next page when approaching end of the current page
      if ((currentQuestionIndex + 2) % 10 == 0) { // Prefetch at 8th question (0-based index 7)
        final nextPage = requiredPage + 1;
        if (!questionProvider.isPageLoaded(nextPage)) {
          print("Prefetching next page: $nextPage");
          unawaited(questionProvider.fetchQuestions(widget.deckName, nextPage));
        }
      }
    });

    // Notify listeners after state update
    questionProvider.notifyListeners();

    // Debug: Final state after question transition
    print("Final state: Current index: $currentQuestionIndex, Total loaded questions: ${questionProvider.questions?.length}");
  }
  Future<void> _fetchNextSetOfQuestions(int nextPage) async {
    if (isLoading) return;

    setState(() => isLoading = true);

    final questionProvider = Provider.of<QuestionProvider>(context, listen: false);

    if (!questionProvider.isPageLoaded(nextPage)) {
      print("Fetching questions from page: $nextPage");
      try {
        await questionProvider.fetchQuestions(widget.deckName, nextPage);
      } catch (e) {
        print('Error fetching page $nextPage: $e');
      }
    }

    setState(() => isLoading = false);
  }
  Future<void> _loadQuestionsBetween(int startIndex, int endIndex) async {
    if (isLoading) return;

    setState(() => isLoading = true);

    // Validate and clamp indices
    final total = widget.totalquestions;
    final clampedStart = startIndex.clamp(0, total - 1);
    final clampedEnd = endIndex.clamp(0, total - 1);

    if (clampedStart > clampedEnd) {
      print('Invalid range: $clampedStart-$clampedEnd');
      setState(() => isLoading = false);
      return;
    }

    // Convert indices to 1-based pages
    final startPage = (clampedStart ~/ 10) + 1;
    final endPage = (clampedEnd ~/ 10) + 1;

    final questionProvider = Provider.of<QuestionProvider>(context, listen: false);

    for (int page = startPage; page <= endPage; page++) {
      if (!questionProvider.isPageLoaded(page)) {
        try {
          print('Fetching page $page (questions ${(page - 1) * 10}-${page * 10})');
          await questionProvider.fetchQuestions(widget.deckName, page);
        } catch (e) {
          print('Error fetching page $page: $e');
        }
      }
    }

    // Final validation for loaded questions
    final loadedCount = questionProvider.questions.length;
    if (loadedCount < total) {
      print('Warning: Only $loadedCount questions loaded, expected $total.');
    } else {
      print('Loaded $loadedCount questions (range $clampedStart-$clampedEnd).');
    }

    setState(() => isLoading = false);
  }
  Future<void> _skipToQuestion(int targetIndex) async {
    final questionProvider = Provider.of<QuestionProvider>(context, listen: false);

    if (currentQuestionIndex == targetIndex) return;

    print('Attempting to skip to question $targetIndex out of ${widget.totalquestions}.');

    // Clamp the target index to valid range
    int adjustedIndex = targetIndex.clamp(0, widget.totalquestions - 1);

    // Load questions in between if needed
    if (currentQuestionIndex < adjustedIndex) {
      await _loadQuestionsBetween(currentQuestionIndex, adjustedIndex);
    }

    // Calculate the page for the target index
    final int targetPage = (adjustedIndex ~/ 10) + 1;

    // Load the target page if not loaded
    if (!questionProvider.isPageLoaded(targetPage)) {
      await _fetchNextSetOfQuestions(targetPage);
    }

    // Final validation for out-of-range issues
    if (adjustedIndex >= questionProvider.questions.length) {
      print('Error: Attempting to access index $adjustedIndex but only ${questionProvider.questions.length} questions loaded.');
      return;
    }

    // Update the state to reflect the skipped question
    setState(() {
      currentQuestionIndex = adjustedIndex;
      selectedOption = selectedOptions[currentQuestionIndex];
      optionSelected = selectedOption != null;
    });
  }
  Future<void> _fetchAllQuestions() async {
    setState(() {
      isLoading = true;
    });

    final questionProvider = Provider.of<QuestionProvider>(
        context, listen: false);
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

      questionProvider.questions?.removeWhere((q) =>
          loadedQuestionIds.contains(q.questionId));

      final fetchedQuestionIds = questionProvider.questions?.map((q) =>
      q.questionId) ?? [];

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

  Future<void> _loadPreviousSelections() async {
    print("DEBUG: Recent attempt mode activated");

    final recentProvider = Provider.of<RecentAttemptsProvider>(
        context, listen: false);
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

      int startQuestionIndex = getIndexForQuestionId(
          lastAttemptedQuestionId ?? '');

      print(
          "startQuestionIndex calculated by getIndexForQuestionId: $startQuestionIndex");

      if (startQuestionIndex == -1) {
        print("Invalid startQuestionIndex. Fallback to 0.");
        startQuestionIndex = 0;
      }


      final endQuestionIndex = allAttempts.length - 1;


      await _loadQuestionsBetween(startQuestionIndex, endQuestionIndex);


      for (final attempt in allAttempts) {
        final int questionIndex = getIndexForQuestionId(
            attempt.questionId ?? '');
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
    print('yeh hy iss point py ${widget.totalquestions}');

    if (currentQuestionIndex < widget.totalquestions) {
      _stopwatch.stop();
      final timeTaken = _stopwatch.elapsedMilliseconds;
      totalTimeTaken += (timeTaken / 1000).round();

      final question = questionProvider.questions[currentQuestionIndex];
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

      print("YEH HY TIME TAKEN $timeTaken and $totalTimeTaken");
      print("YEH HY TIME TAKEN $timeTaken and $optionSelected and $attemptData");
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
      print('yeh hy iss point py ${widget.totalquestions}');

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
    final questionProvider =
    Provider.of<QuestionProvider>(context, listen: false);
    final questions = questionProvider.questions;

    if (isLoading || questions.isEmpty) {
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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
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
              const SizedBox(height: 16),
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
                      setState(() {
                        _isEliminationActive = true;
                      });
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
                  if (_isEliminationActive)
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
                        setState(() {
                          _isEliminationActive = false;
                          _eliminatedOptions.clear(); // Reset eliminated options
                        });
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/icons/elimination.svg'),
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
                final parsedOptionText = parse(option.optionText.toString());
                final isEliminated = _eliminatedOptions.contains(option.optionLetter);

                return QuizOption(
                  optionLetter: option.optionLetter,
                  parsedOptionText: parsedOptionText ?? '',
                  isSelected: option.optionLetter == selectedOption,
                  isEliminated: isEliminated,
                  isEliminationActive: _isEliminationActive,
                  onTap: () {
                    if (!isEliminated) {
                      selectOption(option.optionLetter);
                    } else {
                      print("Eliminated option cannot be selected.");
                    }
                  },
                  onEliminate: () {
                    setState(() {
                      if (isEliminated) {
                        _eliminatedOptions.remove(option.optionLetter);
                      } else {
                        _eliminatedOptions.add(option.optionLetter);
                      }
                    });
                  },
                );
              }),            ],
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
                child:ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.totalquestions,
                  itemBuilder: (context, index) {
                    final bool isAttempted = selectedOptions.length > index && selectedOptions[index] != null;
                    final bool isCurrent = index == currentQuestionIndex;

                    return GestureDetector(
                      onTap: () async {
                        if (widget.isReview != true) {
                          updateAttempt();
                        }
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
                              backgroundColor: isAttempted ? Colors.blue : PreMedColorTheme().white,
                              child: Text(
                                '${index + 1}',
                                style: TextStyle(
                                  color: isAttempted ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )
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
                        onTap: () {
                          showModalBottomSheet(
                            useSafeArea: true,
                            isScrollControlled: true,
                            sheetAnimationStyle:
                            AnimationStyle(curve: Curves.bounceIn),
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
                              timerWidget: Column(
                                children: [
                                  ValueListenableBuilder<Duration>(
                                    valueListenable: _durationNotifier,
                                    builder: (context, duration, child) {
                                      return Text(
                                        _formatDuration(duration),
                                        style: PreMedTextTheme().body.copyWith(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          color:
                                          PreMedColorTheme().neutral800,
                                        ),
                                      );
                                    },
                                  ),
                                  const Text(
                                    'TIME LEFT',
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              submitNow: _showFinishDialog,
                              reportNow: () {
                                Navigator.pop(context);
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ReportQuestion(
                                        questionId: question.questionId),
                                  ),
                                );
                              },
                              restart: () {
                                Navigator.of(context).pop();
                                restart();
                              },
                              showButton: true,
                              pauseOrContinue: _togglePauseResume,
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
                          child: Image.asset(PremedAssets.MENU),
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
                          child: InkWell(
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

class QuizOption extends StatelessWidget {

  const QuizOption({
    super.key,
    required this.optionLetter,
    required this.parsedOptionText,
    required this.isSelected,
    required this.isEliminated,
    required this.isEliminationActive,
    required this.onTap,
    this.onEliminate,
  });
  final Object optionLetter;
  final String parsedOptionText;
  final bool isSelected;
  final bool isEliminated;
  final bool isEliminationActive;
  final VoidCallback onTap;
  final VoidCallback? onEliminate;

  @override
  Widget build(BuildContext context) {
    final borderColor = isSelected
        ? Colors.blue
        : PreMedColorTheme().neutral400;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 28,
                child: Center(
                  child: Text(
                    '${optionLetter.toString()}. ',
                    style: PreMedTextTheme().body.copyWith(
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                      color: PreMedColorTheme().primaryColorRed,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 14.0),
                    child: Text(
                      parsedOptionText,
                      style: PreMedTextTheme().body.copyWith(
                        color: isEliminated
                            ? PreMedColorTheme().neutral400
                            : PreMedColorTheme().black,
                        decoration: isEliminated
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                  ),
                ),
              ),
              if (isEliminationActive)
                IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: Colors.red,
                  ),
                  onPressed: onEliminate,
                ),
            ],
          ),
        ),
      ),
    );
  }
}