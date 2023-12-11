import 'package:premedpk_mobile_app/UI/screens/flashcards/flashcard_card.dart';
import 'package:premedpk_mobile_app/UI/widgets/global_widgets_export.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/models/flashcard_model.dart';
import 'package:premedpk_mobile_app/providers/flashcard_provider.dart';
import 'package:provider/provider.dart';

class FlashcardCarouselView extends StatefulWidget {
  const FlashcardCarouselView({
    super.key,
    required this.selectedSubject,
  });
  final String selectedSubject;

  @override
  State<FlashcardCarouselView> createState() => _FlashcardCarouselViewState();
}

class _FlashcardCarouselViewState extends State<FlashcardCarouselView> {
  PageController? flashcardController;
  int currentIndex = 0;

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

  @override
  Widget build(BuildContext context) {
    final FlashcardProvider flashcardProvider =
        Provider.of<FlashcardProvider>(context);

    final List<FlashcardModel> filteredFlashcards =
        flashcardProvider.getFilteredFlashcards(widget.selectedSubject);

    void goToPreviousCard() {
      if (currentIndex > 0) {
        flashcardController?.animateToPage(
          currentIndex - 1,
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      }
    }

    void goToNextCard() {
      if (currentIndex < filteredFlashcards.length - 1) {
        flashcardController?.animateToPage(
          currentIndex + 1,
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      }
    }

    if (filteredFlashcards.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(PremedAssets.Notfoundemptystate),
            SizedBoxes.verticalTiny,
            Text(
              'No Flash Cards',
              style: PreMedTextTheme().subtext1.copyWith(
                  color: PreMedColorTheme().primaryColorRed,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.36),
            ),
            SizedBoxes.verticalTiny,
          ],
        ),
      );
    }

    return Column(
      children: [
        Text(
          'Click on card to see Answers',
          style: PreMedTextTheme().heading7.copyWith(
                fontWeight: FontWeights.regular,
                color: PreMedColorTheme().neutral500,
              ),
        ),
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
