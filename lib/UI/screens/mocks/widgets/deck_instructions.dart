import 'package:flutter/material.dart';
import 'package:html/parser.dart' as htmlParser;
import 'package:premedpk_mobile_app/UI/Widgets/global_widgets/custom_button.dart';
import 'package:premedpk_mobile_app/UI/screens/Test Interface/test_interface_home.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/models/create_deck_attemot_model.dart';
import 'package:provider/provider.dart';
import '../../../../models/deck_group_model.dart';
import '../../../../providers/create_deck_attempt_provider.dart';
import '../../../../providers/user_provider.dart';

class DeckInstructions extends StatefulWidget {
  const DeckInstructions({
    super.key,
    required this.deckInstructions,
    required this.deckGroup,
    required this.selectedIndex,
    required this.subject,
    required this.totalquestions,
    this.questionlist,
    this.istimedtestmode,
  });

  final List<String>? questionlist;
  final bool? istimedtestmode;
  final int totalquestions;
  final String deckInstructions;
  final DeckGroupModel deckGroup;
  final int selectedIndex;
  final String subject;

  @override
  State<DeckInstructions> createState() => _DeckInstructionsState();
}

class _DeckInstructionsState extends State<DeckInstructions> {
  String cleanInstructions = '';
  String selectedMode = 'TestMode';

  @override
  void initState() {
    super.initState();
    final parsedInstructions = parseHtmlInstructions(widget.deckInstructions);
    cleanInstructions = formatInstructions(parsedInstructions);
  }

  @override
  Widget build(BuildContext context) {
    final selectedDeckItem = widget.deckGroup.deckItems[widget.selectedIndex];

    return Scaffold(
      backgroundColor: PreMedColorTheme().primaryColorRed100,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          backgroundColor: PreMedColorTheme().primaryColorRed100,
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
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_new_rounded,
                  color: PreMedColorTheme().primaryColorRed),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          automaticallyImplyLeading: false,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  selectedDeckItem.deckName,
                  style: PreMedTextTheme().heading6.copyWith(
                    color: PreMedColorTheme().black,
                    fontSize: 34,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBoxes.verticalMedium,
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Material(
                    elevation: 8,
                    borderRadius: BorderRadius.circular(10),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 11),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            SizedBox(
                                width: 34,
                                height: 34,
                                child: Image.asset(
                                  'assets/images/Question Bank.png',
                                )),
                            SizedBoxes.verticalMedium,
                            Text(
                              'MOCK MODE',
                              style: PreMedTextTheme().body.copyWith(
                                  color: PreMedColorTheme().primaryColorRed,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16),
                            ),
                            SizedBoxes.verticalTiny,
                            Text(
                              '${widget.totalquestions} Mcqs',
                              style: PreMedTextTheme().body.copyWith(
                                  color: PreMedColorTheme().black,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 14),
                            ),
                            SizedBoxes.verticalTiny,
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: const BulletedList(
                                items: [
                                  '• This paper is timed',
                                  '• The correct answer and explanation will be shown instantly once you select any option',
                                ],
                              ),
                            ),

                            SizedBoxes.verticalMedium,
                            CustomButton(
                              buttonText: 'Start Test',
                              onPressed: () async {
                                final userProvider = Provider.of<UserProvider>(context, listen: false);
                                final userId = userProvider.user?.userId ?? '';

                                if (userId.isNotEmpty) {
                                  if (widget.istimedtestmode == true) {
                                    selectedMode = 'TESTMODE';
                                  } else {
                                    selectedMode = 'TUTORMODE';
                                  }
                                  _handleStartTest(context, selectedDeckItem, userId, selectedMode);
                                }
                              },
                            ),
                            SizedBoxes.verticalMedium,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBoxes.verticalLarge,
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Material(
                    elevation: 8,
                    borderRadius: BorderRadius.circular(10),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'INSTRUCTIONS',
                                  style: PreMedTextTheme().body.copyWith(
                                      fontWeight: FontWeight.w800, fontSize: 17),
                                ),
                                BulletedList(
                                  items: cleanInstructions.split('\n'),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleStartTest(BuildContext context, DeckItem selectedDeckItem, String userId, String selectedMode) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    bool isFreeMode = (selectedMode == 'TUTORMODE')
        ? selectedDeckItem.isTutorModeFree ?? false
        : selectedDeckItem.premiumTags == null || selectedDeckItem.premiumTags!.isEmpty;

    if (isFreeMode || _hasAccess(selectedDeckItem.premiumTags, userProvider.getTags())) {
      final attemptModel = CreateDeckAttemptModel(
        deckName: selectedDeckItem.deckName,
        attemptMode: selectedMode.toLowerCase(),
        user: userId,
      );
      final deckAttemptProvider = Provider.of<CreateDeckAttemptProvider>(context, listen: false);
      await deckAttemptProvider.createDeckAttempt(attemptModel);

      if (deckAttemptProvider.responseMessage == 'Attempt created successfully') {
        final attemptId = deckAttemptProvider.attemptId;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TestInterface(
              isReview: false,
              isRecent: false,
              isContinuingAttempt: false,
              subject: widget.subject,
              deckName: selectedDeckItem.deckName,
              attemptId: attemptId,
              totalquestions: widget.totalquestions,
              questionlist: widget.questionlist,
            ),
          ),
        );
      } else {
        _showErrorPopup(context, deckAttemptProvider.responseMessage);
      }
    } else {
      _showPurchasePopup(context);
    }
  }

  bool _hasAccess(List<String>? premiumTags, Object? accessTags) {
    // Grant access if the paper is free, or if there are no premium tags
    if (premiumTags == null || premiumTags.isEmpty) {
      return true;
    }

    // Define access mappings for different tag groups
    final List<String> mdcatTags = ['MDCAT-Topicals', 'MDCAT-Yearly'];
    final List<String> numsTags = ['NUMS-Topicals', 'NUMS-Yearly'];
    final List<String> privTags = ['AKU-Topicals', 'AKU-Yearly'];

    // Ensure accessTags is a list of dynamic objects
    if (accessTags is List<dynamic>) {
      for (final premiumTag in premiumTags) {
        bool foundMatch = false;

        for (final access in accessTags) {
          if (access is Map<String, dynamic>) {
            if (access['name'] == premiumTag) {
              print('Match found: premiumTag "$premiumTag" matches with accessTag "${access['name']}"');
              return true;
            }

            // Group match for predefined tags
            if ((premiumTag == 'MDCAT-QBank' && mdcatTags.contains(access['name'])) ||
                (premiumTag == 'NUMS-QBank' && numsTags.contains(access['name'])) ||
                (premiumTag == 'AKU-QBank' && privTags.contains(access['name']))) {
              print('Match found: premiumTag "$premiumTag" matches with group tag "${access['name']}"');
              return true;
            }
          }
        }

        // If no match was found for the current premiumTag
        if (!foundMatch) {
          print('No match found for premiumTag "$premiumTag" in accessTags.');
        }
      }
    }

    // Access denied if no match is found
    print('Access denied: No matches found for premiumTags.');
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

  void _showErrorPopup(BuildContext context, String? message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text(message ?? 'Unknown error occurred'),
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
}
String parseHtmlInstructions(String htmlString) {
  final document = htmlParser.parse(htmlString);
  return document.body?.text ?? '';
}
String formatInstructions(String instructions) {
  List<String> sections = instructions.split('.');
  sections = sections.where((section) => section.trim().isNotEmpty).toList();
  return sections.map((section) => '• ${section.trim()}').join('\n');
}

class BulletedList extends StatelessWidget {
  const BulletedList({super.key, required this.items});

  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(items.length, (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(items[index]),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}