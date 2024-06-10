import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html/parser.dart' as htmlParser;

import '../../../../constants/constants_export.dart';
import 'mode_description_container.dart';

class TestModeInterface extends StatefulWidget {
  const TestModeInterface({
    super.key,
    required this.deckDetails,
    required this.deckGroupName,
  });

  final Map<String, dynamic> deckDetails;
  final String deckGroupName;

  @override
  State<TestModeInterface> createState() => _TestModeInterfaceState();
}

class _TestModeInterfaceState extends State<TestModeInterface> {
  late bool tutorModeButton;
  bool timeTestModeButton = false;
  String mode = 'tutorMode';

  @override
  void initState() {
    setState(() {
      tutorModeButton = widget.deckDetails['isTutorModeFree'];
    });

    super.initState();
  }

  void changeTutorMode() {
    setState(() {
      tutorModeButton = !tutorModeButton;
    });
  }

  @override
  Widget build(BuildContext context) {
    final instructions = widget.deckDetails['deckInstructions'] != null
        ? htmlParser.parse(widget.deckDetails['deckInstructions']).body!.text
        : '';

    // Split the instructions into sentences
    final sentences = instructions.split('.').where((sentence) => sentence.trim().isNotEmpty).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Material(
            elevation: 4,
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            clipBehavior: Clip.hardEdge,
            child: const SizedBox(
              height: 37,
              width: 37,
              child: Icon(
                Icons.arrow_back_ios,
                color: Color(0xFFEC5863),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 15, 16, 0),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.deckDetails['deckName'],
                    textAlign: TextAlign.start,
                    style: PreMedTextTheme().heading6.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 34,
                      color: PreMedColorTheme().black,
                    )),
                SizedBoxes.verticalLarge,
                Text(
                  widget.deckGroupName,
                  textAlign: TextAlign.start,
                  style: PreMedTextTheme().heading6.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: PreMedColorTheme().primaryColorRed,
                  ),
                ),
                SizedBoxes.vertical10Px,
                Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(10),
                  clipBehavior: Clip.hardEdge,
                  child: Container(
                    height: 63,
                    color: const Color(0xFFFFFFFF),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              changeTutorMode();
                            },
                            child: Container(
                              height: double.infinity,
                              width: double.infinity,
                              decoration: tutorModeButton
                                  ? BoxDecoration(
                                color: const Color(0xFFEC5863),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: const Color(0x80FFFFFF),
                                    width: 3),
                              )
                                  : const BoxDecoration(),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('TUTOR MODE',
                                        style: PreMedTextTheme()
                                            .heading2
                                            .copyWith(
                                            color: tutorModeButton
                                                ? const Color(0xFFFFFFFF)
                                                : const Color(0xFF000000),
                                            fontWeight: FontWeight.w800,
                                            fontSize: 12)),
                                    SizedBoxes.verticalTiny,
                                    SizedBox(
                                      height: 30,
                                      width: 95,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(3)),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Text(
                                              'FREE',
                                              style: PreMedTextTheme()
                                                  .heading2
                                                  .copyWith(
                                                  color: PreMedColorTheme()
                                                      .primaryColorRed,
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  fontSize: 8),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              changeTutorMode();
                            },
                            child: Container(
                              height: double.infinity,
                              width: double.infinity,
                              decoration: tutorModeButton
                                  ? const BoxDecoration()
                                  : BoxDecoration(
                                color: const Color(0xFFEC5863),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: const Color(0x80FFFFFF),
                                    width: 3),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'TIME TEST MODE',
                                      style: PreMedTextTheme()
                                          .heading2
                                          .copyWith(
                                          color: tutorModeButton
                                              ? const Color(0xFF000000)
                                              : const Color(0xFFFFFFFF),
                                          fontWeight: FontWeight.w800,
                                          fontSize: 12),
                                    ),
                                    SizedBoxes.vertical10Px,
                                    SizedBox(
                                      height: 30,
                                      width: 95,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(3)),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Text(
                                              widget.deckGroupName,
                                              style: PreMedTextTheme()
                                                  .heading2
                                                  .copyWith(
                                                  color: PreMedColorTheme()
                                                      .primaryColorRed,
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  fontSize: 8),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBoxes.verticalBig,
                ModeDescription(
                  deckName: widget.deckDetails['deckName'],
                  mode: tutorModeButton,
                  timedTestMinutes: widget.deckDetails['timedTestMinutes'],
                ),
                SizedBoxes.verticalBig,
                Material(
                  borderRadius: BorderRadius.circular(24),
                  clipBehavior: Clip.hardEdge,
                  elevation: 6,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Instructions'.toUpperCase(),
                          textAlign: TextAlign.start,
                          style: GoogleFonts.rubik(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        SizedBoxes.verticalTiny,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: sentences.map((sentence) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  '\u2022', // Unicode for bullet
                                  style: TextStyle(fontSize: 12),
                                ),
                                SizedBox(width: 5),
                                Expanded(
                                  child: Text(
                                    sentence.trim() + '.',
                                    style: GoogleFonts.rubik(
                                      fontWeight: FontWeight.normal,
                                      height: 1.3,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
