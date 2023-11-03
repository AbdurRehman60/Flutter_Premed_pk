// import 'dart:math';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/widgets.dart';
// import 'package:premedpk_mobile_app/UI/screens/flashcards/flashcard_card.dart';
// import 'package:premedpk_mobile_app/export.dart';
// import 'package:premedpk_mobile_app/utils/Data/flashcard_data.dart';

// class FlashcardCarouselView extends StatefulWidget {
//   final List<FlashcardModel> flashcardList;

//   const FlashcardCarouselView({
//     super.key,
//     required this.flashcardList,
//   });

//   @override
//   State<FlashcardCarouselView> createState() => _FlashcardCaarouselViewState();
// }

// class _FlashcardCaarouselViewState extends State<FlashcardCarouselView> {
//   PageController? FlashcardController;
//   int currentIndex = 0;

//   @override
//   void initState() {
//     super.initState();
//     FlashcardController = PageController(initialPage: currentIndex);
//     FlashcardController?.addListener(() {
//       setState(() {
//         currentIndex = FlashcardController?.page?.toInt() ?? 0;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     FlashcardController?.dispose();
//     super.dispose();
//   }

//   void goToPreviousCard() {
//     if (currentIndex > 0) {
//       FlashcardController?.animateToPage(
//         currentIndex - 1,
//         duration: Duration(milliseconds: 500),
//         curve: Curves.ease,
//       );
//     }
//   }

//   void goToNextCard() {
//     if (currentIndex < sampleFlashcards.length - 1) {
//       FlashcardController?.animateToPage(
//         currentIndex + 1,
//         duration: Duration(milliseconds: 500),
//         curve: Curves.ease,
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Expanded(
//           child: PageView.builder(
//             itemCount: sampleFlashcards.length,
//             physics: const ClampingScrollPhysics(),
//             controller: FlashcardController,
//             itemBuilder: (context, index) {
//               return AnimatedBuilder(
//                 animation: FlashcardController!,
//                 builder: (context, child) {
//                   double value = 0.0;
//                   if (FlashcardController!.position.haveDimensions) {
//                     value = index.toDouble() - (FlashcardController!.page ?? 0);
//                     value = (value * 0.03).clamp(-1, 1);
//                   }
//                   return Transform.rotate(
//                     angle: pi * value,
//                     child: FlashcardCard(flashcard: sampleFlashcards[index]),
//                   );
//                 },
//               );
//             },
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(left: 64, right: 64),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Expanded(
//                 child: CustomButton(
//                   isOutlined: true,
//                   onPressed: goToPreviousCard,
//                   buttonText: 'Previous',
//                   textColor: PreMedColorTheme().neutral500,
//                 ),
//               ),
//               SizedBoxes.horizontalMedium,
//               Expanded(
//                 child: CustomButton(
//                   onPressed: goToNextCard,
//                   buttonText: 'Next',
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
import 'dart:math';

import 'package:premedpk_mobile_app/UI/screens/flashcards/flashcard_card.dart';
import 'package:premedpk_mobile_app/export.dart';

class FlashcardCarouselView extends StatefulWidget {
  final List<FlashcardModel> flashcardList;
  final String selectedSubject; // Add a selectedSubject parameter

  const FlashcardCarouselView({
    Key? key,
    required this.flashcardList,
    required this.selectedSubject,
  }) : super(key: key);

  @override
  State<FlashcardCarouselView> createState() => _FlashcardCarouselViewState();
}

class _FlashcardCarouselViewState extends State<FlashcardCarouselView> {
  PageController? flashcardController;
  int currentIndex = 0;

  List<FlashcardModel> getFilteredFlashcards() {
    // Filter flashcards based on the selectedSubject
    return widget.flashcardList.where((flashcard) {
      return flashcard.subject == widget.selectedSubject;
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    flashcardController = PageController(initialPage: currentIndex);
    flashcardController?.addListener(() {
      setState(() {
        currentIndex = flashcardController?.page?.toInt() ?? 0;
      });
    });
  }

  @override
  void dispose() {
    flashcardController?.dispose();
    super.dispose();
  }

  void goToPreviousCard() {
    if (currentIndex > 0) {
      flashcardController?.animateToPage(
        currentIndex - 1,
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }
  }

  void goToNextCard() {
    final filteredFlashcards = getFilteredFlashcards();
    if (currentIndex < filteredFlashcards.length - 1) {
      flashcardController?.animateToPage(
        currentIndex + 1,
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredFlashcards = getFilteredFlashcards();

    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            itemCount: filteredFlashcards.length,
            physics: const ClampingScrollPhysics(),
            controller: flashcardController,
            itemBuilder: (context, index) {
              return AnimatedBuilder(
                animation: flashcardController!,
                builder: (context, child) {
                  double value = 0.0;
                  if (flashcardController!.position.haveDimensions) {
                    value = index.toDouble() - (flashcardController!.page ?? 0);
                    value = (value * 0.03).clamp(-1, 1);
                  }
                  return Transform.rotate(
                    angle: pi * value,
                    child: FlashcardCard(flashcard: filteredFlashcards[index]),
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
