import 'package:premedpk_mobile_app/UI/screens/marketplace/widgets/special_offers_widget.dart';
import 'package:premedpk_mobile_app/UI/widgets/global_widgets_export.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/models/bundle_model.dart';

class ModalSheetWidget extends StatelessWidget {
  final BundleModel bundle;

  ModalSheetWidget({required this.bundle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
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
          SizedBoxes.verticalMicro,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: bundle.bundlePoints
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
          ),
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
      ),
    );
  }
}
