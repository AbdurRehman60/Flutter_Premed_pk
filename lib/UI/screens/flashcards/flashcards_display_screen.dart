import 'package:premedpk_mobile_app/UI/screens/The%20vault/widgets/back_button.dart';
import 'package:premedpk_mobile_app/UI/screens/flashcards/flashcard_card.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/models/flashcard_model.dart';
import 'package:premedpk_mobile_app/providers/flashcard_provider.dart';
import 'package:premedpk_mobile_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

class FlashcardDisplayScreen extends StatefulWidget {
  const FlashcardDisplayScreen({
    super.key,
    required this.subject,
  });

  final String subject;

  @override
  _FlashcardDisplayScreenState createState() => _FlashcardDisplayScreenState();
}

class _FlashcardDisplayScreenState extends State<FlashcardDisplayScreen> {
  PageController? flashcardController;
  int currentIndex = 0;
  FlashcardModel? currentFlashcard;

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
    flashcardProvider.getFilteredFlashcards(widget.subject);

    if (filteredFlashcards.isEmpty) {
      return Scaffold(
        backgroundColor: PreMedColorTheme().background,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: AppBar(
              backgroundColor: PreMedColorTheme().background,
              leading: const PopButton(),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.subject,
                    style: PreMedTextTheme().heading6.copyWith(
                        color: PreMedColorTheme().black,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBoxes.vertical2Px,
                  Text(
                      'FLASHCARDS',
                      style: PreMedTextTheme().subtext.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: PreMedColorTheme().black,)
                  )
                ],
              ),
            ),
          ),
        ),
        body: Center(
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
        ),
      );
    }

    return Scaffold(
      backgroundColor: PreMedColorTheme().background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13),
          child: AppBar(
            backgroundColor: PreMedColorTheme().background,
            leading: const PopButton(),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.subject,
                  style: PreMedTextTheme().heading6.copyWith(
                      color: PreMedColorTheme().black,
                      fontWeight: FontWeight.bold
                  ),
                ),
                SizedBoxes.vertical2Px,
                Text(
                    'My Saved Facts',
                    style: PreMedTextTheme().subtext.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: PreMedColorTheme().black,)
                )
              ],
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: PreMedColorTheme().primaryColorRed,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    icon: Image.asset('assets/icons/bin.png'),
                    onPressed: () {
                      if (currentFlashcard != null) {
                        Provider.of<FlashcardProvider>(context, listen: false).removeFlashcard(
                          userId: Provider.of<UserProvider>(context, listen: false).user!.userId,
                          subject: widget.subject,
                          questionId: currentFlashcard!.questionId,
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: PageView.builder(
                itemCount: filteredFlashcards.length,
                controller: flashcardController,
                itemBuilder: (context, index) {
                  currentFlashcard = filteredFlashcards[index];
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
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        if (currentIndex > 0) {
                          flashcardController?.animateToPage(
                            currentIndex - 1,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                        }
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: PreMedColorTheme().black,
                        size: 18,
                      ),
                      label: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'Previous',
                            style: PreMedTextTheme().body1.copyWith(
                              color: PreMedColorTheme().black,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          )),
                      style: ElevatedButton.styleFrom(
                          elevation: 3,
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                    ),
                  ),
                ),
                SizedBoxes.horizontalMedium,
                Expanded(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        if (currentIndex < filteredFlashcards.length - 1) {
                          flashcardController?.animateToPage(
                            currentIndex + 1,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                        }
                      },
                      label: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Next',
                            style: PreMedTextTheme().body1.copyWith(
                              color: PreMedColorTheme().white,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: PreMedColorTheme().white,
                            size: 18,
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                          elevation: 3,
                          backgroundColor: PreMedColorTheme().primaryColorRed,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
