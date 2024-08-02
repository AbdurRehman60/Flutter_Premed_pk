import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../constants/constants_export.dart';
import '../../../../providers/nums_qbank_provider.dart';
import '../widgets/deckgroup_maker.dart';

class NUMSQbankHome extends StatefulWidget {
  const NUMSQbankHome({super.key});

  @override
  State<NUMSQbankHome> createState() => _NUMSQbankHomeState();
}

class _NUMSQbankHomeState extends State<NUMSQbankHome> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    Future.delayed(Duration.zero, () {
      Provider.of<NUMSQbankProvider>(context, listen: false).fetchDeckGroups();
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
                      'NUMS QBank',
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
                      width: 3,
                      color: PreMedColorTheme().primaryColorRed200),
                  borderRadius: BorderRadius.circular(10),
                  color: PreMedColorTheme().primaryColorRed,
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                labelPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              ),
            ),
          ),
          SizedBoxes.verticalMedium,Text(
            'Attempt a Full-Length Yearly Paper today and experience the feeling of giving the exam on the actual test day!',
            textAlign: TextAlign.center,
            style: PreMedTextTheme().subtext.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: PreMedColorTheme().black,
            ),
          ),
          Expanded(
            child: Consumer<NUMSQbankProvider>(
              builder: (context, numsqbankpro, _) {
                switch (numsqbankpro.fetchStatus) {
                  case NumsFetchStatus.init:
                  case NumsFetchStatus.fetching:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case NumsFetchStatus.success:
                    return TabBarView(
                      controller: _tabController,
                      children: [
                        DeckGroupList(
                          deckGroups: numsqbankpro.deckGroups
                              .where((deckGroup) => deckGroup.deckType == 'Yearly')
                              .toList(), qbankGroupname: 'NUMS QBank',
                        ),
                        DeckGroupList(
                          deckGroups: numsqbankpro.deckGroups
                              .where((deckGroup) => deckGroup.deckType == 'Topical')
                              .toList(), qbankGroupname: 'NUMS QBank',
                        ),
                      ],
                    );
                  case NumsFetchStatus.error:
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
