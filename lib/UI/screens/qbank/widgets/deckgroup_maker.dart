import '../../../../constants/constants_export.dart';
import '../../../../models/deck_group_model.dart';
import '../../mocks/widgets/bottom_sheet.dart';
import 'logo_avatar.dart';

class DeckGroupList extends StatelessWidget {

  const DeckGroupList({super.key, required this.deckGroups, required this.qbankGroupname});
  final List<DeckGroupModel> deckGroups;
  final String qbankGroupname;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: deckGroups.length,
      itemBuilder: (context, index) {
        final deckGroup = deckGroups[index];
        return Container(
          height: 110,
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: ListTile(
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
                          style: PreMedTextTheme().heading5.copyWith(
                              fontSize: 15, fontWeight: FontWeight.w700),
                        ),
                        TextSpan(
                          text: 'Papers',
                          style:
                              PreMedTextTheme().heading5.copyWith(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              trailing: IconButton(
                icon: Icon(Icons.arrow_forward_ios_rounded,
                    color: PreMedColorTheme().primaryColorRed),
                onPressed: () {
                  _openBottomSheet(context, deckGroup,qbankGroupname);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

void _openBottomSheet(BuildContext context, DeckGroupModel deckGroup, qbankgroupName) {
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
      return CustomBottomSheet(deckGroup: deckGroup,bankOrMock: 'Bank', category: qbankgroupName,);
    },
  );
}
