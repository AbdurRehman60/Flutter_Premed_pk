import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:premedpk_mobile_app/UI/widgets/global_widgets_export.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/models/bundle_model.dart';
import 'package:premedpk_mobile_app/providers/bundle_provider.dart';
import 'package:provider/provider.dart';

class SpecialOffers extends StatelessWidget {
  SpecialOffers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.4,
                margin: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    color: PreMedColorTheme().white,
                    border: GradientBoxBorder(
                        gradient: LinearGradient(colors: [
                          PreMedColorTheme().primaryColorBlue,
                          PreMedColorTheme().primaryColorRed,
                        ]),
                        width: 1.5),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.network(
                            filteredList[index].bundleIcon,
                            fit: BoxFit.contain,
                            width: 30,
                            height: 30,
                          ),
                          SizedBoxes.verticalLarge,
                          Flexible(
                            child: Text(
                              '${filteredList[index].bundleName}',
                              style: PreMedTextTheme()
                                  .heading7
                                  .copyWith(color: PreMedColorTheme().black),
                              maxLines:
                                  2, // Adjust the number of lines as needed
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBoxes.verticalMedium,
                      Text(
                        filteredList[index].bundleDescription,
                        style: PreMedTextTheme().small.copyWith(
                              color: PreMedColorTheme().neutral700,
                            ),
                      ),
                      SizedBoxes.verticalMedium,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: filteredList[index]
                            .bundlePoints
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
                        children: [
                          Text(
                            '${filteredList[index].bundleDiscount}',
                            style: PreMedTextTheme().heading6.copyWith(
                                color: PreMedColorTheme().primaryColorRed),
                          ),
                          SizedBoxes.verticalMedium,
                          Text(
                            '${filteredList[index].bundlePrice}',
                            style: TextStyle(
                              color: PreMedColorTheme().neutral800,
                              fontSize: 14,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ),
                      SizedBoxes.verticalMedium,
                      SizedBox(
                        width: 150,
                        height: 40,
                        child: CustomButton(
                          buttonText: 'Buy Now ->',
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
