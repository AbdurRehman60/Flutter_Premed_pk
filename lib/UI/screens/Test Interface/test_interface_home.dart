import 'package:flutter_svg/flutter_svg.dart';
import 'package:html/parser.dart' as htmlparser;
import 'package:premedpk_mobile_app/UI/screens/Test%20Interface/report_question.dart';
import 'package:premedpk_mobile_app/UI/screens/Test%20Interface/test_bottom_sheet.dart';
import 'package:premedpk_mobile_app/UI/screens/Test%20Interface/widgets/analytics.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/flashcard_provider.dart';
import 'package:premedpk_mobile_app/providers/vaultProviders/premed_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  List<Option> _eliminatedOptions = [];
  bool isLoading = false;
  bool _isLoading = false;

  void _eliminateOptions(List<Option> options) {
    _eliminatedOptions = [options.removeAt(0), options.removeAt(0)];
    setState(() {});
  }

  void _undoElimination(List<Option> options) {
    options.addAll(_eliminatedOptions);
    _eliminatedOptions = [];
    setState(() {});
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
    Navigator.pop(context);
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
  bool isPrefetched = false;
  late List<String?> selectedOptions;
  late List<bool?> isCorrectlyAnswered;

  @override
  void initState() {
    super.initState();
    print(
        "Navigating to test interface with attemptId: ${widget.attemptId}, deck name: ${widget.deckName}, startFromQuestion: ${widget.startFromQuestion}, isContinueAttempt: ${widget.isContinuingAttempt}");

    selectedOptions = List<String?>.filled(widget.totalquestions, null, growable: true);
    isCorrectlyAnswered = List<bool?>.filled(widget.totalquestions, null, growable: true);

    if (widget.isReview == true) {
      print("DEBUG: Review mode detected, starting from question 0");
      currentQuestionIndex = 0;
    } else if (widget.isContinuingAttempt == true) {
      final deckProvider = Provider.of<DeckProvider>(context, listen: false);
      final lastAttempt = deckProvider.deckInformation?.lastAttempt;

      if (lastAttempt != null && lastAttempt['attempts'] != null) {
        final attempts = lastAttempt['attempts'];

        final lastAttemptedQuestion = attempts.lastWhere(
              (attempt) => attempt['attempted'] == true,
          orElse: () => attempts.first,
        );

        _fetchQuestionsUntilFound(lastAttemptedQuestion['questionId']);
      } else {
        currentQuestionIndex = 0;
      }
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchInitialQuestions().then((_) {
        if (widget.isReview == true || widget.isContinuingAttempt == true || widget.isRecent == true) {
          _loadPreviousSelections();
        } else {
          _clearSelectionsForReattempt();
        }

        if (widget.isReview != true) {
          _startTimer();
        }
      });
    });
  }
  Future<void> _fetchQuestionsUntilFound(String questionId) async {
    setState(() {
      isLoading = true;
    });

    final questionProvider = Provider.of<QuestionProvider>(context, listen: false);
    questionProvider.clearQuestions();

    int currentPage = 1;
    bool questionFound = false;

    while (!questionFound) {
      if (!questionProvider.isPageLoaded(currentPage)) {
        print("Fetching page $currentPage to load the required question.");
        await questionProvider.fetchQuestions(widget.deckName, currentPage);
      }

      final questionIndex = getIndexForQuestionId(questionId);

      if (questionIndex != -1) {
        currentQuestionIndex = questionIndex;
        questionFound = true;
        print("DEBUG: Found question $questionId at index $currentQuestionIndex.");
      } else {
        currentPage++;
        if (currentPage > (widget.totalquestions ~/ 10) + 1) {
          print("DEBUG: Question ID not found after loading all pages, starting from the first question.");
          currentQuestionIndex = 0;
          questionFound = true;
        }
      }
    }

    setState(() {
      isLoading = false;
    });
  }
  int getIndexForQuestionId(String questionId) {
    final questions = Provider.of<QuestionProvider>(context, listen: false).questions;

    if (questions != null) {
      for (int i = 0; i < questions.length; i++) {
        if (questions[i].questionId == questionId) {
          return i;
        }
      }
    }
    return -1;
  }
  Future<void> _fetchInitialQuestions() async {
    setState(() {
      isLoading = true;
    });

    final questionProvider =
        Provider.of<QuestionProvider>(context, listen: false);
    questionProvider.clearQuestions();
    questionProvider.deckName = widget.deckName;

    int startPage = (widget.startFromQuestion) ~/ 10 + 1;

    for (int page = 1; page <= startPage; page++) {
      if (!questionProvider.isPageLoaded(page)) {
        await questionProvider.fetchQuestions(widget.deckName, page);
      }
    }
    setState(() {
      isLoading = false;
      currentPage = startPage;
    });
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
            selectedOption =
                deckInfo?.getSelectionForQuestion(question.questionId);
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

    final questionProvider = Provider.of<QuestionProvider>(context, listen: false);

    if (!questionProvider.isPageLoaded(nextPage)) {
      print("Fetching questions from page: $nextPage");
      await questionProvider.fetchQuestions(widget.deckName, nextPage);
    }

    setState(() {
      isLoading = false;
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
                selectedOption =
                    deckInfo?.getSelectionForQuestion(question.questionId);
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
            selectedOption =
                deckInfo?.getSelectionForQuestion(question.questionId);
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
      int startQuestionIndex, int endQuestionIndex) async {setState(() {
      isLoading = true;
    });final questionProvider =
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
    final questionProvider = Provider.of<QuestionProvider>(context, listen: false);

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
        final recentProvider = Provider.of<RecentAttemptsProvider>(context, listen: false);
        final List<RecentAttempt> recentAttempts = recentProvider.recentAttempts;

        final recentAttempt = recentAttempts.firstWhere(
              (attempt) => attempt.id == widget.attemptId,
          orElse: () => RecentAttempt(attempts: Attempts(attempts: [])),
        );

        if (recentAttempt.attempts != null) {
          final question = questionProvider.questions![currentQuestionIndex];

          final recentSelection = recentAttempt.attempts!.attempts!
              .firstWhere(
                (attempt) => attempt.questionId == question.questionId,
            orElse: () => AttemptofQuestions(questionId: question.questionId),
          ).selection;

          selectedOption = recentSelection ?? selectedOptions[currentQuestionIndex];
          optionSelected = selectedOption != null;
        }

      } else if (widget.isContinuingAttempt) {
        final deckProvider = Provider.of<DeckProvider>(context, listen: false);
        final deckInfo = deckProvider.deckInformation;

        if (deckInfo != null && deckInfo.lastAttempt.isNotEmpty) {
          final lastAttempt = deckInfo.lastAttempt;

          final question = questionProvider.questions![currentQuestionIndex];

          final continuingSelection = lastAttempt['attempts']!
              .firstWhere(
                (attempt) => attempt['questionId'] == question.questionId,
            orElse: () => {},
          )['selection'];

          selectedOption = continuingSelection ?? selectedOptions[currentQuestionIndex];
          optionSelected = selectedOption != null;
        }

      } else if (widget.isReview == true) {
        final deckProvider = Provider.of<DeckProvider>(context, listen: false);
        final deckInfo = deckProvider.deckInformation;
        if (deckInfo != null && deckInfo.lastAttempt.isNotEmpty) {
          final lastAttempt = deckInfo.lastAttempt;

          final question = questionProvider.questions![currentQuestionIndex];

          final reviewSelection = lastAttempt['attempts']!
              .firstWhere(
                (attempt) => attempt['questionId'] == question.questionId,
            orElse: () => {},
          )['selection'];

          selectedOption = reviewSelection ?? selectedOptions[currentQuestionIndex];
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
      print("Recent attempt mode activated");
      final recentProvider = Provider.of<RecentAttemptsProvider>(context, listen: false);
      final List<RecentAttempt> recentAttempts = recentProvider.recentAttempts;

      final recentAttempt = recentAttempts.firstWhere(
            (attempt) => attempt.id == widget.attemptId,
        orElse: () => RecentAttempt(attempts: Attempts(attempts: [])),
      );

      int startQuestionIndex = 0;

      if (recentAttempt.attempts != null && recentAttempt.attempts!.attempts != null && recentAttempt.attempts!.attempts!.isNotEmpty) {
        final allAttempts = recentAttempt.attempts!.attempts!;
        final lastAttemptedQuestionId = allAttempts.last.questionId;
        print("Last Attempted Question ID: $lastAttemptedQuestionId");

        startQuestionIndex = getIndexForQuestionId(lastAttemptedQuestionId ?? '');

        print("startQuestionIndex calculated by getIndexForQuestionId: $startQuestionIndex");

        if (startQuestionIndex == -1) {
          print("Invalid startQuestionIndex. Fallback to 0.");
          startQuestionIndex = 0;
        }

        final endQuestionIndex = allAttempts.length - 1;
        await _loadQuestionsBetween(startQuestionIndex, endQuestionIndex);

        for (final attempt in allAttempts) {
          final int questionIndex = getIndexForQuestionId(attempt.questionId ?? '');
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
      }

      setState(() {
        currentQuestionIndex = startQuestionIndex;
        print("Set currentQuestionIndex to start from $startQuestionIndex");
      });
    }
    else {
      final deckProvider = Provider.of<DeckProvider>(context, listen: false);
      final deckInfo = deckProvider.deckInformation;

      if (deckInfo != null && deckInfo.lastAttempt.isNotEmpty) {
        final lastAttempt = deckInfo.lastAttempt;

        if (lastAttempt['attempts'] != null) {
          for (final attempt in lastAttempt['attempts']) {
            final int questionIndex = getIndexForQuestionId(attempt['questionId']);
            if (questionIndex != -1) {
              selectedOptions[questionIndex] = attempt['selection'];
              isCorrectlyAnswered[questionIndex] = attempt['isCorrect'];

              if (questionIndex == currentQuestionIndex) {
                selectedOption = attempt['selection'];
                optionSelected = selectedOption != null;
              }
            }
          }
        }

        setState(() {});
      }

      else if (widget.isContinuingAttempt) {
        if (deckInfo != null && deckInfo.lastAttempt.isNotEmpty) {
          final lastAttempt = deckInfo.lastAttempt;

          if (lastAttempt['attempts'] != null) {
            final List<dynamic> attempts = lastAttempt['attempts'];

            // Load all the questions between 0 and the length of attempts
            await _loadQuestionsBetween(0, attempts.length - 1);

            int lastAttemptedIndex = -1; // Index of the last attempted question

            for (int i = 0; i < attempts.length; i++) {
              final attempt = attempts[i];
              final int questionIndex = getIndexForQuestionId(attempt['questionId']);
              if (questionIndex != -1) {
                selectedOptions[questionIndex] = attempt['selection'];
                isCorrectlyAnswered[questionIndex] = attempt['isCorrect'];
              }

              // Track the index of the last attempted question
              if (attempt['attempted'] == true) {
                lastAttemptedIndex = i;
              }
            }

            // Set currentQuestionIndex to the last attempted question's index or 0 if none attempted
            setState(() {
              currentQuestionIndex = (lastAttemptedIndex != -1) ? lastAttemptedIndex : 0;
              print("Set currentQuestionIndex to $currentQuestionIndex to continue where user left off");
            });
          }
        }
      }


      else if (widget.isReview == true) {
        print("Review mode activated");

        // Load all questions for review
        if (deckInfo != null && deckInfo.lastAttempt.isNotEmpty) {
          final lastAttempt = deckInfo.lastAttempt;

          if (lastAttempt['attempts'] != null) {
            final List<dynamic> attempts = lastAttempt['attempts'];

            await _loadQuestionsBetween(0, attempts.length - 1);

            for (final attempt in attempts) {
              final int questionIndex = getIndexForQuestionId(attempt['questionId']);
              if (questionIndex != -1) {
                selectedOptions[questionIndex] = attempt['selection'];
                isCorrectlyAnswered[questionIndex] = attempt['isCorrect'];
              }
            }

            setState(() {
              currentQuestionIndex = 0;
              print("Set currentQuestionIndex to 0 for review");
            });
          }
        }
      }
    }
  }


  void _clearSelectionsForReattempt() {
    selectedOptions.fillRange(0, widget.totalquestions, null);
    isCorrectlyAnswered.fillRange(0, widget.totalquestions, null);
    setState(() {});
  }

  @override
  void dispose() {
    if (widget.isReview != true) {
      _saveCurrentQuestionIndex();
    }
    _timer?.cancel();
    _durationNotifier.dispose();
    super.dispose();
  }

  Future<void> _saveCurrentQuestionIndex() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(
        'currentQuestionIndex_${widget.attemptId}', currentQuestionIndex);
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

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final questionProvider =
        Provider.of<QuestionProvider>(context, listen: false);
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
        body: const Center(child: CircularProgressIndicator()),
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
                final borderColor =
                    isSelected ? Colors.blue : PreMedColorTheme().neutral400;

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
                                  color: PreMedColorTheme().primaryColorRed),
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
                                        questionId: '$currentQuestionIndex'),
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
