import 'package:premedpk_mobile_app/UI/Widgets/global_widgets/custom_button.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';

import '../../../../models/deck_group_model.dart';

class DeckInstructions extends StatefulWidget {
  const DeckInstructions(
      {super.key,
      required this.deckInstructions,
      required this.deckGroup,
      required this.selectedIndex});

  final String deckInstructions;
  final DeckGroupModel deckGroup;
  final int selectedIndex;

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
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
                              buttonText: 'Start Test', onPressed: () {}),
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
            ]),
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
