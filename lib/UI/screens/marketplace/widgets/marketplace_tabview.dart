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
              padding: const EdgeInsets.all(10.0),
              child: SpecialOfferCard(bundle: filteredList[index]),
            );
          },
        );
      },
    );
  }
}
