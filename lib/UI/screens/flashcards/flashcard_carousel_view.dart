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
    setState(() {
      super.initState();
      FlashcardController = PageController(
        initialPage: currentIndex,
        viewportFraction: 0.9,
      );
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    FlashcardController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal:
                          20.0), // Adjust the horizontal margin as needed
                  child: FlashcardCard(flashcard: sampleFlashcards[index]),
                ),
              );
            },
          );
        });
  }
}
