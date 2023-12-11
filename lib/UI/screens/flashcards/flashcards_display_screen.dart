import 'package:premedpk_mobile_app/UI/screens/flashcards/flashcard_carousel_view.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';

class FlashcardDisplayScreen extends StatelessWidget {

  const FlashcardDisplayScreen({
    super.key,
    required this.subject,
  });
  final String subject;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: PreMedColorTheme().white,
        iconTheme: IconThemeData(color: PreMedColorTheme().black),
        title: Text(
          subject,
          style: PreMedTextTheme()
              .heading5
              .copyWith(color: PreMedColorTheme().black),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.menu_rounded,
                color: PreMedColorTheme().black,
              ))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: FlashcardCarouselView(
              selectedSubject: subject,
            ),
          ),
          SizedBoxes.verticalBig
        ],
      ),
    );
  }
}
