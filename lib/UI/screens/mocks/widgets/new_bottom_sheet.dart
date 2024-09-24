import 'package:premedpk_mobile_app/UI/screens/qbank/widgets/practice_and_past.dart';
import 'package:premedpk_mobile_app/providers/paper_provider.dart';
import 'package:provider/provider.dart';

import '../../../../constants/constants_export.dart';
import '../../../../models/deck_group_model.dart';
import '../../../../providers/create_deck_attempt_provider.dart';
import '../../../../providers/deck_info_provider.dart';
import '../../../../providers/question_provider.dart';
import '../../../../providers/user_provider.dart';
import '../../../../providers/vaultProviders/premed_provider.dart';
import '../../../Widgets/global_widgets/custom_button.dart';
import '../../Test Interface/test_interface_home.dart';
import '../../Test Interface/widgets/tutor_mode_test_interface.dart';
import '../../qbank/widgets/logo_avatar.dart';
import '../../qbank/widgets/prac_and_past_instruc.dart';
import '../../qbank/widgets/test_mode_page.dart';
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
    final deckName = newdeckname(widget.deckGroup.deckItems[index].deckName);

    final category = widget.category ?? '';
    final deckGroup = widget.deckGroup.deckGroupName;
    final userId = userProvider.user!.userId;

    // Debugging: print deckItems and index
    print(
        'deckItems: ${widget.deckGroup.deckItems}, Type: ${widget.deckGroup.deckItems.runtimeType}');
    print('index: $index, Type: ${index.runtimeType}');

    // Check if index is within bounds
    if (index < widget.deckGroup.deckItems.length) {
      final deckName = newdeckname(widget.deckGroup.deckItems[index].deckName);
      print('Deck Name: $deckName');
    } else {
      print(
          'Error: Index $index out of bounds for deckItems length ${widget.deckGroup.deckItems.length}');
      return;
    }

    print("Fetching deck info for:");
    print("Category: $category (Type: ${category.runtimeType})");
    print("Deck Group: $deckGroup (Type: ${deckGroup.runtimeType})");
    print("Deck Name: $deckName (Type: ${deckName.runtimeType})");
    print("User ID: $userId (Type: ${userId.runtimeType})");

    try {
      await Provider.of<PaperProvider>(context, listen: false)
          .fetchPapers(category, deckGroup, deckName, userId);

      final deckInfo =
          Provider.of<PaperProvider>(context, listen: false).deckInformation;
      print("Fetched deck information: $deckInfo");

      if (deckInfo == null) {
        print('Deck information is null');
      } else {
        print('alreadyAttempted: ${deckInfo.alreadyAttempted}');
        print('Total questions: ${deckInfo.questions.length}');
      }
    } catch (e) {
      print('Error fetching deck information: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Set<String> uniquedecknames = {};
    List<DeckItem> uniquedeckitems = [];

    print('Deck items: ${widget.deckGroup.deckItems}');

    for (var item in widget.deckGroup.deckItems) {
      String newcleandeckname = newdeckname(item.deckName);
      if (!uniquedecknames.contains(newcleandeckname)) {
        uniquedecknames.add(newcleandeckname);
        uniquedeckitems.add(item);
      }
    }

    // Debugging for unique deck names and items
    print('Unique deck names: $uniquedecknames');
    print('Unique deck items: $uniquedeckitems');

    final accessTags =
        Provider.of<UserProvider>(context, listen: false).getTags();
    print("Access Tags: $accessTags");

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
                  if (index is! int) {
                    print(
                        "Error: index is not an int but a ${index.runtimeType}");
                  }

                  final DeckItem item =
                      uniquedeckitems[index]; // Accessing deck item by index
                  final String deckName = newdeckname(item.deckName);

                  print("Deck Item at index $index: $deckName");

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
                            deckName,
                            style: PreMedTextTheme().body.copyWith(
                                  color: PreMedColorTheme().black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 17,
                                ),
                          ),
                          SizedBoxes.verticalTiny,
                          if (item.isTutorModeFree == true ||
                              item.premiumTag == null ||
                              item.premiumTag!.isEmpty)
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: PreMedColorTheme().greenL,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Free',
                                  style: PreMedTextTheme().body.copyWith(
                                        color: PreMedColorTheme().white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                      ),
                                ),
                              ),
                            )
                          else
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Provider.of<PreMedProvider>(context,
                                            listen: false)
                                        .isPreMed
                                    ? PreMedColorTheme().red
                                    : PreMedColorTheme().blue,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  item.premiumTag!,
                                  style: PreMedTextTheme().body.copyWith(
                                        color: PreMedColorTheme().white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                      ),
                                ),
                              ),
                            ),
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
                          if (_hasAccess(item.premiumTag, accessTags,
                              item.isTutorModeFree)) {
                            setState(() {
                              selectedDeckItemIndex = index;
                            });
                            await _fetchDeckInfo(index, context);
                            await _fetchQuestions(item.deckName, context);

                            final deckInfo = Provider.of<PaperProvider>(context,
                                    listen: false)
                                .deckInformation;
                            if (deckInfo?.alreadyAttempted == true) {
                              _showAlreadyAttemptedPopup(context, item);
                            } else {
                              _navigateToDeck(context, item);
                            }
                          } else {
                            _showPurchasePopup(context);
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

  bool _hasAccess(
      String? premiumTag, Object? accessTags, bool? isTutorModeFree) {
    if (isTutorModeFree == true || premiumTag == null || premiumTag.isEmpty) {
      return true;
    }

    final List<String> mdcatTags = ['MDCAT-Topicals', 'MDCAT-Yearly'];
    final List<String> numsTags = ['NUMS-Topicals', 'NUMS-Yearly'];
    final List<String> privTags = ['AKU-Topicals', 'AKU-Yearly'];

    if (accessTags is List<dynamic>) {
      for (final access in accessTags) {
        if (access is Map<String, dynamic>) {
          print(
              'Comparing premiumTag: $premiumTag with access name: ${access['name']}');

          if (access['name'] == premiumTag) {
            return true;
          }
          if ((premiumTag == 'MDCAT-QBank' &&
                  mdcatTags.contains(access['name'])) ||
              (premiumTag == 'NUMS-QBank' &&
                  numsTags.contains(access['name'])) ||
              (premiumTag == 'AKU-QBank' &&
                  privTags.contains(access['name']))) {
            print('Match found: Yes');
            return true;
          }
        }
      }
    }

    print('Match found: No');
    return false;
  }

  void _showPurchasePopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Purchase Required"),
          content: const Text(
              "You need to purchase the required bundle to access this content."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("OK"),
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

    if (widget.bankOrMock == 'Bank') {
      print("This is the ques ${deckInfo.questions}");

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PracticeandPast(
            subject: widget.deckGroup.deckGroupName,
            deckDetails: {
              'deckName':
                  widget.deckGroup.deckItems[selectedDeckItemIndex].deckName,
              'isTutorModeFree': widget
                  .deckGroup.deckItems[selectedDeckItemIndex].isTutorModeFree,
              'deckInstructions': widget
                  .deckGroup.deckItems[selectedDeckItemIndex].deckInstructions,
              'questions': totalQuestions.toString(),
              'timedTestMinutes': widget
                  .deckGroup.deckItems[selectedDeckItemIndex].timesTestminutes,
            },
            premiumtag:
                widget.deckGroup.deckItems[selectedDeckItemIndex].premiumTag ??
                    '',
            deckGroupName: widget.category ?? '',
            totalquestions: totalQuestions,
            questionlist: deckInfo.questions,
          ),
        ),
      );
    } else {
      print("This is the ${deckInfo?.questions}");

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

  void _showAlreadyAttemptedPopup(BuildContext context, DeckItem item) {
    final userName =
        Provider.of<UserProvider>(context, listen: false).getUserName();
    final lastAttempt = Provider.of<PaperProvider>(context, listen: false)
        .deckInformation
        ?.attempts;
    final lastAttemptId = Provider.of<PaperProvider>(context, listen: false)
        .deckInformation
        ?.lastAttemptId;

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
                            final startFromQuestion = questionProvider.questions
                                    ?.indexWhere((question) =>
                                        question.questionId ==
                                        latestAttempt['questionId']) ??
                                0;

                            if (startFromQuestion >= 0) {
                              _navigateToNextScreen(context, item,
                                  startFromQuestion: startFromQuestion,
                                  attemptId: lastAttemptId);
                            } else {
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

    int questionIndex = (startFromQuestion ?? 0);
    if (questionIndex < 0 || questionIndex >= totalQuestions) {
      questionIndex = 1;
    }

    if (isReview) {
      _startReviewMode(
          context, item, attemptMode, deckAttemptProvider, questionIndex);
    } else {
      _continueOrReattempt(context, item, attemptMode, deckAttemptProvider,
          questionIndex, attemptId);
    }
  }

  void _startReviewMode(BuildContext context, DeckItem item, String attemptMode,
      CreateDeckAttemptProvider deckAttemptProvider, int questionIndex) {
    final deckInfo =
        Provider.of<PaperProvider>(context, listen: false).deckInformation;
    if (attemptMode == 'TUTORMODE') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TutorMode(
            isContinuingAttempt: false,
            subject: widget.subject,
            deckName:
                widget.deckGroup.deckItems[selectedDeckItemIndex].deckName,
            attemptId: deckAttemptProvider.attemptId,
            startFromQuestion: 0,
            isReview: true,
            totalquestions: deckInfo!.questions.length,
            questionlist: deckInfo.questions,
          ),
        ),
      );
    } else if (attemptMode == 'TESTMODE') {
      print(
          "this is the ques index $questionIndex & and ${deckInfo?.questions}");

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TestInterface(
            isRecent: false,
            isContinuingAttempt: false,
            subject: widget.subject,
            deckName:
                widget.deckGroup.deckItems[selectedDeckItemIndex].deckName,
            attemptId: deckAttemptProvider.attemptId,
            startFromQuestion: 0,
            isReview: true,
            totalquestions: deckInfo!.questions.length,
            questionlist: deckInfo.questions,
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
    if (attemptMode == 'TUTORMODE') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TutorMode(
            isContinuingAttempt: isContinuingAttempt,
            subject: widget.subject,
            deckName:
                widget.deckGroup.deckItems[selectedDeckItemIndex].deckName,
            attemptId: attemptId ?? deckAttemptProvider.attemptId,
            startFromQuestion: questionIndex,
            isReview: false,
            totalquestions: deckInfo!.questions.length,
            questionlist: deckInfo.questions,
          ),
        ),
      );
    } else if (attemptMode == 'TESTMODE') {
      print(
          "this is the ques index $questionIndex & the attempt id is $attemptId and ${deckInfo?.questions}");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TestInterface(
            isRecent: false,
            isContinuingAttempt: isContinuingAttempt,
            subject: widget.subject,
            deckName:
                widget.deckGroup.deckItems[selectedDeckItemIndex].deckName,
            attemptId: attemptId ?? deckAttemptProvider.attemptId,
            startFromQuestion: questionIndex,
            isReview: false,
            totalquestions: deckInfo!.questions.length,
            questionlist: deckInfo.questions,
          ),
        ),
      );
    } else {
      print("Error: Unknown attempt mode");
    }
  }
}
