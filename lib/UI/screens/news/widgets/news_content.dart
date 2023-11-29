import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/UI/widgets/global_widgets_export.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/export.dart';

class NewsContent extends StatelessWidget {
  NewsContent({
    Key? key,
    required this.itemColor,
    required this.buttonColor,
    this.showDescription = true,
    this.showImage = true, // Add this flag
    required this.context,
  });

  final Color itemColor;
  final Color buttonColor;
  final bool showDescription;
  final bool showImage; // Add this flag
  final BuildContext context;
  String title = 'Sindh Announces MDCAT \nReconduct on November 24th.';
  ImageProvider image = AssetImage(PremedAssets.PrMedLogoLarge);

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

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (showImage) // Show image based on the flag
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      PremedAssets.PrMedLogoLarge,
                      width: 36,
                      height: 36,
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
              ],
            ),
            SizedBoxes.verticalMicro,
            const Text('29.05.2023'),
            SizedBoxes.verticalMedium,
            // Description
            if (showDescription)
              Text(
                'Students start panicking as Sindh Announces MDCAT Reconduct. Students start panicking as Sindh Announces MDCAT Reconduct.',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: PreMedTextTheme().small.copyWith(
                      color: PreMedColorTheme().black,
                    ),
              ),
            SizedBoxes.verticalMedium,
            InkWell(
              child: SizedBox(
                width: 100,
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
    );
  }
}
