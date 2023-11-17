import 'package:premedpk_mobile_app/UI/screens/marketplace/widgets/modal_bottom_sheet.dart';
import 'package:premedpk_mobile_app/UI/screens/marketplace/widgets/special_offers_widget.dart';
import 'package:premedpk_mobile_app/UI/widgets/global_widgets_export.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/models/bundle_model.dart';
import 'package:premedpk_mobile_app/providers/bundle_provider.dart';
import 'package:provider/provider.dart';

class MarketplaceTabView extends StatelessWidget {
  const MarketplaceTabView({Key? key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: SliverFillRemaining(
        child: Column(
          children: [
            TabBar(
              isScrollable: true,
              indicatorColor: PreMedColorTheme().primaryColorRed,
              labelColor: PreMedColorTheme().primaryColorRed,
              unselectedLabelColor: PreMedColorTheme().neutral400,
              tabs: const [
                Tab(text: 'All Bundles'),
                // Tab(text: 'Special Offers'),
                Tab(text: 'AKU'),
                Tab(text: 'MDCAT'),
                Tab(text: 'NUMS'),
                Tab(text: 'Courses'),
                Tab(text: 'Coins'),
              ],
            ),
            // TabBarView
            Expanded(
              child: TabBarView(
                children: [
                  // Content for 'All Bundles' Tab
                  buildListView(context, 'All Bundles'),
                  // Content for 'Special Offers' Tab
                  // buildListView(context, 'Special Offers'),
                  // Content for 'AKU' Tab
                  buildListView(context, 'AKU'),
                  // Content for 'MDCAT' Tab
                  buildListView(context, 'MDCAT'),
                  // Content for 'NUMS' Tab
                  buildListView(context, 'NUMS'),
                  // Content for 'Courses' Tab
                  buildListView(context, 'Courses'),
                  // Content for 'Coins' Tab
                  buildListView(context, 'Coins'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildListView(BuildContext context, String tabName) {
    return Consumer<BundleProvider>(
      builder: (context, bundleProvider, _) {
        List<BundleModel> filteredList = [];

        if (tabName == 'All Bundles') {
          filteredList = bundleProvider.bundleList;
        } else if (tabName == 'Special Offers') {
          filteredList = bundleProvider.bundleList
              .where((bundle) => bundle.includedTags.length >= 2)
              .toList();
        } else if (tabName == 'Courses') {
          filteredList = bundleProvider.bundleList
              .where((bundle) => bundle.includedTags.contains('Course'))
              .toList();
        } else {
          filteredList = bundleProvider.bundleList
              .where((bundle) => bundle.bundleName.contains(tabName))
              .toList();
        }

        return ListView.builder(
          shrinkWrap: true,
          itemCount: filteredList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: TabsCard(bundle: filteredList[index]),
            );
          },
        );
      },
    );
  }
}

class TabsCard extends StatelessWidget {
  const TabsCard({
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
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: PreMedColorTheme().neutral200,
              width: 2,
            )),
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
              SizedBoxes.verticalMicro,
              SizedBoxes.verticalMicro,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: bundle.bundlePoints
                    .take(5) // Take the first 5 points
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
                              maxLines:
                                  1, // Set the maximum number of lines to 1
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
