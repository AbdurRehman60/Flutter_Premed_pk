import 'package:flutter_svg/svg.dart';
import 'package:premedpk_mobile_app/UI/Widgets/global_widgets/custom_button.dart';
import 'package:premedpk_mobile_app/UI/screens/qbank/widgets/test_mode_page.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/vaultProviders/premed_provider.dart';
import 'package:provider/provider.dart';
import '../../../../models/deck_group_model.dart';
import '../../../../providers/create_deck_attempt_provider.dart';
import '../../../../providers/deck_info_provider.dart';
import '../../../../providers/question_provider.dart';
import '../../../../providers/user_provider.dart';
import '../../Test Interface/test_interface_home.dart';
import '../../Test Interface/widgets/tutor_mode_test_interface.dart';
import '../../qbank/widgets/logo_avatar.dart';
import 'deck_instructions.dart';

class CustomBottomSheet extends StatefulWidget {
  const CustomBottomSheet({
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
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  late int selectedDeckItemIndex;
  bool isContinuingAttempt = false;

  Future<void> _fetchDeckInfo(int originalIndex, BuildContext context) async {
    final userId =
        Provider.of<UserProvider>(context, listen: false).user?.userId;
    final category = widget.category ?? '';
    final deckGroup = widget.deckGroup.deckGroupName;
    final deckName = widget.deckGroup.deckItems[originalIndex].deckName;

    try {
      await Provider.of<DeckProvider>(context, listen: false)
          .fetchDeckInformation(category, deckGroup, deckName, userId!);
    } catch (e) {
      print('Error fetching deck information: $e');
    }
  }

  Future<void> _fetchQuestions(String deckName, BuildContext context) async {
    await Provider.of<QuestionProvider>(context, listen: false)
        .fetchQuestions(deckName, 1);
  }

  @override
  Widget build(BuildContext context) {
    final accessTags =
        Provider.of<UserProvider>(context, listen: false).getTags();
    final preMedPro = context.read<PreMedProvider>();

    final List<Map<String, dynamic>> publishedDecks = widget.deckGroup.deckItems
        .asMap()
        .entries
        .where((entry) => entry.value.isPublished)
        .map((entry) => {'deck': entry.value, 'originalIndex': entry.key})
        .toList();

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
                itemCount: publishedDecks.length,
                itemBuilder: (context, index) {
                  final deckMap = publishedDecks[index];
                  final DeckItem item = deckMap['deck'];
                  final int originalIndex = deckMap['originalIndex'];

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
                            item.deckName,
                            style: PreMedTextTheme().body.copyWith(
                                  color: PreMedColorTheme().black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 17,
                                ),
                          ),
                          SizedBoxes.verticalTiny,
                          if (item.isTutorModeFree || item.premiumTags.isEmpty)
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
                                  item.premiumTags.join(', '),
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
                      trailing: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: preMedPro.isPreMed
                            ? PreMedColorTheme().primaryColorRed
                            : PreMedColorTheme().blue,
                        size: 20,
                      ),
                      onTap: () async {
                        if (_hasAccess(item.premiumTags, accessTags,
                            item.isTutorModeFree)) {
                          setState(() {
                            selectedDeckItemIndex = originalIndex;
                          });
                          await _fetchDeckInfo(originalIndex, context);
                          await _fetchQuestions(item.deckName, context);

                          final deckInfo =
                              Provider.of<DeckProvider>(context, listen: false)
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
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  void _navigateToDeck(BuildContext context, DeckItem item) {
    final deckInfo =
        Provider.of<DeckProvider>(context, listen: false).deckInformation;
    if (deckInfo == null) {
      return;
    }
    final totalQuestions = deckInfo.questions.length;

    if (totalQuestions == 0) {
      return;
    }

    if (widget.bankOrMock == 'Bank') {
      print("yeh hei tot ques transfered to testint ${totalQuestions}");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TestModeInterface(
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
            premiumtag: item.premiumTags ?? [],
            deckGroupName: widget.category ?? '',
            totalquestions: totalQuestions ,
            questionlist: deckInfo.questions,
          ),
        ),
      );
    } else {
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
                  istimedtestmode: item.timedTestMode,
                )),
      );
    }
  }

  void _showAlreadyAttemptedPopup(BuildContext context, DeckItem item) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final accessTags = userProvider.getTags();
    final bool hasFullAccess =
        _hasAccess(item.premiumTags, accessTags, item.isTutorModeFree);

    final userName = userProvider.getUserName();
    final lastAttempt = Provider.of<DeckProvider>(context, listen: false)
        .deckInformation
        ?.attempts;
    final lastAttemptId = Provider.of<DeckProvider>(context, listen: false)
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
                          if (hasFullAccess) {
                            setState(() {
                              isContinuingAttempt = false;
                            });
                            Navigator.pop(context);
                            _navigateToDeck(context, item);
                          } else {
                            _showPurchasePopup(context);
                          }
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
                          if (hasFullAccess) {
                            setState(() {
                              isContinuingAttempt = true;
                            });
                            Navigator.pop(context);
                            if (lastAttempt != null && lastAttempt.isNotEmpty) {
                              final latestAttempt = lastAttempt.last;
                              final questionProvider =
                                  Provider.of<QuestionProvider>(context,
                                      listen: false);

                              final startFromQuestion = questionProvider
                                      .questions
                                      .indexWhere((question) =>
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
                          } else {
                            _showPurchasePopup(context);
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
                      if (hasFullAccess) {
                        Navigator.pop(context);
                        setState(() {
                          isContinuingAttempt = false;
                        });
                        _navigateToNextScreen(context, item,
                            isReview: true, startFromQuestion: 0);
                      } else {
                        _showPurchasePopup(context);
                      }
                    },
                    color: Colors.green,
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  bool _hasAccess(
      List<String>? premiumTags, Object? accessTags, bool? isPastPaperFree) {
    // Grant access if the paper is free, or if there are no premium tags
    if (isPastPaperFree == true || premiumTags == null || premiumTags.isEmpty) {
      return true;
    }

    // Define access mappings for different tag groups
    final List<String> mdcatTags = ['MDCAT-Topicals', 'MDCAT-Yearly'];
    final List<String> numsTags = ['NUMS-Topicals', 'NUMS-Yearly'];
    final List<String> privTags = ['AKU-Topicals', 'AKU-Yearly'];

    // Ensure accessTags is a list of dynamic objects
    if (accessTags is List<dynamic>) {
      for (final premiumTag in premiumTags) {
        for (final access in accessTags) {
          if (access is Map<String, dynamic>) {
            // Direct match
            if (access['name'] == premiumTag) {
              return true;
            }

            // Group match for predefined tags
            if ((premiumTag == 'MDCAT-QBank' &&
                    mdcatTags.contains(access['name'])) ||
                (premiumTag == 'NUMS-QBank' &&
                    numsTags.contains(access['name'])) ||
                (premiumTag == 'AKU-QBank' &&
                    privTags.contains(access['name']))) {
              return true;
            }
          }
        }
      }
    }

    // Access denied if no match is found
    return false;
  }

  void _showPurchasePopup(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final String appToken = userProvider.user?.info.appToken ?? '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            children: [
              SvgPicture.asset('assets/icons/lock.svg'),
              SizedBox(height: 10),
              const Center(
                child: Text(
                  'Oh No! It’s Locked',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 25,
                    color: Color(0xFFFE63C49),
                  ),
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(
                'Looks like this feature is not included in your plan. Upgrade to a higher plan or purchase this feature separately to continue.',
              ),
              SizedBox(height: 10),
              Text(
                'Visit PreMed.PK for more details.',
              ),
            ],
          ),
          actions: [
            Center(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFFE6E6E6),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Return',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFFFE63C49),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _navigateToNextScreen(BuildContext context, DeckItem item,
      {int? startFromQuestion,
      String? attemptId,
      bool isReview = false}) async {
    final deckAttemptProvider =
        Provider.of<CreateDeckAttemptProvider>(context, listen: false);
    final deckInfo =
        Provider.of<DeckProvider>(context, listen: false).deckInformation;

    final attemptMode = deckInfo?.attemptMode ?? '';
    final questionProvider =
        Provider.of<QuestionProvider>(context, listen: false);
    final totalQuestions = questionProvider.questions.length ?? 0;

    int questionIndex = startFromQuestion ?? 0;
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
        Provider.of<DeckProvider>(context, listen: false).deckInformation;
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
            isReview: true,
            totalquestions: deckInfo!.questions.length,
            questionlist: deckInfo.questions,
            lastdone: '',
          ),
        ),
      );
    } else if (attemptMode == 'TESTMODE') {
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
            isReview: true,
            totalquestions: deckInfo!.questions.length,
            questionlist: deckInfo.questions,
          ),
        ),
      );
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
        Provider.of<DeckProvider>(context, listen: false).deckInformation;
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
            lastdone: '',
          ),
        ),
      );
    } else if (attemptMode == 'TESTMODE') {
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
    }
  }
}
