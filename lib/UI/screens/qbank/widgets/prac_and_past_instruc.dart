import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html/parser.dart' as htmlParser;
import 'package:premedpk_mobile_app/UI/screens/The%20vault/widgets/back_button.dart';
import 'package:premedpk_mobile_app/UI/screens/qbank/widgets/description_cont_for_pastnprac.dart';
import 'package:premedpk_mobile_app/providers/vaultProviders/premed_provider.dart';
import 'package:provider/provider.dart';
import '../../../../constants/constants_export.dart';
import 'mode_description_container.dart';

class PracticeandPast extends StatefulWidget {
  const PracticeandPast({
    super.key,
    required this.deckDetails,
    required this.deckGroupName,
    required this.subject,
    required this.premiumtag,
    required this.totalquestions,
    this.questionlist,
  });

  final List<String>? questionlist;
  final int totalquestions;
  final Map<String, dynamic> deckDetails;
  final String deckGroupName;
  final String subject;
  final List<String> premiumtag;

  @override
  State<PracticeandPast> createState() => _PracticeandPastState();
}

class _PracticeandPastState extends State<PracticeandPast> {
  late bool pastPaperModeButton;
  bool practiceModeButton = false;
  String mode = 'Past Paper';

  
  late String deckNameWithoutSuffix;

  @override
  void initState() {
    super.initState();
    pastPaperModeButton = widget.deckDetails['isTutorModeFree'];

    
    deckNameWithoutSuffix = widget.deckDetails['deckName']
        .replaceAll('Past Paper', '')
        .replaceAll('Practice', '')
        .trim();
  }

  void changeMode() {
    setState(() {
      pastPaperModeButton = !pastPaperModeButton;
    });
  }

  @override
  Widget build(BuildContext context) {
    String deckNameWithMode = pastPaperModeButton
        ? '$deckNameWithoutSuffix Past Paper'
        : '$deckNameWithoutSuffix Practice';

    final instructions = widget.deckDetails['deckInstructions'] != null
        ? htmlParser.parse(widget.deckDetails['deckInstructions']).body!.text
        : '';
    final sentences = instructions.split('.').where((sentence) => sentence.trim().isNotEmpty).toList();
    final pro = Provider.of<PreMedProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const PopButton(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 15, 16, 0),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(deckNameWithMode, 
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
                    color: pro.isPreMed ? PreMedColorTheme().primaryColorRed : PreMedColorTheme().blue,
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
                              changeMode();
                            },
                            child: Container(
                              height: double.infinity,
                              width: double.infinity,
                              decoration: pastPaperModeButton
                                  ? BoxDecoration(
                                color: pro.isPreMed
                                    ? PreMedColorTheme().primaryColorRed
                                    : PreMedColorTheme().blue,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: const Color(0x80FFFFFF), width: 3),
                              )
                                  : const BoxDecoration(),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('PAST PAPER',
                                        style: PreMedTextTheme().heading2.copyWith(
                                            color: pastPaperModeButton
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
                                            borderRadius: BorderRadius.circular(3)),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Text(
                                              'FREE',
                                              style: PreMedTextTheme().heading2.copyWith(
                                                  color: pro.isPreMed
                                                      ? PreMedColorTheme()
                                                      .primaryColorRed
                                                      : PreMedColorTheme().blue,
                                                  fontWeight: FontWeight.bold,
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
                              changeMode();
                            },
                            child: Container(
                              height: double.infinity,
                              width: double.infinity,
                              decoration: pastPaperModeButton
                                  ? const BoxDecoration()
                                  : BoxDecoration(
                                color: pro.isPreMed
                                    ? PreMedColorTheme().primaryColorRed
                                    : PreMedColorTheme().blue,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: const Color(0x80FFFFFF), width: 3),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'PRACTICE',
                                      style: PreMedTextTheme().heading2.copyWith(
                                          color: pastPaperModeButton
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
                                            borderRadius: BorderRadius.circular(3)),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Text(
                                              widget.deckGroupName,
                                              textAlign: TextAlign.center,
                                              style: PreMedTextTheme().heading2.copyWith(
                                                  color: pro.isPreMed
                                                      ? PreMedColorTheme()
                                                      .primaryColorRed
                                                      : PreMedColorTheme().blue,
                                                  fontWeight: FontWeight.bold,
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
                DescriptionContForPastnprac(
                  subject: widget.subject,
                  deckName: deckNameWithMode,
                  mode: pastPaperModeButton,
                  timedTestMinutes: widget.deckDetails['timedTestMinutes'],
                  premiumTag: widget.premiumtag,
                  totalquestions: widget.totalquestions,
                  questionlist: widget.questionlist,
                ),
                SizedBoxes.verticalBig,
                if (instructions.isNotEmpty)
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
                                    '\u2022', 
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: Text(
                                      '${sentence.trim()}.',
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
