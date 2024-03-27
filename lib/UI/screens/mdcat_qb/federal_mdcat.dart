import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:premedpk_mobile_app/UI/screens/mdcat_qb/customised_buttons/tutormode_button.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/UI/Widgets/global_widgets/custom_button.dart';

class FederalMdcat extends StatefulWidget {
  const FederalMdcat({super.key});

  @override
  State<FederalMdcat> createState() => _FederalMdcatState();
}

class _FederalMdcatState extends State<FederalMdcat> {
  late Future<Map<String, dynamic>> deckInformation;

  @override
  void initState() {
    super.initState();
    deckInformation = fetchDeckInformation();
  }

  Future<Map<String, dynamic>> fetchDeckInformation() async {
    final response = await http.post(
      Uri.parse('https://prodapi.premed.pk/api/decks/get-deck-information/Federal%20MDCAT%202023'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load deck information');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
              icon: Icon(Icons.arrow_back_ios_new_rounded,
                  color: PreMedColorTheme().primaryColorRed),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Federal MDCAT',
                  style: PreMedTextTheme().heading1
                      .copyWith(color: PreMedColorTheme().black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Text(
                  'MDCAT QBANK',
                  style: PreMedTextTheme()
                      .subtext1
                      .copyWith(color: PreMedColorTheme().primaryColorRed),
                ),
              ),
              SizedBoxes.verticalTiny,
              const TutorMode(),
              SizedBoxes.verticalMedium,
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: PreMedColorTheme().neutral100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Image.asset(
                          'assets/images/QuestionMarkDocument.png',
                          width: 34, // adjust width as needed
                          height: 34,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text('TUTOR MODE',
                          style: PreMedTextTheme().subtext.copyWith(
                              color: PreMedColorTheme().primaryColorRed)),
                      SizedBoxes.verticalMicro,
                      Container(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, bottom: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildBulletPoint('This paper is NOT timed'),
                            _buildBulletPoint(
                                'The correct answer and explanation will be shown instantly once you select any option'),
                            _buildBulletPoint(
                                "Timer and detailed score report are NOT available in Tutor Mode and can be accessed in Timed Test Mode"),
                            SizedBoxes.verticalMedium,
                            Center(
                              child: CustomButton(
                                  buttonText: "Start Test",
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  }),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBoxes.verticalMedium,
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: PreMedColorTheme().neutral100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0, left: 8),
                            child: Text(
                              'INSTRUCTIONS',
                              style: PreMedTextTheme().subtext.copyWith(color: PreMedColorTheme().black),
                            ),
                          ),
                        ],
                      ),
                      SizedBoxes.verticalMicro,
                      FutureBuilder<Map<String, dynamic>>(
                        future: deckInformation,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            print(snapshot.data);
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (var instruction in _parseInstructions(snapshot.data!['deck']['deckInstructions']))
                                    _buildBulletPoint(instruction),
                                ],
                              ),
                            )
                          ;
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildBulletPoint(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 8,
          child: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Icon(Icons.brightness_1, size: 8, color: Colors.black),
          ),
        ),
        SizedBox(width: 8),
        // Wrap the Wrap widget with Expanded
        Expanded(
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            children: _buildTextWithBold(text),
          ),
        ),
      ],
    ),
  );
}

List<Widget> _buildTextWithBold(String text) {
  List<Widget> textWidgets = [];
  List<String> boldWords = [
    'correct',
    'answer',
    'explanation',
    'instantly',
    'Tutor Mode',
    'Timed Test Mode',
    'TutorMode',
    'Test'
  ];

  List<String> wordsAndPhrases = text.split(RegExp(r"([\s'])"));

  for (String word in wordsAndPhrases) {
    bool isBold = boldWords.any((boldWord) => word
        .replaceAll("'", "")
        .toLowerCase()
        .contains(boldWord.toLowerCase()));

    if (word.replaceAll("'", "").toLowerCase() == 'tutormode' ||
        word.replaceAll("'", "").toLowerCase() == 'tutor' ||
        word.replaceAll("'", "").toLowerCase() == 'mode') {
      isBold = true;
    }

    if (word == 'Timed' ||
        (word.length > 1 &&
            word[0] == word[0].toUpperCase() &&
            word.substring(1) == 'Timed')) {
      isBold = true;
    }

    textWidgets.add(
      Text(
        word,
        style:
            TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
      ),
    );
    textWidgets.add(SizedBox(width: 4));
  }

  return textWidgets;
}

List<String> _parseInstructions(String instructionsHtml) {

  instructionsHtml = instructionsHtml.replaceAll('<ul>', '');
  instructionsHtml = instructionsHtml.replaceAll('</ul>', '');

  List<String> instructions = instructionsHtml.split('<li>');

  instructions.removeAt(0);

  instructions = instructions.map((instruction) {
    return instruction.replaceAll('</li>', '').trim();
  }).toList();

  return instructions;
}

