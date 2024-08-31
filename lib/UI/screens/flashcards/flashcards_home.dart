import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/UI/screens/The%20vault/widgets/back_button.dart';
import 'package:premedpk_mobile_app/UI/screens/flashcards/flashcard_screen_data.dart';
import 'package:premedpk_mobile_app/UI/screens/flashcards/flashcards_display_screen.dart';
import 'package:premedpk_mobile_app/UI/screens/flashcards/widgets/flashcard_shimmer.dart';
import 'package:premedpk_mobile_app/constants/color_theme.dart';
import 'package:premedpk_mobile_app/constants/sized_boxes.dart';
import 'package:premedpk_mobile_app/constants/text_theme.dart';
import 'package:premedpk_mobile_app/providers/flashcard_provider.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider.dart';

class FlashcardHome extends StatefulWidget {
  const FlashcardHome({super.key});

  @override
  State<FlashcardHome> createState() => _FlashcardHomeState();
}

class _FlashcardHomeState extends State<FlashcardHome> {
  @override
  void initState() {
    super.initState();
    final userId =
        Provider.of<UserProvider>(context, listen: false).user!.userId;
    Provider.of<FlashcardProvider>(context, listen: false)
        .getFlashcardsByUser(userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PreMedColorTheme().background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: AppBar(
            backgroundColor: Colors.transparent,
            leading: const PopButton(),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0).copyWith(left: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'My Saved Facts',
                style: PreMedTextTheme().heading6.copyWith(
                      color: PreMedColorTheme().black,
                      fontSize: 34,
                      fontWeight: FontWeight.w800,
                    ),
              ),
            ),
          ),
          Consumer<FlashcardProvider>(
            builder: (context, flashcardProvider, child) {
              switch (flashcardProvider.doubtUploadStatus) {
                case Status.init:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case Status.fetching:
                  return const FlashcardShimmer();
                case Status.success:
                  return Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 21),
                      itemCount: gridData.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 21,
                        crossAxisSpacing: 18,
                        mainAxisExtent: 140,
                      ),
                      itemBuilder: (context, index) {
                        final Color color = Color(int.parse(
                            '0xFF${gridData[index]['color']?.substring(1)}'));
                        final subject = gridData[index]['subject'];
                        final flashcardCount = flashcardProvider
                            .getFilteredFlashcards(subject!)
                            .length;
                        final page = '$flashcardCount Questions';
                        return FlashcardItem(
                          image: gridData[index]['image'] ?? '',
                          text: gridData[index]['text'] ?? '',
                          page: page,
                          subject: subject,
                          color: color,
                        );
                      },
                    ),
                  );
                case Status.error:
                  return const Center(
                    child: Text('Error fetching data'),
                  );
                case Status.removing:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                default:
                  return const Center(
                    child: Text('Unknown status'),
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
  const FlashcardItem({
    super.key,
    required this.image,
    required this.text,
    required this.page,
    required this.subject,
    required this.color,
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
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
          color: color,
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
