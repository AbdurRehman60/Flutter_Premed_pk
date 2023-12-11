import 'package:premedpk_mobile_app/UI/widgets/global_widgets/custom_button.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';

import 'widgets/news_content.dart';

class NewsUpdates extends StatelessWidget {
  const NewsUpdates({super.key});

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
  LatestNews({super.key});
  final String title = 'Sindh Announces MDCAT \nReconduct on November 24th.';
  final ImageProvider image = AssetImage(PremedAssets.PrMedLogoLarge);

  @override
  Widget build(BuildContext context) {
    void onButtontapped(ImageProvider image, String title) {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
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
        final Color itemColor = index.isEven
            ? PreMedColorTheme().primaryColorRed200
            : PreMedColorTheme().primaryColorBlue200;

        final Color buttonColor = index.isEven
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
                          onButtontapped(image, title);
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: buttonColor,
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
  OldNews({super.key});
  final String title = 'Sindh Announces MDCAT \nReconduct on November 24th.';
  final ImageProvider image = AssetImage(PremedAssets.PrMedLogoLarge);

  @override
  Widget build(BuildContext context) {
    void onButtontapped(ImageProvider image, String title) {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
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
        const Color itemColor = Colors.white; // Fixed to white
        final Color buttonColor =
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
                    onButtontapped(image, title);
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: buttonColor,
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
        );
      },
    );
  }
}
