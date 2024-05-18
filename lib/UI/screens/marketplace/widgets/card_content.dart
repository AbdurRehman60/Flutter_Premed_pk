import 'package:premedpk_mobile_app/UI/screens/marketplace/marketplace_home.dart';
import 'package:premedpk_mobile_app/UI/screens/marketplace/widgets/custom_tag.dart';
import 'package:premedpk_mobile_app/UI/screens/marketplace/widgets/special_offers_widget.dart';
import 'package:premedpk_mobile_app/UI/widgets/global_widgets/custom_button.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/models/bundle_model.dart';
import 'package:premedpk_mobile_app/providers/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class CardContent extends StatelessWidget {
  const CardContent({
    super.key,
    required this.bundle,
    required this.renderPoints,
    this.renderDescription = true,
    this.points,
    this.small = false,
  });

  final BundleModel bundle;
  final bool renderPoints;
  final int? points;
  final bool renderDescription;
  final bool small;

  @override
  Widget build(BuildContext context) {
    final CartProvider cartProvider = Provider.of<CartProvider>(context);
    final bool isBundleInCart = cartProvider.selectedBundles.contains(bundle);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Row(
            children: [
              if (small)
                const SizedBox()
              else ...{
                buildBundleIcon(bundle.bundleIcon),
                SizedBoxes.horizontalMedium,
              },
              Flexible(
                child: RichText(
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    text: bundle.bundleName.split(' ').first,
                    style: PreMedTextTheme().heading5.copyWith(
                          color: PreMedColorTheme().primaryColorRed,
                          fontSize: small ? 16 : 20,
                          fontWeight: FontWeight.w600,
                        ),
                    children: <TextSpan>[
                      TextSpan(
                        text:
                            ' ${bundle.bundleName.split(' ').skip(1).join(' ')}',
                        style: PreMedTextTheme().heading5.copyWith(
                              color: PreMedColorTheme().black,
                              fontSize: small ? 16 : 20,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        if (renderDescription)
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16),
            child: Text(
              bundle.bundleDescription,
              style: PreMedTextTheme().body.copyWith(
                    height: 1.5,
                    color: PreMedColorTheme().neutral600,
                  ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          )
        else
          const SizedBox(),
        if (renderPoints)
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: bundle.bundlePoints
                  .take(5)
                  .map(
                    (point) => Row(
                      children: [
                        Flexible(
                          child: Text(
                            '✔ $point',
                            style: PreMedTextTheme().small.copyWith(
                                  color: PreMedColorTheme().neutral600,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  height: 1.5,
                                ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          )
        else
          const SizedBox(),
        SizedBoxes.verticalMedium,
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Row(
            children: [
              Text(
                'Rs. ${(bundle.bundlePrice - bundle.bundleDiscount).round()}',
                style: PreMedTextTheme().heading4.copyWith(
                      fontWeight: FontWeights.bold,
                      color: PreMedColorTheme().primaryColorRed,
                      fontSize: small ? 16 : 20,
                    ),
              ),
              SizedBoxes.horizontalMicro,
              SizedBoxes.horizontalMicro,
              Text(
                'Rs. ${bundle.bundlePrice}',
                style: TextStyle(
                  color: PreMedColorTheme().neutral500,
                  fontSize: small ? 14 : 20,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          ),
        ),
        if (!small) SizedBoxes.verticalMedium,
        if (bundle.bundleName.toLowerCase().contains("course") ||
            bundle.bundleName.toLowerCase().contains("counselling")) ...{
          SizedBox(
            height: 90,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.25,
                      height: 40,
                      child: CustomButton(
                        buttonText: 'Buy Now',
                        onPressed: () {
                          launchUrl(
                            mode: LaunchMode.inAppBrowserView,
                            Uri.parse('https://premed.pk/pricing/counselling'),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      width: 130,
                      height: 40,
                      child: CustomButton(
                        isIconButton: true,
                        color: Colors.transparent,
                        textColor: PreMedColorTheme().neutral800,
                        leftIcon: false,
                        isOutlined: true,
                        fontSize: 16,
                        iconSize: 0,
                        buttonText: "I'm interested",
                        fontWeight: FontWeights.medium,
                        onPressed: () {
                          launchUrl(
                            Uri.parse(bundle.interestedFormLink!),
                            mode: LaunchMode.inAppWebView,
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: CustomButton(
                        color: Colors.transparent,
                        fontSize: 16,
                        fontWeight: FontWeights.medium,
                        textColor: PreMedColorTheme().neutral800,
                        buttonText: 'View Details',
                        onPressed: () {
                          launchUrl(
                            Uri.parse(bundle.bundlePDF!),
                            mode: LaunchMode.inAppWebView,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        } else if (!isBundleInCart) ...{
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: 40,
                  child: CustomButton(
                    buttonText: 'Buy Now',
                    onPressed: () {
                      cartProvider.addToCart(bundle);
                      MarketPlace.openDrawer();
                    },
                  ),
                ),
              ),
              const SizedBox(
                width: 120,
                height: 50,
                child: RibbonTag(
                  imagePath: 'assets/images/Subtract.png',
                  text: 'Best Value',
                ),
              ),
            ],
          ),
        },
      ],
    );
  }
}
