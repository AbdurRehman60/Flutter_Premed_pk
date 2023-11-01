import 'package:premedpk_mobile_app/export.dart';
import 'package:premedpk_mobile_app/utils/Data/flashcard_data.dart';

class FlashCards extends StatefulWidget {
  const FlashCards({super.key});

  @override
  State<FlashCards> createState() => _FlashCardsState();
}

class _FlashCardsState extends State<FlashCards> {
  late PageController FlashcardController;
  int currentIndex = 0;
  @override
  void initState() {
    setState(() {
      super.initState();
      FlashcardController = PageController(
        initialPage: currentIndex,
        viewportFraction: 0.8,
      );
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    FlashcardController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Center(
                child: Text(
                  'Flashcards',
                  style: PreMedTextTheme().subtext.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ),
            AspectRatio(
              aspectRatio: 0.85,
              child: PageView.builder(
                itemCount: sampleFlashcards.length,
                physics: const ClampingScrollPhysics(),
                controller: FlashcardController,
                itemBuilder: (context, index) {
                  return carouselView(index);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget carouselView(int index) {
    return carouselCard(
      sampleFlashcards[index],
    );
  }

  Widget carouselCard(FlashcardModel data) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text(
            data.questionText,
            style: PreMedTextTheme().body,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            data.correctOptionText,
            style: PreMedTextTheme().body,
          ),
        ),
      ],
    );
  }
}
