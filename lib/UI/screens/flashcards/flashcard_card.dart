import 'package:flip_card/flip_card.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/models/flashcard_model.dart';

class FlashcardCard extends StatefulWidget {
  const FlashcardCard({super.key, required this.flashcard});

  final FlashcardModel flashcard;

  @override
  State<FlashcardCard> createState() => _FlashcardCardState();
}

class _FlashcardCardState extends State<FlashcardCard> {
  bool isFlipped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isFlipped = !isFlipped;
        });
      },
      onVerticalDragEnd: (details) {
        setState(() {
          isFlipped = !isFlipped;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        child: FlipCard(
          front: buildFrontContent(),
          back: buildBackContent(),
        ),
      ),
    );
  }

  Widget buildFrontContent() {
    return Material(
      color: Colors.white30,
      elevation: 3,
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: PreMedColorTheme().white, width: 3),
          boxShadow: const [
            BoxShadow(
              color: Colors.white,
              spreadRadius: 1,
              offset: Offset(0, 2),
              blurRadius: 4.0,
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20), // You can adjust the padding
            child: Column(
              children: [
                Text(
                  'Question',
                  style: PreMedTextTheme().heading6.copyWith(
                        color: PreMedColorTheme().primaryColorBlue,
                      ),
                ),
                Html(
                  data: widget.flashcard.questionText,
                  style: {
                    'p': Style(
                      textAlign: TextAlign.center,
                      fontFamily: 'Inter',
                      fontSize: FontSize(14.0),
                      fontWeight: FontWeight.w400,
                    ),
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBackContent() {
    return Material(
      color: Colors.white30,
      elevation: 3,
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: PreMedColorTheme().white, width: 3),
          boxShadow: const [
            BoxShadow(
              color: Colors.white,
              spreadRadius: 1,
              offset: Offset(0, 2),
              blurRadius: 4.0,
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  'Answer',
                  style: PreMedTextTheme()
                      .heading6
                      .copyWith(color: PreMedColorTheme().primaryColorRed),
                ),
                Html(
                  data: widget.flashcard.correctOptionText,
                  style: {
                    'p': Style(
                      textAlign: TextAlign.center,
                      fontFamily: 'Inter',
                      fontSize: FontSize(14.0),
                      fontWeight: FontWeight.w400,
                    ),
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
