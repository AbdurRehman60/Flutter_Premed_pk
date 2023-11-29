import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/UI/Widgets/global_widgets_export.dart';
import 'package:premedpk_mobile_app/constants/assets.dart';
import 'package:premedpk_mobile_app/constants/color_theme.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';

import 'widgets/news_content.dart';

class NewsUpdates extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PreMedColorTheme().white,
        centerTitle: true,
        title: Text(
          'News & Updates',
          style: PreMedTextTheme().heading6.copyWith(
                color: PreMedColorTheme().black,
              ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Latest',
                style: PreMedTextTheme().headline.copyWith(
                      color: PreMedColorTheme().black,
                    ),
              ),
              const Expanded(child: LatestNews()),
              SizedBoxes.verticalMedium,
              Text(
                'Old',
                style: PreMedTextTheme().headline.copyWith(
                      color: PreMedColorTheme().black,
                    ),
              ),
              const Expanded(
                child: OldNews(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LatestNews extends StatelessWidget {
  const LatestNews({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10, // Change this to the desired number of items
      itemBuilder: (context, index) {
        // Alternate between red and blue
        Color itemColor = index % 2 == 0
            ? PreMedColorTheme().primaryColorRed200
            : PreMedColorTheme().primaryColorBlue200;

        Color buttonColor = index % 2 == 0
            ? PreMedColorTheme().primaryColorBlue300
            : PreMedColorTheme().primaryColorRed300;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Container(
            height: 190,
            width: 320,
            color: itemColor,
            child: NewsContent(
              itemColor: itemColor,
              buttonColor: buttonColor,
              context: context,
            ),
          ),
        );
      },
    );
  }
}

class OldNews extends StatelessWidget {
  const OldNews({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10, // Change this to the desired number of items
      itemBuilder: (context, index) {
        Color itemColor = Colors.white; // Fixed to white
        Color buttonColor =
            PreMedColorTheme().primaryColorRed300; // Fixed color

        return Column(
          children: [
            NewsContent(
              showDescription: false,
              showImage: false,
              itemColor: itemColor,
              buttonColor: buttonColor,
              context: context,
            ),
            Divider(), // Add a Divider between containers
          ],
        );
      },
    );
  }
}
