import 'package:premedpk_mobile_app/UI/screens/The%20vault/widgets/topic_button.dart';
import 'package:premedpk_mobile_app/UI/screens/qbank/widgets/deck_tile.dart';
import 'package:provider/provider.dart';
import '../../../constants/constants_export.dart';
import '../../../providers/mdcat_mocks_provider.dart';
import '../../../providers/nums_mocks_provider.dart';
import '../../../providers/pu_mocks_provider.dart';
import '../The vault/widgets/back_button.dart';
class MocksQbank extends StatefulWidget {
  const MocksQbank({super.key,});

  @override
  State<MocksQbank> createState() => _MocksQbankState();
}

class _MocksQbankState extends State<MocksQbank>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String selectedCategory = 'MDCAT';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    Future.delayed(Duration.zero, () {
      Provider.of<MdcatMocksProviderr>(context, listen: false).fetchDeckGroups();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _updateCategory(String category) {
    setState(() {
      selectedCategory = category;
      if (category == 'MDCAT') {
        Provider.of<MdcatMocksProviderr>(context, listen: false).fetchDeckGroups();
      } else if (category == 'NUMS') {
        Provider.of<NumsMocksProvider>(context, listen: false)
            .fetchDeckGroups();
      } else if (category == 'Private Universities') {
        Provider.of<PrivuniMocksProvider>(context, listen: false).fetchDeckGroups();
      }
    });
  }

  Widget _buildDeckGroupList(String category) {
    switch (category) {
      case 'MDCAT':
        return Consumer<MdcatMocksProviderr>(
          builder: (context, qbankProvider, _) {
            switch (qbankProvider.fetchStatus) {
              case FetchhStatus.init:
              case FetchhStatus.fetching:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case FetchhStatus.success:
                final filteredDeckGroups = qbankProvider.deckGroups;
                return ListView.builder(
                  itemCount: filteredDeckGroups.length,
                  itemBuilder: (context, index) {
                    final deckGroup = filteredDeckGroups[index];
                    return DeckTile(
                      deckGroup: deckGroup,
                      deckGroupName: 'MDCAT Mocks',
                    );
                  },
                );
              case FetchhStatus.error:
                return const Center(
                  child: Text('Error fetching deck groups'),
                );
            }
          },
        );
      case 'NUMS':
        return Consumer<NumsMocksProvider>(
          builder: (context, qbankProvider, _) {
            switch (qbankProvider.fetchStatus) {
              case NumsMockFetchStatus.init:
              case NumsMockFetchStatus.fetching:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case NumsMockFetchStatus.success:
                final filteredDeckGroups = qbankProvider.deckGroups;
                return ListView.builder(
                  itemCount: filteredDeckGroups.length,
                  itemBuilder: (context, index) {
                    final deckGroup = filteredDeckGroups[index];
                    return DeckTile(
                      deckGroup: deckGroup,
                      deckGroupName: 'NUMS Mocks',
                    );
                  },
                );
              case NumsMockFetchStatus.error:
                return const Center(
                  child: Text('Error fetching deck groups'),
                );
            }
          },
        );
      case 'Private Universities':
        return Consumer<PrivuniMocksProvider>(
          builder: (context, qbankProvider, _) {
            switch (qbankProvider.fetchStatus) {
              case PuMocksFetchStatus.init:
              case PuMocksFetchStatus.fetching:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case PuMocksFetchStatus.success:
                final filteredDeckGroups = qbankProvider.deckGroups;
                return ListView.builder(
                  itemCount: filteredDeckGroups.length,
                  itemBuilder: (context, index) {
                    final deckGroup = filteredDeckGroups[index];
                    return DeckTile(
                      deckGroup: deckGroup,
                      deckGroupName: 'Private Universities Mocks',
                    );
                  },
                );
              case PuMocksFetchStatus.error:
                return const Center(
                  child: Text('Error fetching deck groups'),
                );
            }
          },
        );
      default:
        return Container();
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PreMedColorTheme().background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13),
          child: AppBar(
            backgroundColor: PreMedColorTheme().background,
            leading: const PopButton(),
            automaticallyImplyLeading: false,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mock Tests',
                  style: PreMedTextTheme().heading6.copyWith(
                    color: PreMedColorTheme().black,
                    fontSize: 34,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBoxes.vertical5Px,
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.065),
            child: Row(
              children: [
                Wrap(
                  spacing: 6, // Horizontal space between items
                  runSpacing: 10, // Vertical space between lines
                  children: [
                    TopicButton(
                      topicName: 'MDCAT',
                      isActive: selectedCategory == 'MDCAT',
                      onTap: () => _updateCategory('MDCAT'),
                    ),
                    TopicButton(
                      topicName: 'NUMS',
                      isActive: selectedCategory == 'NUMS',
                      onTap: () => _updateCategory('NUMS'),
                    ),
                    TopicButton(
                      topicName: 'Private Universities',
                      isActive: selectedCategory == 'Private Universities',
                      onTap: () => _updateCategory('Private Universities'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBoxes.vertical15Px,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'Attempt a Mock Test today and gain the confidence you need for the actual test day!',
              style: PreMedTextTheme().heading6.copyWith(
                color: PreMedColorTheme().black,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBoxes.vertical10Px,
          Expanded(
            child: _buildDeckGroupList(selectedCategory),
          ),
        ],
      ),
    );
  }





}

