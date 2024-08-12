import 'package:premedpk_mobile_app/UI/screens/The%20vault/widgets/back_button.dart';
import 'package:premedpk_mobile_app/UI/screens/The%20vault/widgets/topic_button.dart';
import 'package:premedpk_mobile_app/UI/screens/qbank/widgets/deck_tile.dart';
import 'package:provider/provider.dart';
import '../../../../constants/constants_export.dart';
import '../../../../providers/mcatqbankprovider.dart';
import '../../../../providers/nums_qbank_provider.dart';
import '../../../../providers/pu_qbank_provider.dart';

class GlobalQbank extends StatefulWidget {
  const GlobalQbank({super.key, required this.isTopical});
  final bool isTopical;

  @override
  State<GlobalQbank> createState() => _GlobalQbankState();
}

class _GlobalQbankState extends State<GlobalQbank>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String selectedCategory = 'MDCAT';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    Future.delayed(Duration.zero, () {
      Provider.of<MDCATQbankpro>(context, listen: false).fetchDeckGroups();
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
        Provider.of<MDCATQbankpro>(context, listen: false).fetchDeckGroups();
      } else if (category == 'NUMS') {
        Provider.of<NUMSQbankProvider>(context, listen: false)
            .fetchDeckGroups();
      } else if (category == 'Private Universities') {
        Provider.of<PUQbankProvider>(context, listen: false).fetchDeckGroups();
      }
    });
  }

  Widget _buildDeckGroupList(String category) {
    switch (category) {
      case 'MDCAT':
        return Consumer<MDCATQbankpro>(
          builder: (context, qbankProvider, _) {
            switch (qbankProvider.fetchStatus) {
              case MdcatFetchStatus.init:
              case MdcatFetchStatus.fetching:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case MdcatFetchStatus.success:
                final filteredDeckGroups = qbankProvider.deckGroups
                    .where((deckGroup) =>
                        deckGroup.deckType ==
                        (widget.isTopical ? 'Topical' : 'Yearly'))
                    .toList();
                return ListView.builder(
                  itemCount: filteredDeckGroups.length,
                  itemBuilder: (context, index) {
                    final deckGroup = filteredDeckGroups[index];
                    return DeckTile(
                        deckGroup: deckGroup, deckGroupName: 'MDCAT QBANK');
                  },
                );
              case MdcatFetchStatus.error:
                return const Center(
                  child: Text('Error fetching deck groups'),
                );
            }
          },
        );
      case 'NUMS':
        return Consumer<NUMSQbankProvider>(
          builder: (context, qbankProvider, _) {
            switch (qbankProvider.fetchStatus) {
              case NumsFetchStatus.init:
              case NumsFetchStatus.fetching:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case NumsFetchStatus.success:
                final filteredDeckGroups = qbankProvider.deckGroups
                    .where((deckGroup) =>
                        deckGroup.deckType ==
                        (widget.isTopical ? 'Topical' : 'Yearly'))
                    .toList();
                return ListView.builder(
                  itemCount: filteredDeckGroups.length,
                  itemBuilder: (context, index) {
                    final deckGroup = filteredDeckGroups[index];
                    return DeckTile(
                        deckGroup: deckGroup, deckGroupName: 'NUMS QBANK');
                  },
                );
              case NumsFetchStatus.error:
                return const Center(
                  child: Text('Error fetching deck groups'),
                );
            }
          },
        );
      case 'Private Universities':
        return Consumer<PUQbankProvider>(
          builder: (context, qbankProvider, _) {
            switch (qbankProvider.fetchStatus) {
              case PuFetchStatus.init:
              case PuFetchStatus.fetching:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case PuFetchStatus.success:
                final filteredDeckGroups = qbankProvider.deckGroups
                    .where((deckGroup) => deckGroup.deckType == 'Yearly')
                    .toList();
                return ListView.builder(
                  itemCount: filteredDeckGroups.length,
                  itemBuilder: (context, index) {
                    final deckGroup = filteredDeckGroups[index];
                    return DeckTile(
                        deckGroup: deckGroup, deckGroupName: 'PU QBANK');
                  },
                );
              case PuFetchStatus.error:
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
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 24),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.isTopical ? 'Chapter-Wise' : 'Yearly-Past Papers',
                      style: PreMedTextTheme().heading6.copyWith(
                            color: PreMedColorTheme().black,
                            fontSize: 34,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                  ),
                  SizedBoxes.vertical22Px,
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                TopicButton(
                  topicName: widget.isTopical ? 'MDCAT' : 'MDCAT Yearly',
                  isActive: selectedCategory == 'MDCAT',
                  onTap: () => _updateCategory('MDCAT'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 13),
                  child: TopicButton(
                    topicName: widget.isTopical ? 'NUMS' : 'NUMS Yearly',
                    isActive: selectedCategory == 'NUMS',
                    onTap: () => _updateCategory('NUMS'),
                  ),
                ),
                Visibility(
                  visible: widget.isTopical,
                  child: TopicButton(
                    topicName: 'Private Universities',
                    isActive: selectedCategory == 'Private Universities',
                    onTap: () => _updateCategory('Private Universities'),
                  ),
                ),
              ],
            ),
          ),
          SizedBoxes.vertical26Px,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              widget.isTopical
                  ? 'Attempt a Topical Paper today and gain the confidence you need for the actual test day!'
                  : 'Attempt a Yearly Paper today and gain the confidence you need for the actual test day!',
              style: PreMedTextTheme().heading6.copyWith(
                    color: PreMedColorTheme().black,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
            ),
          ),
          SizedBoxes.vertical22Px,
          Expanded(
            child: _buildDeckGroupList(selectedCategory),
          ),
        ],
      ),
    );
  }
}
