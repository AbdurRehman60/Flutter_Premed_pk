import 'package:premedpk_mobile_app/UI/screens/The%20vault/screens/vaultpdfview.dart';
import 'package:premedpk_mobile_app/UI/screens/The%20vault/widgets/guideorNotesReelCard.dart';
import 'package:premedpk_mobile_app/models/cheatsheetModel.dart';
import '../../../../../constants/constants_export.dart';

class GuidesOrNotesDisplay extends StatelessWidget {
  const GuidesOrNotesDisplay({
    super.key,
    required this.notes,
    required this.isLoading,
    required this.notesCategory,
  });
  final List<VaultNotesModel> notes;
  final bool isLoading;
  final String notesCategory;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: notes.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(right: 13),
        child: GuideOrNotesCard(
          vaultNotesModel: notes[index],
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => VaultPdfViewer(vaultNotesModel: notes[index],notesCategory: notesCategory,)));
          },
        ),
      ),
    );
  }
}
