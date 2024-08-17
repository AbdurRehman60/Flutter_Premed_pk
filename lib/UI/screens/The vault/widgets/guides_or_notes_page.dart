import 'package:premedpk_mobile_app/UI/screens/The%20vault/widgets/topical%20guides/toical%20guide%20reel%20view.dart';
import 'package:premedpk_mobile_app/providers/vaultProviders/premed_access_provider.dart';
import 'package:provider/provider.dart';
import '../../../../constants/constants_export.dart';
import '../../../../providers/vaultProviders/study_guides_prroviderr.dart';
import '../../../../providers/vaultProviders/study_notes_proivders.dart';
class TopicalGuidesPage extends StatefulWidget {
  const TopicalGuidesPage({super.key});

  @override
  _TopicalGuidesPageState createState() => _TopicalGuidesPageState();
}

class _TopicalGuidesPageState extends State<TopicalGuidesPage> {
  late Future<void> _fetchNotesFuture;

  @override
  void initState() {
    super.initState();
    _fetchNotesFuture = Future.microtask(() async {
      final provider = context.read<VaultTopicalGuidesProvider>();
      await provider.fetchNotess();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<VaultTopicalGuidesProvider,PreMedAccessProvider>(
      builder: (context, provider, preMedAccessPro, child) {
        return FutureBuilder<void>(
          future: _fetchNotesFuture,
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
                      blurRadius: 40,
                    ),
                  ],
                ),
                child: GuidesOrNotesDisplay(
                  hasAccess: preMedAccessPro.hasNotes,
                  notesCategory: 'Topical Guides',
                  notes: provider.vaultNotesList,
                  isLoading: provider.vaultnotesLoadingstatus == NotesStatus.fetching,
                ),
              );
            }
          },
        );
      },
    );
  }
}



//for StudyNotes
class StudyNotesPage extends StatefulWidget {
  const StudyNotesPage({super.key});

  @override
  _StudyNotesPageState createState() => _StudyNotesPageState();
}

class _StudyNotesPageState extends State<StudyNotesPage> {
  late Future<void> _fetchNotesFuture;

  @override
  void initState() {
    super.initState();
    _fetchNotesFuture = Future.microtask(() async {
      final provider = context.read<VaultStudyNotesProvider>();
      await provider.fetchNotess();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<VaultStudyNotesProvider, PreMedAccessProvider>(
      builder: (context, studyNotesProvider, preMedAccessProvider, child) {
        return FutureBuilder<void>(
          future: _fetchNotesFuture,
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
                      blurRadius: 40,
                    ),
                  ],
                ),
                child: GuidesOrNotesDisplay(
                  hasAccess: preMedAccessProvider.hasNotes,
                  notes: studyNotesProvider.vaultNotesList,
                  isLoading: studyNotesProvider.vaultnotesLoadingstatus == Status.fetching,
                  notesCategory: 'Study Notes',
                ),
              );
            }
          },
        );
      },
    );
  }
}

