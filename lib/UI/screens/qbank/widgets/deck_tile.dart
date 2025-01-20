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
      child: GestureDetector(
        onTap: () {
          _openBottomSheet(context, deckGroup, deckGroupName);
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double height = constraints.maxWidth < 360 ? 130 : 108;

            return Container(
              height: height,
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
              child: Column(
                children: [
                  Expanded(
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      leading: GetLogo(url: deckGroup.deckGroupImage ?? ''),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            deckGroup.deckGroupName,
                            style: PreMedTextTheme()
                                .heading3
                                .copyWith(fontWeight: FontWeight.w800, fontSize: 18),

                          ),
                          SizedBoxes.vertical5Px, // Slightly larger spacing
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: '${deckGroup.deckNameCount} ',
                                  style: PreMedTextTheme()
                                      .heading5
                                      .copyWith(fontSize: 14, fontWeight: FontWeight.w700),
                                ),
                                TextSpan(
                                  text: 'Papers',
                                  style: PreMedTextTheme().heading5.copyWith(fontSize: 14),
                                ),
                              ],
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
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
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

void _openBottomSheet(
    BuildContext context, DeckGroupModel deckGroup, String deckGroupName) {
  final String bankOrMock = deckGroupName.toLowerCase().contains('mocks') ? 'Mock' : 'Bank';

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
        subject: deckGroup.deckGroupName,
        deckGroup: deckGroup,
        bankOrMock: bankOrMock,
        category: deckGroupName,
      );
    },
  );
}
