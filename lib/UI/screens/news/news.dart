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
              Expanded(child: LatestNews()),
              SizedBoxes.verticalMedium,
              Text(
                'Old',
                style: PreMedTextTheme().headline.copyWith(
                      color: PreMedColorTheme().black,
                    ),
              ),
              Expanded(
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
  LatestNews({
    super.key,
  });
  String title = 'Sindh Announces MDCAT \nReconduct on November 24th.';
  ImageProvider image = AssetImage(PremedAssets.PrMedLogoLarge);

  @override
  Widget build(BuildContext context) {
    OnButtontapped(ImageProvider image, String title) {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      PremedAssets.PrMedLogoLarge,
                      width: 96,
                      height: 96,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBoxes.verticalMedium,
                  Text(
                    title,
                    style: PreMedTextTheme().body.copyWith(
                          color: PreMedColorTheme().black,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  Column(
                    children: [
                      const SizedBox(height: 16),
                      Text(
                        'Sindh has made a crucial decision to reconduct the Medical and Dental College Admission Test (MDCAT) on November 24th, creating a ripple of concern among students. This sudden move has left many aspiring medical and dental students in a state of panic as they rush to prepare for this vital examination. The announcement has not only disrupted their study schedules but has also raised questions about fairness and transparency in the examination process.',
                        style: PreMedTextTheme().heading7.copyWith(
                            color: PreMedColorTheme().black,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  SizedBoxes.verticalMedium,
                  SizedBox(
                    width: 328,
                    height: 40,
                    child: CustomButton(
                      buttonText: 'Open Website',
                      onPressed: () {},
                    ),
                  )
                ],
              ),
            ),
          );
        },
      );
    }

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
            height: 170,
            width: 320,
            color: itemColor,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NewsContent(
                    itemColor: itemColor,
                    buttonColor: buttonColor,
                    context: context,
                  ),
                  InkWell(
                    child: SizedBox(
                      width: 90,
                      height: 27,
                      child: TextButton(
                        onPressed: () {
                          OnButtontapped(image, title);
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: buttonColor,
                          primary: Colors.white,
                        ),
                        child: Text(
                          'Read More',
                          style: PreMedTextTheme().small.copyWith(
                                color: PreMedColorTheme().white,
                              ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class OldNews extends StatelessWidget {
  OldNews({
    Key? key,
  }) : super(key: key);
  String title = 'Sindh Announces MDCAT \nReconduct on November 24th.';
  ImageProvider image = AssetImage(PremedAssets.PrMedLogoLarge);
  @override
  Widget build(BuildContext context) {
    OnButtontapped(ImageProvider image, String title) {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      PremedAssets.PrMedLogoLarge,
                      width: 96,
                      height: 96,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBoxes.verticalMedium,
                  Text(
                    title,
                    style: PreMedTextTheme().body.copyWith(
                          color: PreMedColorTheme().black,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  Column(
                    children: [
                      const SizedBox(height: 16),
                      Text(
                        'Sindh has made a crucial decision to reconduct the Medical and Dental College Admission Test (MDCAT) on November 24th, creating a ripple of concern among students. This sudden move has left many aspiring medical and dental students in a state of panic as they rush to prepare for this vital examination. The announcement has not only disrupted their study schedules but has also raised questions about fairness and transparency in the examination process.',
                        style: PreMedTextTheme().heading7.copyWith(
                            color: PreMedColorTheme().black,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  SizedBoxes.verticalMedium,
                  SizedBox(
                    width: 328,
                    height: 40,
                    child: CustomButton(
                      buttonText: 'Open Website',
                      onPressed: () {},
                    ),
                  )
                ],
              ),
            ),
          );
        },
      );
    }

    return ListView.builder(
      itemCount: 10, // Change this to the desired number of items
      itemBuilder: (context, index) {
        Color itemColor = Colors.white; // Fixed to white
        Color buttonColor =
            PreMedColorTheme().primaryColorRed300; // Fixed color

        return Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: NewsContent(
                showDescription: false,
                showImage: false,
                itemColor: itemColor,
                buttonColor: buttonColor,
                context: context,
              ),
            ),
            InkWell(
              child: SizedBox(
                width: 90,
                height: 27,
                child: TextButton(
                  onPressed: () {
                    OnButtontapped(image, title);
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: buttonColor,
                    primary: Colors.white,
                  ),
                  child: Text(
                    'Read More',
                    style: PreMedTextTheme().small.copyWith(
                          color: PreMedColorTheme().white,
                        ),
                  ),
                ),
              ),
            ),
            // Add a Divider between containers
          ],
        );
      },
    );
  }
}
