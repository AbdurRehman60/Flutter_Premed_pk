import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/UI/Widgets/global_widgets/custom_button.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/UI/screens/Test Interface/test_interface_home.dart';
import 'package:provider/provider.dart';
import 'package:premedpk_mobile_app/models/create_deck_attemot_model.dart';
import '../../../../models/deck_group_model.dart';
import '../../../../providers/create_deck_attempt_provider.dart';
import '../../../../providers/user_provider.dart';

class DeckInstructions extends StatefulWidget {
  const DeckInstructions({
    super.key,
    required this.deckInstructions,
    required this.deckGroup,
    required this.selectedIndex, required this.subject,
  });

  final String deckInstructions;
  final DeckGroupModel deckGroup;
  final int selectedIndex;
  final String subject;

  @override
  State<DeckInstructions> createState() => _DeckInstructionsState();
}

class _DeckInstructionsState extends State<DeckInstructions> {
  String cleanInstructions = '';

  List<String> getInstructionLines() {
    return widget.deckInstructions.split('\n');
  }

  @override
  void initState() {
    super.initState();
    final rawInstructions = getInstructionLines().join('\n');
    cleanInstructions = removeHtmlTags(rawInstructions);
  }

  @override
  Widget build(BuildContext context) {
    final selectedDeckItem = widget.deckGroup.deckItems[widget.selectedIndex];
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
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
                    elevation: 3,
                    borderRadius: BorderRadius.circular(10),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
                              '200 Mcqs',
                              style: PreMedTextTheme().body.copyWith(
                                  color: PreMedColorTheme().black,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 14),
                            ),
                            SizedBoxes.verticalTiny,
                            const BulletedList(
                              items: [
                                'This paper is NOT timed',
                                'The correct answer and explanation will be shown instantly once you select any option',
                              ],
                            ),
                            SizedBoxes.verticalMedium,
                            CustomButton(
                              buttonText: 'Start Test',
                              onPressed: () async {
                                final userProvider = Provider.of<UserProvider>(context, listen: false);
                                final userId = userProvider.user?.userId ?? '';

                                if (userId.isNotEmpty) {
                                  final attemptModel = CreateDeckAttemptModel(
                                    deckName: selectedDeckItem.deckName,
                                    attemptMode: 'testmode',
                                    user: userId,
                                  );
                                  print(userId);
                                  final deckAttemptProvider = Provider.of<CreateDeckAttemptProvider>(context, listen: false);
                                  await deckAttemptProvider.createDeckAttempt(attemptModel);

                                  if (deckAttemptProvider.responseMessage == 'Attempt created successfully') {
                                    final attemptId = deckAttemptProvider.attemptId;
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => TestInterface(
                                          subject: widget.subject,
                                          deckName: selectedDeckItem.deckName,
                                          attemptId: attemptId,
                                        ),
                                      ),
                                    );
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Error'),
                                          content: Text(deckAttemptProvider.responseMessage ?? 'Unknown error occurred'),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text('OK'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
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
                    elevation: 3,
                    borderRadius: BorderRadius.circular(10),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
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

String removeHtmlTags(String htmlString) {
  String result =
  htmlString.replaceAllMapped(RegExp(r'<\/?ul[^>]*>'), (match) => '');
  result = result.replaceAllMapped(RegExp(r'<\/?li[^>]*>'), (match) => '');
  List<String> sections = result.split('.');
  sections = sections.where((section) => section.trim().isNotEmpty).toList();
  result = sections.map((section) => '• ${section.trim()}\n').join();

  return result;
}
