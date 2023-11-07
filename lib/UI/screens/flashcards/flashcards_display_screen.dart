import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/UI/screens/flashcards/flashcard_carousel_view.dart';
import 'package:premedpk_mobile_app/export.dart';

import '../../../repository/flashcard_provider.dart';

class FlashcardDisplayScreen extends StatelessWidget {
  final String subject;

  FlashcardDisplayScreen({required this.subject});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: PreMedColorTheme().white,
        iconTheme: IconThemeData(color: PreMedColorTheme().black),
        title: Text(
          '$subject',
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
