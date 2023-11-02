import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:premedpk_mobile_app/UI/screens/flashcards/flashcard_card.dart';
import 'package:premedpk_mobile_app/export.dart';
import 'package:premedpk_mobile_app/utils/Data/flashcard_data.dart';

class FlashcardCaarouselView extends StatefulWidget {
  final List<FlashcardModel> flashcardList;

  const FlashcardCaarouselView({
    super.key,
    required this.flashcardList,
  });

  @override
  State<FlashcardCaarouselView> createState() => _FlashcardCaarouselViewState();
}

class _FlashcardCaarouselViewState extends State<FlashcardCaarouselView> {
  PageController? FlashcardController;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    FlashcardController = PageController(initialPage: currentIndex);
    FlashcardController?.addListener(() {
      setState(() {
        currentIndex = FlashcardController?.page?.toInt() ?? 0;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    FlashcardController?.dispose();
    super.dispose();
  }

  void goToPreviousCard() {
    if (currentIndex > 0) {
      FlashcardController?.animateToPage(
        currentIndex - 1,
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }
  }

  void goToNextCard() {
    if (currentIndex < sampleFlashcards.length - 1) {
      FlashcardController?.animateToPage(
        currentIndex + 1,
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            itemCount: sampleFlashcards.length,
            physics: const ClampingScrollPhysics(),
            controller: FlashcardController,
            itemBuilder: (context, index) {
              return AnimatedBuilder(
                animation: FlashcardController!,
                builder: (context, child) {
                  double value = 0.0;
                  if (FlashcardController!.position.haveDimensions) {
                    value = index.toDouble() - (FlashcardController!.page ?? 0);
                    value = (value * 0.03).clamp(-1, 1);
                  }
                  return Transform.rotate(
                    angle: pi * value,
                    child: FlashcardCard(flashcard: sampleFlashcards[index]),
                  );
                },
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 64, right: 64),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: CustomButton(
                  isOutlined: true,
                  onPressed: goToPreviousCard,
                  buttonText: 'Previous',
                  textColor: PreMedColorTheme().neutral500,
                ),
              ),
              SizedBoxes.horizontalMedium,
              Expanded(
                child: CustomButton(
                  onPressed: goToNextCard,
                  buttonText: 'Next',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
