import 'package:premedpk_mobile_app/constants/constants_export.dart';

class NewsContent extends StatelessWidget {
  NewsContent({
    Key? key,
    required this.itemColor,
    required this.buttonColor,
    this.showDescription = true,
    this.showImage = true, // Add this flag
    required this.context,
  });
  String title = 'Sindh Announces MDCAT \nReconduct on November 24th.';
  ImageProvider image = AssetImage(PremedAssets.PrMedLogoLarge);
  final Color itemColor;
  final Color buttonColor;
  final bool showDescription;
  final bool showImage; // Add this flag
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
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
        ],
      ),
    );
  }
}
