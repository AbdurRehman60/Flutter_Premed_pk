import 'package:premedpk_mobile_app/providers/vaultProviders/engineeringProviders/eng_study_notes_provider.dart';
import 'package:provider/provider.dart';
import '../../../../../constants/constants_export.dart';
import '../../widgets/guideorNotesReelCard.dart';
import '../../widgets/topical guides/toical guide reel view.dart';

class PreEngStudyNotesPage extends StatelessWidget {
  const PreEngStudyNotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider =
    Provider.of<EngineeringStudyNotesProvider>(context, listen: false);

    return FutureBuilder(
      future: provider.fetchNotess(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return GuidesOrNotesDisplay(
            notes: provider.vaultNotesList,
            isLoading: provider.vaultnotesLoadingstatus == Status.fetching,
            notesCategory: 'Study Notes',
          );
        }
      },
    );
  }
}
