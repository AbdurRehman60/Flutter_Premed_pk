import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:premedpk_mobile_app/UI/screens/flashcards/flashcard_screen_data.dart';
import 'package:premedpk_mobile_app/UI/screens/flashcards/flashcards_display_screen.dart';
import 'package:premedpk_mobile_app/UI/screens/flashcards/widgets/flashcard_shimmer.dart';
import 'package:premedpk_mobile_app/constants/color_theme.dart';
import 'package:premedpk_mobile_app/constants/sized_boxes.dart';
import 'package:premedpk_mobile_app/constants/text_theme.dart';
import 'package:premedpk_mobile_app/providers/flashcard_provider.dart';
import 'package:provider/provider.dart';

class FlashcardHome extends StatelessWidget {
  const FlashcardHome({super.key});

  @override
  Widget build(BuildContext context) {
    final flashcardProvider =
        Provider.of<FlashcardProvider>(context, listen: false);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Material(
              elevation: 4,
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              clipBehavior: Clip.hardEdge,
              child: SizedBox(
                width: 37,
                height: 37,
                child: SvgPicture.asset(
                  'assets/icons/left-arrow.svg',
                  width: 9.33,
                  height: 18.67,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Flashcards',
                style: PreMedTextTheme().heading6.copyWith(
                      color: PreMedColorTheme().black,
                      fontSize: 34,
                      fontWeight: FontWeight.w800,
                    ),
              ),
            ),
          ),
          FutureBuilder(
            future: flashcardProvider.getFlashcardsByUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const FlashcardShimmer();
              } else if (snapshot.hasError) {
                // Handle errors
                return const Center(
                  child: Text('Error fetching data'),
                );
              } else {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: GridView.builder(
                      itemCount: gridData.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        mainAxisExtent: 140,
                      ),
                      itemBuilder: (context, index) {
                        final Color color = Color(int.parse(
                            '0xFF${gridData[index]['color']?.substring(1)}'));
                        final subject = gridData[index]['subject'] ?? '';
                        final flashcardCount = flashcardProvider
                            .getFilteredFlashcards(subject)
                            .length;
                        final page =
                            '$flashcardCount Questions'; // Update page based on count
                        return FlashcardItem(
                          image: gridData[index]['image'] ?? '',
                          text: gridData[index]['text'] ?? '',
                          page: page,
                          subject: subject,
                          color: color,
                        );
                      },
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class FlashcardItem extends StatelessWidget {
  // Use Color for background color

  const FlashcardItem({
    super.key,
    required this.image,
    required this.text,
    required this.page,
    required this.subject,
    required this.color, // Add color as a parameter
  });
  final String image;
  final String text;
  final String page;
  final String subject;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (page.isNotEmpty) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FlashcardDisplayScreen(
                subject: text,
              ),
            ),
          );
        } else {}
      },
      child: Container(
        // Use a Container to set the background color
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
          color: color, // Set the background color here
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: PreMedColorTheme().white, width: 3),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  image,
                  fit: BoxFit.contain,
                  width: 32,
                  height: 32,
                ),
              ),
              SizedBoxes.verticalMedium,
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  text,
                  style: PreMedTextTheme().heading7,
                ),
              ),
              SizedBoxes.vertical2Px,
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  page,
                  style: PreMedTextTheme().subtext.copyWith(
                        fontWeight: FontWeights.regular,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
