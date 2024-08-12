import 'package:provider/provider.dart';
import '../../../../UI/screens/qbank/widgets/deck_tile.dart';
import '../../../../constants/constants_export.dart';
import '../../../providers/med_test_session_pro.dart';
import '../The vault/widgets/back_button.dart';

class MedTestSessionHome extends StatefulWidget {
  const MedTestSessionHome({super.key});

  @override
  State<MedTestSessionHome> createState() => _MedTestSessionHomeState();
}

class _MedTestSessionHomeState extends State<MedTestSessionHome>
    with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<MedTestSessionsPro>(context, listen: false).fetchDeckGroups();
    });
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
                      'Test Sessions',
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
                'Attempt a Full-Length Yearly Paper today and gain the confidence you need for the actual test day!',
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
            child: Consumer<MedTestSessionsPro>(
              builder: (context, provider, _) {
                switch (provider.fetchStatus) {
                  case DeckFetchStatus.init:
                  case DeckFetchStatus.fetching:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case DeckFetchStatus.success:
                    final filteredDeckGroups = provider.deckGroups
                        .where((deckGroup) => deckGroup.deckType == 'Yearly')
                        .toList();
                    return ListView.builder(
                      itemCount: filteredDeckGroups.length,
                      itemBuilder: (context, index) {
                        final deckGroup = filteredDeckGroups[index];
                        return DeckTile(
                            deckGroup: deckGroup, deckGroupName: 'MDCAT QBank');
                      },
                    );
                  case DeckFetchStatus.error:
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
