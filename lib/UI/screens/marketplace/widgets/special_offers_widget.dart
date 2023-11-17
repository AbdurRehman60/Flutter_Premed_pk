import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:premedpk_mobile_app/UI/screens/marketplace/widgets/modal_bottom_sheet.dart';
import 'package:premedpk_mobile_app/UI/widgets/global_widgets_export.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/models/bundle_model.dart';
import 'package:premedpk_mobile_app/providers/bundle_provider.dart';
import 'package:provider/provider.dart';

class SpecialOffers extends StatelessWidget {
  const SpecialOffers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
          ),
          child: Text(
            'Special Offers',
            style: PreMedTextTheme().heading6,
          ),
        ),
        SizedBoxes.verticalBig,
        SizedBox(
          // height: MediaQuery.of(context).size.height * 0.3,
          height: 300,
          child: Consumer<BundleProvider>(
            builder: (context, bundleProvider, _) {
              List<BundleModel> filteredList = bundleProvider.bundleList
                  .where((bundle) => bundle.includedTags.length >= 2)
                  .toList();

              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin:
                        EdgeInsets.only(left: index == 0 ? 20 : 0, right: 20),
                    child: SpecialOfferCard(bundle: filteredList[index]),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({
    super.key,
    required this.bundle,
  });

  final BundleModel bundle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return ModalSheetWidget(bundle: bundle);
          },
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        // margin: const EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(
          color: PreMedColorTheme().white,
          border: GradientBoxBorder(
              gradient: LinearGradient(colors: [
                PreMedColorTheme().primaryColorBlue,
                PreMedColorTheme().primaryColorRed,
              ]),
              width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
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
              Text(
                bundle.bundleDescription,
                style: PreMedTextTheme().body.copyWith(
                      height: 1.5,
                      color: PreMedColorTheme().neutral600,
                    ),
                maxLines: 4, // Set the number of lines you want to show
                overflow: TextOverflow.ellipsis,
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
        ),
      ),
    );
  }
}

Widget buildBundleIcon(String imageUrl) {
  return Image.network(
    imageUrl,
    fit: BoxFit.contain,
    width: 36,
    height: 36,
    errorBuilder: (context, error, stackTrace) {
      return Image.network(
        "https://premedpk-cdn.sgp1.cdn.digitaloceanspaces.com/CustomImages/PreMedCircleLogo.cffae65f.png",
        fit: BoxFit.contain,
        width: 36,
        height: 36,
      );
    },
  );
}
