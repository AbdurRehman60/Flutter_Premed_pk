import 'package:premedpk_mobile_app/UI/widgets/global_widgets_export.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/models/bundle_model.dart';
import 'package:premedpk_mobile_app/providers/bundle_provider.dart';
import 'package:provider/provider.dart';

class MarketplaceTabView extends StatelessWidget {
  const MarketplaceTabView({Key? key});

  @override
  Widget build(BuildContext context) {
    print('MarketplaceTabView build');
    return DefaultTabController(
      length: 7,
      child: Column(
        children: [
          TabBar(
            isScrollable: true,
            indicatorColor: PreMedColorTheme()
                .primaryColorRed, // Set the indicator color (underline color)
            labelColor: PreMedColorTheme()
                .primaryColorRed, // Set selected tab text color
            unselectedLabelColor:
                PreMedColorTheme().neutral400, // Set unselected tab text color
            tabs: const [
              Tab(text: 'All Bundles'),
              Tab(text: 'Special Offers'),
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
                buildListView(context, 'Special Offers'),
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
    );
  }

  Widget buildListView(BuildContext context, String tabName) {
    return Consumer<BundleProvider>(
      builder: (context, bundleProvider, _) {
        print('Bundle List Length: ${bundleProvider.bundleList.length}');

        List<BundleModel> filteredList = [];

        if (tabName == 'All Bundles') {
          filteredList = bundleProvider.bundleList;
        } else if (tabName == 'Special Offers') {
          // Show bundles in the "Special Offers" tab if they have more than one included tag
          filteredList = bundleProvider.bundleList
              .where((bundle) => bundle.includedTags.length >= 2)
              .toList();
        } else if (tabName == 'Courses') {
          // Show bundles in the "Courses" tab if they have the "Course" tag
          filteredList = bundleProvider.bundleList
              .where((bundle) => bundle.includedTags.contains('Course'))
              .toList();
        } else {
          filteredList = bundleProvider.bundleList
              .where((bundle) => bundle.bundleName.contains(tabName))
              .toList();
        }

        return ListView.builder(
          itemCount: filteredList.length,
          itemBuilder: (context, index) {
            return Container(
              width: 320,
              margin: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: PreMedColorTheme().primaryColorRed,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10.0),
                color: PreMedColorTheme().white,
              ),
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
                              .copyWith(color: PreMedColorTheme().black),
                          maxLines: 2, // Adjust the number of lines as needed
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
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Text(
                        '${filteredList[index].bundleDiscount}',
                        style: PreMedTextTheme().heading6.copyWith(
                            color: PreMedColorTheme().primaryColorRed),
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
            );
          },
        );
      },
    );
  }
}
