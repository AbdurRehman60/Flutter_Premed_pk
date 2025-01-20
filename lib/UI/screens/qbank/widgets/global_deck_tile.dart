import 'package:premedpk_mobile_app/providers/vaultProviders/premed_provider.dart';
import 'package:provider/provider.dart';
import '../../../../constants/constants_export.dart';
import '../../../../models/deck_group_model.dart';
import '../../mocks/widgets/new_bottom_sheet.dart';
import 'logo_avatar.dart';

class GlobalDeckTile extends StatelessWidget {
  const GlobalDeckTile(
      {super.key, required this.deckGroup, required this.deckGroupName});
  final DeckGroupModel deckGroup;
  final String deckGroupName;

  @override
  Widget build(BuildContext context) {
    
    final uniquePublishedDecks = _getDecksWithBothPracticeAndPastPaper(deckGroup.deckItems);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
      child: GestureDetector(
        onTap: () {
          _openBottomSheet(context, deckGroup, deckGroupName);
        },
        child: Container(
          height: 108,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.85),
            border: Border.all(color: Colors.white.withOpacity(0.5)),
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                color: Color(0xff26000000),
                blurRadius: 40,
                offset: Offset(0, 20),
              ),
            ],
          ),
          child: ListTile(
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 25).copyWith(bottom: 12),
            leading: GetLogo(url: deckGroup.deckGroupImage ?? ''),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  deckGroup.deckGroupName,
                  style: PreMedTextTheme()
                      .heading3
                      .copyWith(fontWeight: FontWeight.w800, fontSize: 20),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
                SizedBoxes.vertical2Px,
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '${uniquePublishedDecks.length} ',  
                        style: PreMedTextTheme()
                            .heading5
                            .copyWith(fontSize: 15, fontWeight: FontWeight.w700),
                      ),
                      TextSpan(
                        text: 'Papers',
                        style: PreMedTextTheme().heading5.copyWith(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            trailing: IconButton(
              icon: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Provider.of<PreMedProvider>(context).isPreMed
                    ? PreMedColorTheme().primaryColorRed
                    : PreMedColorTheme().blue,
              ),
              onPressed: () {
                _openBottomSheet(context, deckGroup, deckGroupName);
              },
            ),
          ),
        ),
      ),
    );
  }

  
  List<DeckItem> _getDecksWithBothPracticeAndPastPaper(List<DeckItem> deckItems) {
    final Map<String, List<DeckItem>> groupedDeckItems = {};

    
    for (final item in deckItems) {
      final String baseDeckName = _cleanDeckName(item.deckName);
      if (!groupedDeckItems.containsKey(baseDeckName)) {
        groupedDeckItems[baseDeckName] = [];
      }
      groupedDeckItems[baseDeckName]!.add(item);
    }

    final List<DeckItem> uniqueDeckItems = [];
    groupedDeckItems.forEach((baseName, deckItems) {
      bool hasPractice = false;
      bool hasPastPaper = false;

      for (final item in deckItems) {
        if (item.deckName.contains('Practice') && item.isPublished) {
          hasPractice = true;
        } else if (item.deckName.contains('Past Paper') && item.isPublished) {
          hasPastPaper = true;
        }
      }

      
      if (hasPractice && hasPastPaper) {
        
        final deckToDisplay =
        deckItems.firstWhere((item) => item.deckName.contains('Practice'));
        uniqueDeckItems.add(deckToDisplay);
      }
    });

    return uniqueDeckItems;
  }

  
  String _cleanDeckName(String deckName) {
    return deckName
        .replaceAll('Past Paper', '')
        .replaceAll('Practice', '')
        .trim();
  }
}

void _openBottomSheet(
    BuildContext context, DeckGroupModel deckGroup, String qbankgroupName) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
    ),
    backgroundColor: Colors.white,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return NewBottomSheet(
        subject: deckGroup.deckGroupName,
        deckGroup: deckGroup,
        bankOrMock: 'Bank',
        category: qbankgroupName,
      );
    },
  );
}
