import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../UI/screens/The vault/widgets/back_button.dart';
import '../../../../UI/screens/qbank/widgets/deck_tile.dart';
import '../../../../constants/constants_export.dart';
import '../../../providers/chapterWiseProvider.dart';

class EngChapterWiseHome extends StatefulWidget {
  const EngChapterWiseHome({super.key});

  @override
  State<EngChapterWiseHome> createState() => _EngChapterWiseHomeState();
}

class _EngChapterWiseHomeState extends State<EngChapterWiseHome>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    Future.delayed(Duration.zero, () {
      Provider.of<EngChapterWisePro>(context, listen: false).fetchDeckGroups();
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
                      'Pre-Engineering Topicals',
                      style: PreMedTextTheme().heading6.copyWith(
                        color: PreMedColorTheme().black,
                        fontSize: 34,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBoxes.vertical22Px,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Flexible(
              child: Text(
                'Attempt these Topicals to prepare for your Engineering Entrance Exams',
                style: PreMedTextTheme().heading6.copyWith(
                  color: PreMedColorTheme().black,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          SizedBoxes.verticalMedium,
          Expanded(
            child: Consumer<EngChapterWisePro>(
              builder: (context, provider, _) {
                switch (provider.fetchStatus) {
                  case ChapterWiseFetchStatus.init:
                  case ChapterWiseFetchStatus.fetching:
                    return  Center(
                      child: CircularProgressIndicator(color: PreMedColorTheme().blue,),
                    );
                  case ChapterWiseFetchStatus.success:
                    final filteredDeckGroups = provider.deckGroups
                        .where((deckGroup) => deckGroup.deckType == 'Topical')
                        .toList();
                    return ListView.builder(
                      itemCount: filteredDeckGroups.length,
                      itemBuilder: (context, index) {
                        final deckGroup = filteredDeckGroups[index];
                        return DeckTile(
                            deckGroup: deckGroup, deckGroupName: 'Engineering QBank');
                      },
                    );
                  case ChapterWiseFetchStatus.error:
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
