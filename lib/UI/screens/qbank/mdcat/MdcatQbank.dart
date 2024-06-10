import 'package:premedpk_mobile_app/UI/screens/qbank/providers/mcatqbankprovider.dart';
import 'package:premedpk_mobile_app/UI/screens/qbank/widgets/deckgroup_maker.dart';
import 'package:provider/provider.dart';
import '../../../../constants/constants_export.dart';
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
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: const Color(0xFFEC5863),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: const Color(0x80FFFFFF),
                  width:3,
                ),
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              labelStyle: PreMedTextTheme().heading2.copyWith(
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                  ),
              unselectedLabelStyle: PreMedTextTheme().heading2.copyWith(
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                  ),
              tabs: [
                Tab(
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    child: Center(
                      child: Text('YEARLY'),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    child: Center(
                      child: Text('TOPICAL'),
                    ),
                  ),
                ),
              ],
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
                  case FetchStatus.init:
                  case FetchStatus.fetching:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case FetchStatus.success:
                    return TabBarView(
                      controller: _tabController,
                      children: [
                        DeckGroupList(
                          deckGroups: qbankProvider.deckGroups
                              .where(
                                  (deckGroup) => deckGroup.deckType == 'Yearly')
                              .toList(), qbankGroupname: 'MDCAT QBank',
                        ),
                        DeckGroupList(
                          deckGroups: qbankProvider.deckGroups
                              .where((deckGroup) =>
                                  deckGroup.deckType == 'Topical')
                              .toList(), qbankGroupname: 'MDCAT QBank',
                        ),
                      ],
                    );
                  case FetchStatus.error:
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
