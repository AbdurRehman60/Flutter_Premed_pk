import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../providers/create_deck_attempt_provider.dart';
import '../../../../providers/paper_provider.dart';
import '../../../../models/deck_group_model.dart';
import '../../../../providers/question_provider.dart';
import '../../../../providers/user_provider.dart';
import '../../../../constants/constants_export.dart';
import '../../../../providers/vaultProviders/premed_provider.dart';
import '../../../Widgets/global_widgets/custom_button.dart';
import '../../Test Interface/widgets/tutor_mode_test_interface.dart';
import '../../qbank/widgets/logo_avatar.dart';
import '../../qbank/widgets/prac_and_past_instruc.dart';
import 'deck_instructions.dart';

class NewBottomSheet extends StatefulWidget {
  const NewBottomSheet({
    super.key,
    required this.deckGroup,
    required this.bankOrMock,
    required this.category,
    required this.subject,
  });

  final String bankOrMock;
  final DeckGroupModel deckGroup;
  final String? category;
  final String subject;

  @override
  State<NewBottomSheet> createState() => _NewBottomSheetState();
}

class _NewBottomSheetState extends State<NewBottomSheet> {
  late int selectedDeckItemIndex;
  bool isContinuingAttempt = false;

  Future<void> _fetchQuestions(String deckName, BuildContext context) async {
    await Provider.of<QuestionProvider>(context, listen: false)
        .fetchQuestions(deckName, 1);
  }

  String newdeckname(String deckName) {
    return deckName
        .replaceAll('Past Paper', '')
        .replaceAll('Practice', '')
        .trim();
  }

  Future<void> _fetchDeckInfo(int index, BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    final fullDeckName = widget.deckGroup.deckItems[index].deckName;
    final cleanedDeckName = newdeckname(fullDeckName);
    print("Full Deck Name: $fullDeckName");
    print("Cleaned Deck Name being passed: $cleanedDeckName");

    final category = widget.category ?? '';
    final deckGroup = widget.deckGroup.deckGroupName;
    final userId = userProvider.user!.userId;

    try {
      await Provider.of<PaperProvider>(context, listen: false)
          .fetchPapers(category, deckGroup, cleanedDeckName, userId);
    } catch (e) {
      print('Error fetching deck information: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, List<DeckItem>> groupedDeckItems = {};
    final List<int> originalIndexes = [];

    for (final item in widget.deckGroup.deckItems) {
      String baseDeckName = newdeckname(item.deckName);
      if (!groupedDeckItems.containsKey(baseDeckName)) {
        groupedDeckItems[baseDeckName] = [];
      }
      groupedDeckItems[baseDeckName]!.add(item);
    }

    final List<DeckItem> uniquedeckitems = [];
    groupedDeckItems.forEach((baseName, deckItems) {
      bool isPracticePublished = false;
      bool isPastPaperPublished = false;

      for (var item in deckItems) {
        if (item.deckName.contains('Practice') && item.isPublished) {
          isPracticePublished = true;
        } else if (item.deckName.contains('Past Paper') && item.isPublished) {
          isPastPaperPublished = true;
        }
      }

      if (isPracticePublished && isPastPaperPublished) {
        final deckToDisplay =
            deckItems.firstWhere((item) => item.deckName.contains('Practice'));
        uniquedeckitems.add(deckToDisplay);

        final originalIndex = widget.deckGroup.deckItems.indexOf(deckToDisplay);
        originalIndexes.add(originalIndex);
      }
    });

    final preMedPro = context.read<PreMedProvider>();

    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.70,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 8,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: PreMedColorTheme().neutral400,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: uniquedeckitems.length,
                itemBuilder: (context, index) {
                  final DeckItem item = uniquedeckitems[index];

                  // Clean the deck name here
                  final String cleanedDeckName = newdeckname(item.deckName);

                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: ListTile(
                      leading: GetLogo(url: item.deckLogo),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            cleanedDeckName,
                            style: PreMedTextTheme().body.copyWith(
                                  color: PreMedColorTheme().black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 17,
                                ),
                          ),
                          SizedBoxes.verticalTiny,
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: preMedPro.isPreMed
                              ? PreMedColorTheme().primaryColorRed
                              : PreMedColorTheme().blue,
                          size: 20,
                        ),
                        onPressed: () async {
                          setState(() {
                            selectedDeckItemIndex = originalIndexes[index];
                          });

                          print("Clicked Deck Index: $index");
                          print("Selected Deck Item: ${item.deckName}");
                          print(
                              "Cleaned Deck Name being passed: $cleanedDeckName");

                          try {
                            await _fetchDeckInfo(
                                selectedDeckItemIndex, context);
                            await _fetchQuestions(cleanedDeckName, context);

                            final deckInfo = Provider.of<PaperProvider>(context,
                                    listen: false)
                                .deckInformation;

                            print(
                                "Already attempted: ${deckInfo?.alreadyAttempted}");

                            if (deckInfo?.alreadyAttempted == true) {
                              _showAlreadyAttemptedPopup(
                                  context, item, cleanedDeckName);
                            } else {
                              _navigateToDeck(context, item);
                            }
                          } catch (e) {
                            print('Error occurred: $e');
                          }
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  void _showAlreadyAttemptedPopup(
      BuildContext context, DeckItem item, String cleanedDeckName) {
    final userName =
        Provider.of<UserProvider>(context, listen: false).getUserName();
    final lastAttempt = Provider.of<PaperProvider>(context, listen: false)
        .deckInformation
        ?.attempts;
    final lastAttemptId = Provider.of<PaperProvider>(context, listen: false)
        .deckInformation
        ?.lastAttemptId;

    print("Deck Name passed to showAlreadyAttemptedPopup: $cleanedDeckName");

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text(
              'Paper already attempted!',
              style: PreMedTextTheme()
                  .body
                  .copyWith(fontWeight: FontWeight.w600, fontSize: 18),
            ),
          ),
          content: Text(
            'Hey $userName, it looks like you have already attempted this paper. You can choose to review the answers and explanations from your previous attempt or re-attempt the same paper again. However, if you choose to re-attempt this paper, you will lose the scorecard and review session from your previous attempt.',
          ),
          actions: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 120,
                      child: CustomButton(
                        buttonText: 'Re-Attempt',
                        onPressed: () {
                          setState(() {
                            isContinuingAttempt = false;
                          });
                          Navigator.pop(context);
                          _navigateToDeck(context, item);
                        },
                        color: Colors.amber[900],
                        fontSize: 13,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBoxes.horizontalMicro,
                    SizedBox(
                      width: 100,
                      child: CustomButton(
                        buttonText: 'Continue Attempt',
                        onPressed: () async {
                          setState(() {
                            isContinuingAttempt = true;
                          });
                          Navigator.pop(context);
                          if (lastAttempt != null && lastAttempt.isNotEmpty) {
                            final latestAttempt = lastAttempt.last;
                            final questionProvider =
                                Provider.of<QuestionProvider>(context,
                                    listen: false);
                            print(
                                "DEBUG: Latest Attempt Question ID: ${latestAttempt['questionId']}");

                            final startFromQuestion = questionProvider.questions
                                    ?.indexWhere((question) =>
                                        question.questionId ==
                                        latestAttempt['questionId']) ??
                                0;

                            print(
                                "DEBUG: Start from Question Index: $startFromQuestion");
                            print(
                                "DEBUG: Available Questions: ${questionProvider.questions?.map((q) => q.questionId).toList()}");

                            if (startFromQuestion >= 0) {
                              _navigateToNextScreen(context, item,
                                  startFromQuestion: startFromQuestion,
                                  attemptId: lastAttemptId);
                            } else {
                              print(
                                  "DEBUG: Invalid Question ID in Latest Attempt, starting from the beginning.");
                              _navigateToNextScreen(context, item,
                                  attemptId: lastAttemptId);
                            }
                          } else {
                            _navigateToNextScreen(context, item,
                                attemptId: lastAttemptId);
                          }
                        },
                        color: Colors.blueAccent,
                        fontSize: 13,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                SizedBoxes.verticalMedium,
                SizedBox(
                  width: 100,
                  child: CustomButton(
                    buttonText: 'Review Answers',
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {
                        isContinuingAttempt = false;
                      });
                      _navigateToNextScreen(context, item,
                          isReview: true, startFromQuestion: 0);
                    },
                    color: Colors.green,
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                  ),
                )
              ],
            ),
          ],
        );
      },
    );
  }

  void _navigateToDeck(BuildContext context, DeckItem item) {
    final deckInfo =
        Provider.of<PaperProvider>(context, listen: false).deckInformation;

    if (deckInfo == null) {
      print('Deck information is null, cannot navigate');
      return;
    }
    final totalQuestions = deckInfo.questions.length;

    print("Total questions from DeckInformation: $totalQuestions");

    if (totalQuestions == 0) {
      print("No questions available");
      return;
    }

    final deckName = newdeckname(item.deckName);
    print("Navigating to Deck: $deckName");

    if (widget.bankOrMock == 'Bank') {
      print("This is the ques ${deckInfo.questions}");

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PracticeandPast(
            subject: widget.deckGroup.deckGroupName,
            deckDetails: {
              'deckName': deckName,
              'isTutorModeFree': item.isTutorModeFree,
              'deckInstructions': item.deckInstructions,
              'questions': totalQuestions.toString(),
              'timedTestMinutes': item.timesTestminutes,
            },
            premiumtag: item.premiumTag ?? '',
            deckGroupName: widget.category ?? '',
            totalquestions: totalQuestions,
            questionlist: deckInfo.questions,
          ),
        ),
      );
    } else {
      print("This is the ${deckInfo.questions}");

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DeckInstructions(
            subject: widget.subject,
            deckInstructions: item.deckInstructions,
            deckGroup: widget.deckGroup,
            selectedIndex: selectedDeckItemIndex,
            totalquestions: totalQuestions,
            questionlist: deckInfo.questions,
          ),
        ),
      );
    }
  }

  void _navigateToNextScreen(BuildContext context, DeckItem item,
      {int? startFromQuestion,
      String? attemptId,
      bool isReview = false}) async {
    final deckAttemptProvider =
        Provider.of<CreateDeckAttemptProvider>(context, listen: false);
    final deckInfo =
        Provider.of<PaperProvider>(context, listen: false).deckInformation;

    final attemptMode = deckInfo?.attemptMode ?? '';
    final questionProvider =
        Provider.of<QuestionProvider>(context, listen: false);
    final totalQuestions = questionProvider.questions?.length ?? 0;

    int questionIndex = startFromQuestion ?? 0;
    if (questionIndex < 0 || questionIndex >= totalQuestions) {
      questionIndex = 1;
    }

    if (isReview) {
      _startReviewMode(context, item, attemptMode, deckAttemptProvider,
          questionIndex, attemptId);
    } else {
      print("when nav $attemptMode, $questionIndex, $attemptId");
      _continueOrReattempt(context, item, attemptMode, deckAttemptProvider,
          questionIndex, attemptId);
    }
  }

  void _startReviewMode(
      BuildContext context,
      DeckItem item,
      String attemptMode,
      CreateDeckAttemptProvider deckAttemptProvider,
      int questionIndex,
      String? attemptId) {
    final deckInfo =
        Provider.of<PaperProvider>(context, listen: false).deckInformation;

    String cleanedDeckName =
        newdeckname(widget.deckGroup.deckItems[selectedDeckItemIndex].deckName);

    if (!item.isPublished) {
      print("Attempting to continue an unpublished deck, operation aborted.");
      return;
    }
    final String lastDone = deckInfo?.lastDone ?? '';
    if (lastDone == 'Practice') {
      cleanedDeckName = "$cleanedDeckName Practice";
    } else {
      cleanedDeckName = "$cleanedDeckName Past Paper";
    }

    if (attemptMode == 'TUTORMODE') {
      print(
          "This is the deck name when continuing attempt: $cleanedDeckName and $questionIndex");

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TutorMode(
            isContinuingAttempt: false,
            subject: widget.subject,
            deckName: cleanedDeckName,
            attemptId: attemptId ?? deckAttemptProvider.attemptId,
            startFromQuestion: 0,
            isReview: true,
            totalquestions: deckInfo!.questions.length,
            questionlist: deckInfo.questions,
            lastdone: lastDone,
          ),
        ),
      );
    } else if (attemptMode == 'TESTMODE') {
      print(
          "This is the deck name when continuing attempt: $cleanedDeckName and $questionIndex");

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TutorMode(
            isRecent: false,
            isContinuingAttempt: false,
            subject: widget.subject,
            deckName: cleanedDeckName,
            attemptId: attemptId ?? deckAttemptProvider.attemptId,
            startFromQuestion: 0,
            isReview: true,
            totalquestions: deckInfo!.questions.length,
            questionlist: deckInfo.questions,
            lastdone: lastDone,
          ),
        ),
      );
    } else {
      print("Error: Unknown attempt mode");
    }
  }

  void _continueOrReattempt(
      BuildContext context,
      DeckItem item,
      String attemptMode,
      CreateDeckAttemptProvider deckAttemptProvider,
      int questionIndex,
      String? attemptId) {
    final deckInfo =
        Provider.of<PaperProvider>(context, listen: false).deckInformation;

    String cleanedDeckName =
        newdeckname(widget.deckGroup.deckItems[selectedDeckItemIndex].deckName);

    if (!item.isPublished) {
      print("Attempting to continue an unpublished deck, operation aborted.");
      return;
    }
    final String lastDone = deckInfo?.lastDone ?? '';
    if (lastDone == 'Practice') {
      cleanedDeckName = "$cleanedDeckName Practice";
    } else {
      cleanedDeckName = "$cleanedDeckName Past Paper";
    }

    if (attemptMode == 'TUTORMODE') {
      print(
          "This is the deck name when continuing attempt: $cleanedDeckName and $questionIndex");

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TutorMode(
            isContinuingAttempt: isContinuingAttempt,
            subject: widget.subject,
            deckName: cleanedDeckName,
            attemptId: attemptId ?? deckAttemptProvider.attemptId,
            startFromQuestion: questionIndex,
            isReview: false,
            totalquestions: deckInfo!.questions.length,
            questionlist: deckInfo.questions,
            lastdone: lastDone,
          ),
        ),
      );
    } else if (attemptMode == 'TESTMODE') {
      print(
          "This is the deck name when continuing attempt: $cleanedDeckName and $questionIndex");

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TutorMode(
            isRecent: false,
            isContinuingAttempt: isContinuingAttempt,
            subject: widget.subject,
            deckName: cleanedDeckName,
            attemptId: attemptId ?? deckAttemptProvider.attemptId,
            startFromQuestion: questionIndex,
            isReview: false,
            totalquestions: deckInfo!.questions.length,
            questionlist: deckInfo.questions,
            lastdone: lastDone,
          ),
        ),
      );
    } else {
      print("Error: Unknown attempt mode");
    }
  }
}
