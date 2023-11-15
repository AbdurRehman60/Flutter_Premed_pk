import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:premedpk_mobile_app/UI/screens/marketplace/widgets/marketplace_tabview.dart';
import 'package:premedpk_mobile_app/UI/widgets/global_widgets_export.dart';
import 'package:premedpk_mobile_app/models/bundle_model.dart';
import 'package:premedpk_mobile_app/providers/bundle_provider.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import '../../../constants/constants_export.dart';
// Import your text theme

class MarketPlace extends StatelessWidget {
  MarketPlace({Key? key, required this.tabName}) : super(key: key);

  final String tabName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            GradientText('PreMed.PK Bundles',
                style: PreMedTextTheme().heading3,
                colors: [
                  PreMedColorTheme().primaryColorBlue,
                  PreMedColorTheme().primaryColorRed,
                ]),
            const Text('Timer widget here'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  tabName, // Display the current tab name (you can modify this as needed)
                  textAlign: TextAlign.left,
                  style: PreMedTextTheme().subtext,
                ),
              ),
            ),
            // Horizontal ListView
            SizedBox(
              height: 480, // Adjust the height as needed
              child: Consumer<BundleProvider>(
                builder: (context, bundleProvider, _) {
                  List<BundleModel> filteredList = [];

                  if (tabName == 'Special Offers') {
                    // Show bundles in the "Special Offers" tab if they have more than one included tag
                    filteredList = bundleProvider.bundleList
                        .where((bundle) => bundle.includedTags.length >= 2)
                        .toList();
                  } else {
                    // Default behavior or handle other tab conditions
                    filteredList = bundleProvider.bundleList;
                  }

                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 240,
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
                                  SizedBox(width: 8),
                                  Flexible(
                                    child: Text(
                                      '${filteredList[index].bundleName}',
                                      style: PreMedTextTheme()
                                          .heading7
                                          .copyWith(
                                              color: PreMedColorTheme().black),
                                      maxLines:
                                          2, // Adjust the number of lines as needed
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Text(
                                filteredList[index].bundleDescription,
                                style: PreMedTextTheme().small.copyWith(
                                      color: PreMedColorTheme().neutral700,
                                    ),
                              ),
                              SizedBox(height: 8),
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
                                              style: PreMedTextTheme()
                                                  .small
                                                  .copyWith(
                                                    color: PreMedColorTheme()
                                                        .black,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                    .toList(),
                              ),
                              SizedBox(height: 16),
                              Row(
                                children: [
                                  Text(
                                    '${filteredList[index].bundleDiscount}',
                                    style: PreMedTextTheme().heading6.copyWith(
                                        color:
                                            PreMedColorTheme().primaryColorRed),
                                  ),
                                  SizedBox(width: 8),
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
                              SizedBox(height: 8),
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
            ),
            // Scrollable Tab Bar
            Expanded(
              child: MarketplaceTabView(),
            ),
          ],
        ),
      ),
    );
  }
}
