import 'package:premedpk_mobile_app/UI/screens/marketplace/widgets/special_offers_widget.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/models/bundle_model.dart';

class ModalSheetWidget extends StatelessWidget {
  const ModalSheetWidget({
    super.key,
    required this.bundle,
  });
  final BundleModel bundle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                    text: bundle.bundleName.split(' ').first,
                    style: PreMedTextTheme().heading5.copyWith(
                          color: PreMedColorTheme().primaryColorRed,
                        ),
                    children: <TextSpan>[
                      TextSpan(
                        text:
                            ' ${bundle.bundleName.split(' ').skip(1).join(' ')}',
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
          SizedBoxes.verticalMedium,
          Text(
            bundle.bundleDescription,
            style: PreMedTextTheme().body.copyWith(
                  height: 1.5,
                  color: PreMedColorTheme().neutral600,
                ),
          ),
          SizedBoxes.verticalMedium,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: bundle.bundlePoints
                .map(
                  (point) => Row(
                    children: [
                      Flexible(
                        child: Text(
                          '✅ $point',
                          style: PreMedTextTheme().small.copyWith(
                                color: PreMedColorTheme().neutral600,
                                height: 1.5,
                              ),
                          maxLines: 1, // Set the maximum number of lines to 1
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
          SizedBoxes.verticalMedium,
          Row(
            children: [
              Text(
                'Rs. ${(bundle.bundlePrice - bundle.bundleDiscount).round()}',
                style: PreMedTextTheme().heading4.copyWith(
                      fontWeight: FontWeights.bold,
                      color: PreMedColorTheme().primaryColorRed,
                    ),
              ),
              SizedBoxes.horizontalMicro,
              SizedBoxes.horizontalMicro,
              Text(
                'Rs. ${bundle.bundlePrice}',
                style: TextStyle(
                  color: PreMedColorTheme().neutral500,
                  fontSize: 16,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
