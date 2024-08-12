import 'package:premedpk_mobile_app/providers/vaultProviders/premed_provider.dart';
import 'package:provider/provider.dart';

import '../../../../constants/constants_export.dart';
import '../../../../models/deck_group_model.dart';
import '../../mocks/widgets/bottom_sheet.dart';
import 'logo_avatar.dart';

class DeckTile extends StatelessWidget {
  const DeckTile(
      {super.key, required this.deckGroup, required this.deckGroupName});
  final DeckGroupModel deckGroup;
  final String deckGroupName;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
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
              ),
              SizedBoxes.vertical2Px,
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '${deckGroup.deckNameCount} ',
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
            icon: Icon(Icons.arrow_forward_ios_rounded,
                color: Provider.of<PreMedProvider>(context).isPreMed ? PreMedColorTheme().primaryColorRed : PreMedColorTheme().blue),
            onPressed: () {
              _openBottomSheet(context, deckGroup, deckGroupName);
            },
          ),
        ),
      ),
    );
  }
}

void _openBottomSheet(
    BuildContext context, DeckGroupModel deckGroup, qbankgroupName) {
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
      return CustomBottomSheet(
        deckGroup: deckGroup,
        bankOrMock: 'Bank',
        category: qbankgroupName,
      );
    },
  );
}
