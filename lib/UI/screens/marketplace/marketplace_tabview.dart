import 'package:premedpk_mobile_app/constants/constants_export.dart';

class MarketplaceTabView extends StatelessWidget {
  const MarketplaceTabView({Key? key});

  @override
  Widget build(BuildContext context) {
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
          const Expanded(
            child: TabBarView(
              children: [
                // Content for 'All Bundles' Tab
                Center(
                  child: Text('Content for All Bundles Tab'),
                ),
                // Content for 'Special Offers' Tab
                Center(
                  child: Text('Content for Special Offers Tab'),
                ),
                // Content for 'AKU' Tab
                Center(
                  child: Text('Content for AKU Tab'),
                ),
                // Content for 'MDCAT' Tab
                Center(
                  child: Text('Content for MDCAT Tab'),
                ),
                // Content for 'NUMS' Tab
                Center(
                  child: Text('Content for NUMS Tab'),
                ),
                // Content for 'Courses' Tab
                Center(
                  child: Text('Content for Courses Tab'),
                ),
                // Content for 'Coins' Tab
                Center(
                  child: Text('Content for Coins Tab'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
