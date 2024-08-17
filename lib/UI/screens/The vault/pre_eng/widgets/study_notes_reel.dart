import 'package:premedpk_mobile_app/providers/vaultProviders/engineeringProviders/eng_study_notes_provider.dart';
import 'package:provider/provider.dart';
import '../../../../../constants/constants_export.dart';
import '../../../../../providers/vaultProviders/engineeringProviders/engineering_access_providers.dart';
import '../../widgets/topical guides/toical guide reel view.dart';

class PreEngStudyNotesPage extends StatefulWidget {
  const PreEngStudyNotesPage({super.key});

  @override
  _PreEngStudyNotesPageState createState() => _PreEngStudyNotesPageState();
}

class _PreEngStudyNotesPageState extends State<PreEngStudyNotesPage> {
  late Future<void> _fetchNotesFuture;

  @override
  void initState() {
    super.initState();
    _fetchNotesFuture = Future.microtask(() async {
      final provider = context.read<EngineeringStudyNotesProvider>();
      await provider.fetchNotess();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<EngineeringStudyNotesProvider, PreEngAccessProvider>(
      builder: (context, studyNotesProvider, accessProvider, child) {
        return FutureBuilder<void>(
          future: _fetchNotesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: PreMedColorTheme().blue,
                ),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return GuidesOrNotesDisplay(
                hasAccess: accessProvider.hasEngNotes,
                notes: studyNotesProvider.vaultNotesList,
                isLoading: studyNotesProvider.vaultnotesLoadingstatus == Status.fetching,
                notesCategory: 'Study Notes',
              );
            }
          },
        );
      },
    );
  }
}

