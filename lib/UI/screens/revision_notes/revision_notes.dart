import 'package:premedpk_mobile_app/UI/widgets/global_widgets_export.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/notes_provider.dart';
import 'package:provider/provider.dart';

class RevisionNotes extends StatelessWidget {
  const RevisionNotes({super.key});

  @override
  Widget build(BuildContext context) {
    NotesProvider notesProvider =
        Provider.of<NotesProvider>(context, listen: false);
    notesProvider.fetchNotes();

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 32,
                    width: 32,
                    child: Image.asset(
                      PremedAssets.RevisionNotes,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBoxes.horizontalMedium,
                  Text(
                    'Revision Notes',
                    style: PreMedTextTheme()
                        .heading6
                        .copyWith(color: PreMedColorTheme().white),
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(
                  Icons.search,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PdfSearch(
                        notesList: notesProvider.notesList,
                      ),
                    ),
                  );
                },
              )
            ],
          ),
          bottom: const TabBar(
            isScrollable: true, // Make tabs scrollable
            tabs: [
              Tab(text: 'All'),
              Tab(text: 'Biology'),
              Tab(text: 'Chemistry'),
              Tab(text: 'Physics'),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(8, 16, 8, 0),
          child: Consumer<NotesProvider>(
            builder: (context, notesProvider, _) {
              bool isLoading =
                  notesProvider.notesLoadingStatus == Status.Fetching;
              return TabBarView(
                children: [
                  PdfDisplay(
                    notes: notesProvider.notesList,
                    isLoading: isLoading,
                  ),
                  PdfDisplay(
                    notes: notesProvider.notesList
                        .where((note) => note.subject == 'Biology')
                        .toList(),
                    isLoading: isLoading,
                  ),
                  PdfDisplay(
                    notes: notesProvider.notesList
                        .where((note) => note.subject == 'Chemistry')
                        .toList(),
                    isLoading: isLoading,
                  ),
                  PdfDisplay(
                    notes: notesProvider.notesList
                        .where((note) => note.subject == 'Physics')
                        .toList(),
                    isLoading: isLoading,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
