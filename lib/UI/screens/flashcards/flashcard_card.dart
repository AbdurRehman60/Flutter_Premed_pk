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
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(12.0), // Adjust the radius as needed
        border: Border.all(
          color: PreMedColorTheme().neutral300, // Border color
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.white, // Shadow color
            offset: Offset(0, 2), // Offset (horizontal, vertical)
            blurRadius: 4.0, // Blur radius
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
    );
  }

  Widget buildBackContent() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: PreMedColorTheme().neutral300,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.white,
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
    );
  }
}
