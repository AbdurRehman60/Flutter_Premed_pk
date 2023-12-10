import 'package:premedpk_mobile_app/UI/widgets/global_widgets/custom_button.dart';
import 'package:premedpk_mobile_app/UI/screens/marketplace/widgets/special_offers_widget.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/models/bundle_model.dart';
import 'package:premedpk_mobile_app/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CardContent extends StatelessWidget {
  const CardContent({
    Key? key,
    required this.bundle,
    required this.renderPoints,
    this.renderDescription = true,
    this.points,
  }) : super(key: key);

  final BundleModel bundle;
  final bool renderPoints;
  final int? points;
  final renderDescription;

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    bool isBundleInCart = cartProvider.selectedBundles.contains(bundle);

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
        renderDescription
            ? Text(
                bundle.bundleDescription,
                style: PreMedTextTheme().body.copyWith(
                      height: 1.5,
                      color: PreMedColorTheme().neutral600,
                    ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              )
            : SizedBox(),
        renderPoints
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: bundle.bundlePoints
                    .take(5) // Take the first 5 points
                    .map(
                      (point) => Row(
                        children: [
                          // Text('✅'),
                          // SizedBoxes.verticalMicro,
                          Flexible(
                            child: Text(
                              '✅ ${point}',
                              style: PreMedTextTheme().small.copyWith(
                                    color: PreMedColorTheme().neutral600,
                                    height: 1.5,
                                  ),
                              maxLines:
                                  1, // Set the maximum number of lines to 1
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              )
            : SizedBox(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '${(bundle.bundlePrice - bundle.bundleDiscount).round()}',
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
        SizedBoxes.verticalMicro,
        SizedBoxes.verticalMicro,
        if (!isBundleInCart)
          SizedBox(
            width: 132,
            height: 40,
            child: CustomButton(
              buttonText: 'Buy Now ->',
              onPressed: () {
                cartProvider.addToCart(bundle);
              },
            ),
          ),
      ],
    );
  }
}
