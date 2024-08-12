import 'package:premedpk_mobile_app/UI/screens/The%20vault/widgets/topical%20guides/toical%20guide%20reel%20view.dart';
import 'package:provider/provider.dart';
import '../../../../constants/constants_export.dart';
import '../../../../providers/vaultProviders/study_guides_prroviderr.dart';
import '../../../../providers/vaultProviders/study_notes_proivders.dart';

class TopicalGuidesPage extends StatelessWidget {
  const TopicalGuidesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<VaultTopicalGuidesProvider>(context, listen: false);

    return FutureBuilder(
      future: provider.fetchNotess(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: Padding(
            padding: EdgeInsets.only(top: 20),
            child: CircularProgressIndicator(),
          ));
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return Container(
            height: 83,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  offset: const Offset(0, 20),
                  blurRadius: 40, //
                ),
              ],
            ),
            child: GuidesOrNotesDisplay(
              notesCategory: 'Topical Guides',
              notes: provider.vaultNotesList,
              isLoading: provider.vaultnotesLoadingstatus == NotesStatus.fetching,
            ),
          );
        }
      },
    );
  }
}

//for StudyNotes
class StudyNotesPage extends StatelessWidget {
  const StudyNotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<VaultStudyNotesProvider>(context, listen: false);

    return FutureBuilder(
      future: provider.fetchNotess(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: Padding(
            padding: EdgeInsets.only(top: 20),
            child: CircularProgressIndicator(),
          ));
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return Container(
            height: 83,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  offset: const Offset(0, 20),
                  blurRadius: 40, //
                ),
              ],
            ),
            child: GuidesOrNotesDisplay(
              notes: provider.vaultNotesList,
              isLoading: provider.vaultnotesLoadingstatus == Status.fetching,
              notesCategory: 'Study Notes',
            ),
          );
        }
      },
    );
  }
}
