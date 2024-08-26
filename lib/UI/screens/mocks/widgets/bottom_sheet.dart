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

  Future<void> _fetchDeckInfo(int index, BuildContext context) async {
    final userId = Provider.of<UserProvider>(context, listen: false).user?.userId;
    final category = widget.category ?? '';
    final deckGroup = widget.deckGroup.deckGroupName;
    final deckName = widget.deckGroup.deckItems[index].deckName;

    try {
      await Provider.of<DeckProvider>(context, listen: false)
          .fetchDeckInformation(category, deckGroup, deckName, userId!);

      final deckInfo = Provider.of<DeckProvider>(context, listen: false).deckInformation;

      if (deckInfo == null) {
        print('Deck information is null');
      } else {
        print('alreadyAttempted: ${deckInfo.alreadyAttempted}');
      }
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
    final accessTags = Provider.of<UserProvider>(context, listen: false).getTags();
    print("These are the access tags $accessTags");
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
                itemCount: widget.deckGroup.deckItems.length,
                itemBuilder: (context, index) {
                  final DeckItem item = widget.deckGroup.deckItems[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: ListTile(
                      leading: GetLogo(url: widget.deckGroup.deckItems[index].deckLogo),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.deckGroup.deckItems[index].deckName,
                            style: PreMedTextTheme().body.copyWith(
                              color: PreMedColorTheme().black,
                              fontWeight: FontWeight.w700,
                              fontSize: 17,
                            ),
                          ),
                          SizedBoxes.verticalTiny,
                          if (widget.deckGroup.deckItems[index].premiumTag != null)
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: PreMedColorTheme().primaryColorRed,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  widget.deckGroup.deckItems[index].premiumTag!,
                                  style: PreMedTextTheme().body.copyWith(
                                    color: PreMedColorTheme().white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            )
                          else
                            const SizedBox(),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: preMedPro.isPreMed ? PreMedColorTheme().primaryColorRed : PreMedColorTheme().blue,
                          size: 20,
                        ),
                        onPressed: () async {
                          // Check if the user has access to the premium tag
                          if (_hasAccess(widget.deckGroup.deckItems[index].premiumTag, accessTags)) {
                            setState(() {
                              selectedDeckItemIndex = index;
                            });
                            await _fetchDeckInfo(index, context);
                            await _fetchQuestions(widget.deckGroup.deckItems[index].deckName, context);

                            final deckInfo = Provider.of<DeckProvider>(context, listen: false).deckInformation;
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
                      onTap: () {},
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

  bool _hasAccess(String? premiumTag, Object? accessTags) {
    if (premiumTag == null) return true;

    final List<String> mdcatTags = ['MDCAT-Topicals', 'MDCAT-Yearly'];
    final List<String> numsTags = ['NUMS-Topicals', 'NUMS-Yearly'];
    final List<String> privTags = ['AKU-Topicals', 'AKU-Yearly'];
    if (accessTags is List<dynamic>) {
      for (final access in accessTags) {
        if (access is Map<String, dynamic>) {
          print('Comparing premiumTag: $premiumTag with access name: ${access['name']}');

          if ((premiumTag == 'MDCAT-QBank' && mdcatTags.contains(access['name'])) ||
              (premiumTag == 'NUMS-QBank' && numsTags.contains(access['name'])) ||
              (premiumTag == 'AKU-Topicals' && privTags.contains(access['name'])))  {
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
          content: const Text("You need to purchase the required bundle to access this content."),
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
    if (widget.bankOrMock == 'Bank') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TestModeInterface(
            subject: widget.deckGroup.deckGroupName,
            deckDetails: {
              'deckName': widget.deckGroup.deckItems[selectedDeckItemIndex].deckName,
              'isTutorModeFree': widget.deckGroup.deckItems[selectedDeckItemIndex].isTutorModeFree,
              'deckInstructions': widget.deckGroup.deckItems[selectedDeckItemIndex].deckInstructions,
              'questions': '2',
              'timedTestMinutes': widget.deckGroup.deckItems[selectedDeckItemIndex].timesTestminutes,
            },
            deckGroupName: widget.category ?? '',
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
          ),
        ),
      );
    }
  }

  void _showAlreadyAttemptedPopup(BuildContext context, DeckItem item) {
    final userName = Provider.of<UserProvider>(context, listen: false).getUserName();
    final lastAttempt = Provider.of<DeckProvider>(context, listen: false).deckInformation?.attempts;
    final lastAttemptId = Provider.of<DeckProvider>(context, listen: false).deckInformation?.lastAttemptId;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text(
              'Paper already attempted!',
              style: PreMedTextTheme().body.copyWith(fontWeight: FontWeight.w600, fontSize: 18),
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
                      width: 130,
                      child: CustomButton(
                        buttonText: 'Continue Attempt',
                        onPressed: () async {
                          setState(() {
                            isContinuingAttempt = true;
                          });
                          Navigator.pop(context);
                          if (lastAttempt != null && lastAttempt.isNotEmpty) {
                            final latestAttempt = lastAttempt.last;
                            final questionProvider = Provider.of<QuestionProvider>(context, listen: false);
                            final startFromQuestion = questionProvider.questions
                                ?.indexWhere((question) => question.questionId == latestAttempt['questionId']) ?? 0;

                            if (startFromQuestion >= 0) {
                              _navigateToNextScreen(context, item, startFromQuestion: startFromQuestion, attemptId: lastAttemptId);
                            } else {
                              _navigateToNextScreen(context, item, attemptId: lastAttemptId);
                            }
                          } else {
                            _navigateToNextScreen(context, item, attemptId: lastAttemptId);
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
                  width: 130,
                  child: CustomButton(
                    buttonText: 'Review Answers',
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {
                        isContinuingAttempt = false;
                      });
                      _navigateToNextScreen(context, item, isReview: true, startFromQuestion: 0);
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

  void _navigateToNextScreen(BuildContext context, DeckItem item, {int? startFromQuestion, String? attemptId, bool isReview = false}) async {
    final deckAttemptProvider = Provider.of<CreateDeckAttemptProvider>(context, listen: false);
    final deckInfo = Provider.of<DeckProvider>(context, listen: false).deckInformation;

    final attemptMode = deckInfo?.attemptMode ?? '';
    final questionProvider = Provider.of<QuestionProvider>(context, listen: false);
    final totalQuestions = questionProvider.questions?.length ?? 0;

    int questionIndex = (startFromQuestion ?? 0);
    if (questionIndex < 0 || questionIndex >= totalQuestions) {
      questionIndex = 1;
    }

    if (isReview) {
      _startReviewMode(context, item, attemptMode, deckAttemptProvider, questionIndex);
    } else {
      _continueOrReattempt(context, item, attemptMode, deckAttemptProvider, questionIndex, attemptId);
    }
  }

  void _startReviewMode(BuildContext context, DeckItem item, String attemptMode, CreateDeckAttemptProvider deckAttemptProvider, int questionIndex) {
    if (attemptMode == 'TUTORMODE') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TutorMode(
            isContinuingAttempt: false,
            subject: widget.subject,
            deckName: widget.deckGroup.deckItems[selectedDeckItemIndex].deckName,
            attemptId: deckAttemptProvider.attemptId,
            startFromQuestion: 0,
            isReview: true,
          ),
        ),
      );
    } else if (attemptMode == 'TESTMODE') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TestInterface(
            isContinuingAttempt: false,
            subject: widget.subject,
            deckName: widget.deckGroup.deckItems[selectedDeckItemIndex].deckName,
            attemptId: deckAttemptProvider.attemptId,
            startFromQuestion: 0,
            isReview: true,
          ),
        ),
      );
    } else {
      print("Error: Unknown attempt mode");
    }
  }

  void _continueOrReattempt(BuildContext context, DeckItem item, String attemptMode, CreateDeckAttemptProvider deckAttemptProvider, int questionIndex, String? attemptId) {
    if (attemptMode == 'TUTORMODE') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TutorMode(
            isContinuingAttempt: isContinuingAttempt,
            subject: widget.subject,
            deckName: widget.deckGroup.deckItems[selectedDeckItemIndex].deckName,
            attemptId: attemptId ?? deckAttemptProvider.attemptId,
            startFromQuestion: questionIndex,
            isReview: false,
          ),
        ),
      );
    } else if (attemptMode == 'TESTMODE') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TestInterface(
            isContinuingAttempt: isContinuingAttempt,
            subject: widget.subject,
            deckName: widget.deckGroup.deckItems[selectedDeckItemIndex].deckName,
            attemptId: attemptId ?? deckAttemptProvider.attemptId,
            startFromQuestion: questionIndex,
            isReview: false,
          ),
        ),
      );
    } else {
      print("Error: Unknown attempt mode");
    }
  }
}
