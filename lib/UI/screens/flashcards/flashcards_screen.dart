import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/UI/screens/flashcards/flashcards_home.dart';
import 'package:premedpk_mobile_app/constants/color_theme.dart';
import 'package:premedpk_mobile_app/constants/sized_boxes.dart';
import 'package:premedpk_mobile_app/constants/text_theme.dart';
import 'package:premedpk_mobile_app/utils/Data/flashcard_screen_data.dart';

// class FlashcardScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Flashcards',
//           style: PreMedTextTheme().heading5.copyWith(
//                 color: PreMedColorTheme().black,
//               ),
//         ),
//         backgroundColor: PreMedColorTheme().white,
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(left: 20),
//             child: Text(
//               'Select Questions and start revising.',
//               style: PreMedTextTheme().subtext.copyWith(
//                   color: PreMedColorTheme().neutral400,
//                   fontWeight: FontWeight.w400),
//             ),
//           ),
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: GridView.builder(
//                 itemCount: gridData.length,
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   mainAxisSpacing: 20,
//                   crossAxisSpacing: 20,
//                   mainAxisExtent: 130,
//                 ),
//                 itemBuilder: (context, index) {
//                   Color color = Color(int.parse(
//                       '0xFF${gridData[index]['color']?.substring(1)}'));
//                   return FlashcardItem(
//                     image: gridData[index]['image'] ?? '',
//                     text: gridData[index]['text'] ?? '',
//                     page: gridData[index]['page'] ?? '',
//                     subject: gridData[index]['subject'] ?? '',
//                     color: color, // Include subject
//                   );
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/UI/screens/flashcards/flashcards_home.dart';
import 'package:premedpk_mobile_app/constants/color_theme.dart';
import 'package:premedpk_mobile_app/constants/sized_boxes.dart';
import 'package:premedpk_mobile_app/constants/text_theme.dart';
import 'package:premedpk_mobile_app/utils/Data/flashcard_screen_data.dart';

import '../../../models/flashcard_model.dart';
import '../../../utils/Data/flashcard_data.dart';

class FlashcardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final subjectFlashcards =
        getSubjectFlashcards(); // Calculate flashcard count
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
                  mainAxisExtent: 130,
                ),
                itemBuilder: (context, index) {
                  Color color = Color(int.parse(
                      '0xFF${gridData[index]['color']?.substring(1)}'));
                  final subject = gridData[index]['subject'] ?? '';
                  final flashcardCount =
                      subjectFlashcards[subject]?.length ?? 0;
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
          ),
        ],
      ),
    );
  }

  // This function calculates the flashcard count for each subject
  Map<String, List<FlashcardModel>> getSubjectFlashcards() {
    Map<String, List<FlashcardModel>> subjectFlashcards = {};

    for (var data in gridData) {
      String subject = data['subject']!;
      if (!subjectFlashcards.containsKey(subject)) {
        subjectFlashcards[subject] = [];
      }
      // Find flashcards for the subject
      for (var flashcard in sampleFlashcards) {
        if (flashcard.subject == subject) {
          subjectFlashcards[subject]?.add(flashcard);
        }
      }
    }

    return subjectFlashcards;
  }
}

class FlashcardItem extends StatelessWidget {
  final String image;
  final String text;
  final String page;
  final String subject;
  final Color color; // Use Color for background color

  FlashcardItem({
    required this.image,
    required this.text,
    required this.page,
    required this.subject,
    required this.color, // Add color as a parameter
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
      child: Container(
        // Use a Container to set the background color
        decoration: BoxDecoration(
          color: color, // Set the background color here
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: PreMedColorTheme().neutral300, width: 1),
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
                  style: PreMedTextTheme().subtext,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
