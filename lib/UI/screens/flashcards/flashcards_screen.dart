import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/UI/screens/flashcards/flashcards_home.dart';
import 'package:premedpk_mobile_app/constants/color_theme.dart';
import 'package:premedpk_mobile_app/constants/sized_boxes.dart';
import 'package:premedpk_mobile_app/constants/text_theme.dart';
import 'package:premedpk_mobile_app/utils/Data/flashcard_screen_data.dart';

class FlashcardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Flashcards',
          style: PreMedTextTheme().heading5.copyWith(
                color: PreMedColorTheme().black,
              ),
        ),
        backgroundColor: PreMedColorTheme().white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              'Select Questions and start revising.',
              style: PreMedTextTheme().subtext.copyWith(
                  color: PreMedColorTheme().neutral400,
                  fontWeight: FontWeight.w400),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: GridView.builder(
                itemCount: gridData.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  mainAxisExtent: 126,
                ),
                itemBuilder: (context, index) {
                  return FlashcardItem(
                    image: gridData[index]['image'] ?? '',
                    text: gridData[index]['text'] ?? '',
                    page: gridData[index]['page'] ?? '',
                    subject:
                        gridData[index]['subject'] ?? '', // Include subject
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FlashcardItem extends StatelessWidget {
  final String image;
  final String text;
  final String page;
  final String subject;

  FlashcardItem({
    required this.image,
    required this.text,
    required this.page,
    required this.subject, // Add subject as a parameter
  });

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
        } else {
          // Handle the case where 'page' is empty or null.
        }
      },
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: PreMedColorTheme().neutral300, width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
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
                  style: PreMedTextTheme().heading7,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
