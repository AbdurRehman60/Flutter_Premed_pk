
import 'package:provider/provider.dart';
import '../../../../constants/constants_export.dart';
import '../../../../providers/mcatqbankprovider.dart';
import '../../../../providers/nums_qbank_provider.dart';
import '../../../../providers/pu_qbank_provider.dart';
import '../../The vault/screens/topical_notes.dart';
import '../widgets/deckgroup_maker.dart';

class MDCATQbankHome extends StatefulWidget {
  const MDCATQbankHome({super.key});

  @override
  State<MDCATQbankHome> createState() => _MDCATQbankHomeState();
}

class _MDCATQbankHomeState extends State<MDCATQbankHome>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          backgroundColor: PreMedColorTheme().white,
          leading: Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 2),
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_new_rounded,
                  color: PreMedColorTheme().primaryColorRed),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          automaticallyImplyLeading: false,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'MDCAT QBank',
                      style: PreMedTextTheme().heading6.copyWith(
                            color: PreMedColorTheme().black,
                            fontSize: 34,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(10),
              child: TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(text: 'YEARLY'),
                  Tab(text: 'TOPICAL'),
                ],
                unselectedLabelColor: Colors.black,
                labelColor: PreMedColorTheme().white,
                indicator: BoxDecoration(
                  border: Border.all(
                      width: 3, color: PreMedColorTheme().primaryColorRed200),
                  borderRadius: BorderRadius.circular(10),
                  color: PreMedColorTheme().primaryColorRed,
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                labelPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              ),
            ),
          ),
          SizedBoxes.verticalMedium,
          Text(
            'Attempt a Full-Length Yearly Paper today and experience the feeling of giving the exam on the actual test day!',
            textAlign: TextAlign.center,
            style: PreMedTextTheme().subtext.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: PreMedColorTheme().black,
                ),
          ),
          Expanded(
            child: Consumer<MDCATQbankpro>(
              builder: (context, qbankProvider, _) {
                switch (qbankProvider.fetchStatus) {
                  case MdcatFetchStatus.init:
                  case MdcatFetchStatus.fetching:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case MdcatFetchStatus.success:
                    return TabBarView(
                      controller: _tabController,
                      children: [
                        DeckGroupList(
                          deckGroups: qbankProvider.deckGroups
                              .where(
                                  (deckGroup) => deckGroup.deckType == 'Yearly')
                              .toList(),
                          qbankGroupname: 'MDCAT QBank',
                        ),
                        DeckGroupList(
                          deckGroups: qbankProvider.deckGroups
                              .where((deckGroup) =>
                                  deckGroup.deckType == 'Topical')
                              .toList(),
                          qbankGroupname: 'MDCAT QBank',
                        ),
                      ],
                    );
                  case MdcatFetchStatus.error:
                    return const Center(
                      child: Text('Error fetching deck groups'),
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ChapterWiseHome extends StatefulWidget {
  const ChapterWiseHome({super.key});

  @override
  State<ChapterWiseHome> createState() => _ChapterWiseHomeState();
}

class _ChapterWiseHomeState extends State<ChapterWiseHome> {
  @override
  Widget build(BuildContext context) {
    String _activeUniversity = 'MDCAT';

    void _handleTopicTap(String topicName) {
      setState(() {
        _activeUniversity = topicName;
      });
    }

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          backgroundColor: PreMedColorTheme().white,
          leading: Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 2),
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_new_rounded,
                  color: PreMedColorTheme().primaryColorRed),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          automaticallyImplyLeading: false,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.020),
        child: Column(
          children: [
            SizedBox(
              height: screenHeight*0.015,
            ),
            Text(
              'Chapter-Wise',
              style: PreMedTextTheme().heading6.copyWith(
                color: PreMedColorTheme().black,
                fontSize: 34,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBoxes.vertical10Px,
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  TopicButton(
                    topicName: 'MDCAT',
                    isActive: _activeUniversity == 'MDCAT',
                    onTap: (){},
                  ),
                  SizedBoxes.horizontal12Px,
                  TopicButton(
                    topicName: 'NUMS',
                    isActive: _activeUniversity == 'NUMS',
                    onTap: () => _handleTopicTap('Physics'),
                  ),
                  SizedBoxes.horizontal12Px,
                  TopicButton(
                    topicName: 'Private Universities',
                    isActive: _activeUniversity == 'Private Universities',
                    onTap: () => _handleTopicTap('Private Universities'),
                  ),
                ],
              ),
            ),
            SizedBoxes.verticalMedium,
            Text(
              'Attempt a Topical Paper today and gain the confidence you need for the actual test day!',
              textAlign: TextAlign.center,
              style: PreMedTextTheme().subtext.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: PreMedColorTheme().black,
              ),
            ),


          ],
        ),
      ),
    );
  }
}



