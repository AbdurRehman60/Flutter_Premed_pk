import 'package:premedpk_mobile_app/UI/screens/marketplace/widgets/special_offers_widget.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/export.dart';
import 'package:premedpk_mobile_app/models/bundle_model.dart';

import '../../../Widgets/global_widgets_export.dart';

class CardContent extends StatelessWidget {
  const CardContent(
      {super.key,
      required this.bundle,
      required this.renderPoints,
      this.renderDescription = true,
      this.points});

  final BundleModel bundle;
  final bool renderPoints;
  final int? points;
  final renderDescription;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          children: [
            buildBundleIcon(bundle.bundleIcon),
            SizedBoxes.horizontalMicro,
            SizedBoxes.horizontalMicro,
            Flexible(
              child: RichText(
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  text: bundle.bundleName.split(' ').first, // First word
                  style: PreMedTextTheme().heading5.copyWith(
                        color: PreMedColorTheme()
                            .primaryColorRed, // Color for the first word
                      ),
                  children: <TextSpan>[
                    TextSpan(
                      text:
                          ' ${bundle.bundleName.split(' ').skip(1).join(' ')}', // Rest of the string
                      style: PreMedTextTheme().heading5.copyWith(
                            color: PreMedColorTheme().black,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBoxes.verticalMicro,
        SizedBoxes.verticalMicro,
        renderDescription
            ? Text(
                bundle.bundleDescription,
                style: PreMedTextTheme().body.copyWith(
                      height: 1.5,
                      color: PreMedColorTheme().neutral600,
                    ),
                maxLines: 4, // Set the number of lines you want to show
                overflow: TextOverflow.ellipsis,
              )
            : SizedBox(),
        renderPoints
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: bundle.bundlePoints
                    .take(points != null ? points! : bundle.bundlePoints.length)
                    .map(
                      (point) => Row(
                        children: [
                          Icon(
                            Icons.check,
                            color: PreMedColorTheme().black,
                            size: 16,
                          ),
                          const SizedBox(width: 5),
                          Flexible(
                            child: Text(
                              point,
                              style: PreMedTextTheme().small.copyWith(
                                    color: PreMedColorTheme().black,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              )
            : SizedBox(),
        SizedBoxes.verticalMedium,
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '${bundle.bundleDiscount}',
              style: PreMedTextTheme().heading4.copyWith(
                    fontWeight: FontWeights.bold,
                    color: PreMedColorTheme().primaryColorRed,
                  ),
            ),
            SizedBoxes.horizontalMicro,
            SizedBoxes.horizontalMicro,
            Text(
              '${bundle.bundlePrice}',
              style: TextStyle(
                color: PreMedColorTheme().neutral500,
                fontSize: 16,
                decoration: TextDecoration.lineThrough,
              ),
            ),
          ],
        ),
        SizedBoxes.verticalMedium,
        SizedBox(
          width: 132,
          height: 40,
          child: CustomButton(
            buttonText: 'Buy Now ->',
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
