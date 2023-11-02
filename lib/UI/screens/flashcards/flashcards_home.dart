import 'package:premedpk_mobile_app/UI/screens/flashcards/flashcard_card.dart';
import 'package:premedpk_mobile_app/UI/screens/flashcards/flashcard_carousel_view.dart';
import 'package:premedpk_mobile_app/export.dart';
import 'package:premedpk_mobile_app/utils/Data/flashcard_data.dart';

class FlashCards extends StatefulWidget {
  const FlashCards({Key? key}) : super(key: key);

  @override
  _FlashCardsState createState() => _FlashCardsState();
}

class _FlashCardsState extends State<FlashCards> {
  PageController FlashcardController = PageController();
  int currentIndex = 0;

  void goToPreviousCard() {
    if (currentIndex > 0) {
      FlashcardController.animateToPage(
        currentIndex - 1,
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }
  }

  void goToNextCard() {
    if (currentIndex < sampleFlashcards.length - 1) {
      FlashcardController.animateToPage(
        currentIndex + 1,
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    FlashcardController = PageController(initialPage: currentIndex);
    FlashcardController.addListener(() {
      setState(() {
        currentIndex = FlashcardController.page?.toInt() ?? 0;
      });
    });
  }

  @override
  void dispose() {
    FlashcardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: PreMedColorTheme().black,
          ),
        ),
        title: Text(
          'Flash Cards',
          style: PreMedTextTheme().heading7.copyWith(
                color: PreMedColorTheme().black,
              ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.menu_rounded,
              color: PreMedColorTheme().black,
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
              child: FlashcardCaarouselView(flashcardList: sampleFlashcards)),
          SizedBoxes.verticalBig,
          // Padding(
          //   padding: const EdgeInsets.all(16.0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Expanded(
          //         child: CustomButton(
          //           isOutlined: true,
          //           onPressed: goToPreviousCard,
          //           buttonText: 'Previous',
          //           textColor: PreMedColorTheme().neutral500,
          //         ),
          //       ),
          //       SizedBoxes.horizontalTiny,
          //       Expanded(
          //         child: CustomButton(
          //           onPressed: goToNextCard,
          //           buttonText: 'Next',
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
